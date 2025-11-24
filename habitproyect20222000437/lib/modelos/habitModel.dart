import 'package:cloud_firestore/cloud_firestore.dart';

class HabitModel {
  String? fcid;
  final String fcNombre;
  final String fcDescripcion;
  final int fiMinutosObjetivo;
  final DateTime fdFechaCreacion;
  final int fiRachaActual;
  final int fiMejorRacha;
  final DateTime? fdUltimaFechaCompletada;

  HabitModel({
    this.fcid,
    required this.fcNombre,
    required this.fcDescripcion,
    required this.fiMinutosObjetivo,
    required this.fdFechaCreacion,
    this.fiRachaActual = 0,
    this.fiMejorRacha = 0,
    this.fdUltimaFechaCompletada,
  });

  factory HabitModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return HabitModel(
      fcid: doc.id,
      fcNombre: data['fcNombre'] ?? '',
      fcDescripcion: data['fcDescripcion'] ?? '',
      fiMinutosObjetivo: data['fiMinutosObjetivo'] ?? 30,
      fdFechaCreacion: (data['fdFechaCreacion'] as Timestamp).toDate(),
      fiRachaActual: data['fiRachaActual'] ?? 0,
      fiMejorRacha: data['fiMejorRacha'] ?? 0,
      fdUltimaFechaCompletada: data['fdUltimaFechaCompletada'] != null
          ? (data['fdUltimaFechaCompletada'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fcNombre': fcNombre,
      'fcDescripcion': fcDescripcion,
      'fiMinutosObjetivo': fiMinutosObjetivo,
      'fdFechaCreacion': Timestamp.fromDate(fdFechaCreacion),
      'fiRachaActual': fiRachaActual,
      'fiMejorRacha': fiMejorRacha,
      if (fdUltimaFechaCompletada != null)
        'fdUltimaFechaCompletada': Timestamp.fromDate(fdUltimaFechaCompletada!),
    };
  }
}
