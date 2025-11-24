import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioModel {
  final String fcUid;
  final String fcEmail;
  final String fcNombre;
  final String? fcFotoPerfil;
  final Timestamp? fdFechaCreacion;

  UsuarioModel({
    required this.fcUid,
    required this.fcEmail,
    required this.fcNombre,
    this.fcFotoPerfil,
    this.fdFechaCreacion,
  });

  // Convertir a mapa para guardar en Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'fcUid': fcUid,
      'fcEmail': fcEmail,
      'fcNombre': fcNombre,
      if (fcFotoPerfil != null) 'fcFotoPerfil': fcFotoPerfil,
      if (fdFechaCreacion != null) 'fdFechaCreacion': fdFechaCreacion,
    };
  }

  // Crear desde Firestore
  factory UsuarioModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UsuarioModel(
      fcUid: data['fcUid'] ?? doc.id,
      fcEmail: data['fcEmail'] ?? '',
      fcNombre: data['fcNombre'] ?? 'Usuario',
      fcFotoPerfil: data['fcFotoPerfil'],
      fdFechaCreacion: data['fdFechaCreacion'],
    );
  }
}
