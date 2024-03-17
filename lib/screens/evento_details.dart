import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crystal_examen_2/models/evento.dart';
import 'registro_evento_screen.dart';
import 'package:crystal_examen_2/services/database_helper.dart';

class DetallesEventoScreen extends StatelessWidget {
  final Evento evento;

  const DetallesEventoScreen({Key? key, required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Evento',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red, // Color de fondo del app bar rojo
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Título: ${evento.titulo}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black), // Título en negrita y tamaño grande
            ),
            SizedBox(height: 8),
            Text(
              'Descripción: ${evento.descripcion}',
              style: TextStyle(fontSize: 18, color: Colors.black87), // Descripción en un tamaño ligeramente más grande
            ),
            SizedBox(height: 8),
            Text(
              'Fecha: ${evento.createdAt}',
              style: TextStyle(fontSize: 18, color: Colors.black87), // Fecha en un tamaño ligeramente más grande
            ),
            SizedBox(height: 16),
            if (evento.image64bit != null) // Verifica si hay una imagen en base64
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200, // Ajusta el tamaño según sea necesario
                child: Image.memory(
                  Base64Decoder().convert(evento.image64bit!),
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centra el botón de editar
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistroEventoScreen(evento: evento)),
                    );
                  },
                  child: Text(
                    'Editar',
                    style: TextStyle(color: Colors.white), // Texto blanco en el botón
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red), // Fondo rojo en el botón
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
