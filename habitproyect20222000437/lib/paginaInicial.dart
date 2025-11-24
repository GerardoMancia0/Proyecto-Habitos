import 'package:flutter/material.dart';

class PaginaInicialView extends StatefulWidget {
  const PaginaInicialView({super.key});

  @override
  State<PaginaInicialView> createState() => _PaginaInicialViewState();
}

class _PaginaInicialViewState extends State<PaginaInicialView> {
  // Future<void> _checkUserStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   bool fbUsuarioLogueado = prefs.containsKey('userEmail');

  //   if (fbUsuarioLogueado) {
  //     print('Estado del Usuario $fbUsuarioLogueado');
  //     Get.offAllNamed('/homepage');
  //   } else {
  //     print('Estado del Usuario $fbUsuarioLogueado');
  //     Get.offAllNamed('/onboarding');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
