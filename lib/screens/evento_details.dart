import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:crystal_examen_2/models/evento.dart';
import 'registro_evento_screen.dart';

class DetallesEventoScreen extends StatefulWidget {
  final Evento evento;

  const DetallesEventoScreen({Key? key, required this.evento}) : super(key: key);

  @override
  _DetallesEventoScreenState createState() => _DetallesEventoScreenState();
}

class _DetallesEventoScreenState extends State<DetallesEventoScreen> {
  late Evento _evento; // Cambiado a un campo mutable

  @override
  void initState() {
    super.initState();
    _evento = widget.evento; // Inicializa el campo mutable con el evento pasado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles del Evento',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Título: ${_evento.titulo}', // Usa el evento mutable
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              'Descripción: ${_evento.descripcion}', // Usa el evento mutable
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(
              'Fecha: ${_evento.createdAt}', // Usa el evento mutable
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(height: 16),
            if (_evento.image64bit != null)
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.memory(
                  Base64Decoder().convert(_evento.image64bit!),
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistroEventoScreen(evento: _evento)),
                    ).then((result) {
                      // Verificar si se han guardado cambios y actualizar el estado
                      if (result != null && result is Evento) {
                        setState(() {
                          _evento = result;
                        });
                      }
                    });
                  },
                  child: Text(
                    'Editar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
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
