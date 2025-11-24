import 'package:flutter/material.dart';
import 'package:habitproyect20222000437/Services/firestoreService.dart';
import 'package:habitproyect20222000437/modelos/habitModel.dart';

class PantallaCrearHabito extends StatefulWidget {
  const PantallaCrearHabito({Key? key}) : super(key: key);

  @override
  State<PantallaCrearHabito> createState() => _PantallaCrearHabitoState();
}

class _PantallaCrearHabitoState extends State<PantallaCrearHabito> {
  final _formKey = GlobalKey<FormState>();
  final _fcNombreCtrl = TextEditingController();
  final _fcDescripcionCtrl = TextEditingController();
  int _fiMinutosObjetivo = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Hábito')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fcNombreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre del hábito',
                ),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _fcDescripcionCtrl,
                decoration: const InputDecoration(
                  labelText: 'Descripción (opcional)',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Minutos objetivo: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  DropdownButton<int>(
                    value: _fiMinutosObjetivo,
                    items: [10, 15, 20, 25, 30, 45, 60].map((min) {
                      return DropdownMenuItem(
                        value: min,
                        child: Text('$min min'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _fiMinutosObjetivo = val!),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final nuevoHabito = HabitModel(
                      fcid: '',
                      fcNombre: _fcNombreCtrl.text.trim(),
                      fcDescripcion: _fcDescripcionCtrl.text.trim(),
                      fiMinutosObjetivo: _fiMinutosObjetivo,
                      fdFechaCreacion: DateTime.now(),
                    );

                    await ServicioFirestore().crearHabito(nuevoHabito);
                    if (mounted) Navigator.pop(context);
                  }
                },
                child: const Text('Crear Hábito'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
