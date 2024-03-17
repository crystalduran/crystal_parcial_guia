import 'package:flutter/material.dart';
import 'package:crystal_examen_2/models/evento.dart';
import 'package:intl/intl.dart';

class EventoWidget extends StatelessWidget {
  final Evento evento;
  final VoidCallback onTap;

  const EventoWidget({Key? key,
    required this.evento,
    required this.onTap
  }) : super(key: key);

  //El widget utiliza un InkWell como contenedor principal para permitir interacciones táctiles.
  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evento.titulo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Descripcion: ${evento.descripcion}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Fecha: ${DateFormat('yyyy-MM-dd HH:mm').format(evento.createdAt)}'
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}