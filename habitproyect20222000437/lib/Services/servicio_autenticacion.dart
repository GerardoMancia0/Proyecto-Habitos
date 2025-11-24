import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habitproyect20222000437/modelos/UsuarioModel.dart';

class ServicioAutenticacion {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream para escuchar cambios de autenticación
  Stream<User?> get streamUsuario => _auth.authStateChanges();

  // Usuario actual
  User? get usuarioActual => _auth.currentUser;

  // Iniciar sesión con Google
  Future<User?> iniciarSesionConGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // El usuario canceló

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      final User? user = userCredential.user;

      if (user != null) {
        // Crear o actualizar el documento del usuario en Firestore
        await _crearOActualizarUsuario(user);
      }

      return user;
    } catch (e) {
      print("Error en Google Sign-In: $e");
      return null;
    }
  }

  // Cerrar sesión
  Future<void> cerrarSesion() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Crear usuario en Firestore si es la primera vez
  Future<void> _crearOActualizarUsuario(User user) async {
    final docRef = _firestore.collection('users').doc(user.uid);

    final usuarioExistente = await docRef.get();
    if (!usuarioExistente.exists) {
      final nuevoUsuario = UsuarioModel(
        fcUid: user.uid,
        fcEmail: user.email ?? '',
        fcNombre: user.displayName ?? 'Usuario',
        fcFotoPerfil: user.photoURL,
        fdFechaCreacion: Timestamp.now(),
      );

      await docRef.set(nuevoUsuario.toFirestore());
    }
  }
}
