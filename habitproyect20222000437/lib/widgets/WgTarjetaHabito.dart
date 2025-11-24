import 'package:flutter/material.dart';
import 'package:habitproyect20222000437/modelos/habitModel.dart';

class WgTarjetaHabito extends StatelessWidget {
  final HabitModel habit;
  const WgTarjetaHabito({Key? key, required this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo.shade600,
          child: Text(
            habit.fcNombre.substring(0, 1).toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          habit.fcNombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${habit.fiMinutosObjetivo} minutos • Día ${habit.fiRachaActual + 1}/30',
        ),
        trailing: habit.fiRachaActual >= 29
            ? const Icon(Icons.emoji_events, color: Colors.amber)
            : const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PantallaDetalleHabito(habit: habit),
            ),
          );
        },
      ),
    );
  }
}

class StatelessWidget {}
