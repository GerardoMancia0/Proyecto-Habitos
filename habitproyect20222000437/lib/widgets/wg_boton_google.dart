import 'package:flutter/material.dart';
import 'package:habitproyect20222000437/Services/servicio_autenticacion.dart';
import 'package:provider/provider.dart';

class WgBotonGoogle extends StatelessWidget {
  const WgBotonGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Colors.grey),
        ),
        elevation: 2,
      ),
      icon: Image.asset('assets/google_logo.png', height: 24, width: 24),
      label: const Text(
        'Continuar con Google',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onPressed: () async {
        final servicio = context.read<ServicioAutenticacion>();
        final user = await servicio.iniciarSesionConGoogle();

        if (user != null && context.mounted) {
          Navigator.pushReplacementNamed(context, '/principal');
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error al iniciar sesión con Google'),
              ),
            );
          }
        }
      },
    );
  }
}
