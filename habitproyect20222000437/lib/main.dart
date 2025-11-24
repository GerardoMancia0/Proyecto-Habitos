import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habitproyect20222000437/Services/servicio_autenticacion.dart';
import 'package:habitproyect20222000437/screen/LoginPantalla';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const RetoHabitosApp());
}

class RetoHabitosApp extends StatelessWidget {
  const RetoHabitosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<ServicioAutenticacion>(
      create: (_) => ServicioAutenticacion(),
      child: MaterialApp(
        title: 'Reto Hábitos 30 Días',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: 'Roboto'),
        home: const AuthWrapper(),
        routes: {'/principal': (context) => const PantallaPrincipal()},
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<ServicioAutenticacion>(context).streamUsuario,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return snapshot.data != null
              ? const PantallaPrincipal()
              : const PantallaLogin();
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
