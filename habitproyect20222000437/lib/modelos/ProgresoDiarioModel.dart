import 'package:cloud_firestore/cloud_firestore.dart';

class ProgresoDiarioModel {
  final String? fcid;
  final int fiMinutosRealizados;
  final bool fbCompletado;
  final DateTime fdFecha;

  ProgresoDiarioModel({
    this.fcid,
    required this.fiMinutosRealizados,
    required this.fbCompletado,
    required this.fdFecha,
  });

  factory ProgresoDiarioModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProgresoDiarioModel(
      fcid: doc.id,
      fiMinutosRealizados: data['fiMinutosRealizados'] ?? 0,
      fbCompletado: data['fbCompletado'] ?? false,
      fdFecha: DateTime.parse(doc.id),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fiMinutosRealizados': fiMinutosRealizados,
      'fbCompletado': fbCompletado,
    };
  }
}
