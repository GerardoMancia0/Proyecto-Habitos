import 'package:flutter/material.dart';
import 'package:habitproyect20222000437/Services/firestoreService.dart';
import 'package:habitproyect20222000437/Services/servicio_autenticacion.dart';
import 'package:habitproyect20222000437/modelos/habitModel.dart';
import 'package:habitproyect20222000437/screen/PantallaCrearHabito.dart';
import 'package:provider/provider.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<ServicioAutenticacion>(context);
    final firestore = ServicioFirestore();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Hábitos - Reto 30 Días'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.cerrarSesion();
            },
          ),
        ],
      ),
      body: StreamBuilder<List<HabitModel>>(
        stream: firestore.streamHabitos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar hábitos'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final habitos = snapshot.data!;

          if (habitos.isEmpty) {
            return const Center(
              child: Text(
                '¡Crea tu primer hábito!\nToca el botón +',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: habitos.length,
            itemBuilder: (context, index) {
              final habit = habitos[index];
              return WgTarjetaHabito(habit: habit);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PantallaCrearHabito()),
          );
        },
      ),
    );
  }
}
