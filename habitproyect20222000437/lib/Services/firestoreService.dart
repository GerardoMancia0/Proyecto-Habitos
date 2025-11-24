import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitproyect20222000437/modelos/ProgresoDiarioModel.dart';
import 'package:habitproyect20222000437/modelos/habitModel.dart';

class ServicioFirestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  // Referencia base del usuario
  CollectionReference get _refHabitos =>
      _db.collection('users').doc(_uid).collection('habits');

  // === CREAR HÁBITO ===
  Future<String> crearHabito(HabitModel habit) async {
    final docRef = _refHabitos.doc(); // Genera ID automático
    final nuevoHabito = HabitModel(
      fcid: docRef.id,
      fcNombre: habit.fcNombre,
      fcDescripcion: habit.fcDescripcion,
      fiMinutosObjetivo: habit.fiMinutosObjetivo,
      fdFechaCreacion: DateTime.now(),
    );
    await docRef.set(nuevoHabito.toFirestore());
    return docRef.id;
  }

  // === LISTAR HÁBITOS DEL USUARIO ===
  Stream<List<HabitModel>> streamHabitos() {
    return _refHabitos
        .orderBy('fdFechaCreacion', descending: true)
        .snapshots()
        .map(_habitosFromSnapshot);
  }

  List<HabitModel> _habitosFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return HabitModel.fromFirestore(doc);
    }).toList();
  }

  // === OBTENER PROGRESO DE UN HÁBITO (últimos 30 días) ===
  Stream<List<ProgresoDiarioModel>> streamProgreso30Dias(String habitId) {
    final hoy = DateTime.now();
    final inicio = hoy.subtract(const Duration(days: 29)); // 30 días total

    return _refHabitos
        .doc(habitId)
        .collection('progress')
        .where(
          FieldPath.documentId,
          isGreaterThanOrEqualTo: _formatoFecha(inicio),
        )
        .where(FieldPath.documentId, isLessThanOrEqualTo: _formatoFecha(hoy))
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ProgresoDiarioModel.fromFirestore(doc))
              .toList(),
        );
  }

  // === GUARDAR PROGRESO DIARIO ===
  Future<void> guardarProgresoDiario({
    required String habitId,
    required int minutosRealizados,
    required bool completado,
  }) async {
    final fechaHoy = _formatoFecha(DateTime.now());
    await _refHabitos.doc(habitId).collection('progress').doc(fechaHoy).set({
      'fiMinutosRealizados': minutosRealizados,
      'fbCompletado': completado,
    });
  }

  // === ACTUALIZAR RACHA DEL HÁBITO (lo usaremos después del cronómetro) ===
  Future<void> actualizarRachaHabito(
    String habitId,
    HabitModel habitActualizado,
  ) async {
    await _refHabitos
        .doc(habitId)
        .set(habitActualizado.toFirestore(), SetOptions(merge: true));
  }

  // Formato: 2025-11-24
  String _formatoFecha(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
