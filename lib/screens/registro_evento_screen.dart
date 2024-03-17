import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:crystal_examen_2/models/evento.dart';
import 'package:crystal_examen_2/services/database_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crystal_examen_2/widgets/navbar.dart';

class RegistroEventoScreen extends StatelessWidget {
  final Evento? evento;
  RegistroEventoScreen({Key? key, this.evento}) : super(key: key);
  final tituloController = TextEditingController();
  final descripcionController = TextEditingController();

  Future<String> pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 45);
    var imageBytes = await image!.readAsBytes();
    print("image picked: ${image.path}");

    String base64image = base64Encode(imageBytes);
    return base64image;
  }

  String? byte64String;

  @override
  Widget build(BuildContext context) {
    if(evento != null) {
      tituloController.text = evento!.titulo;
      descripcionController.text = evento!.descripcion;
      byte64String = evento!.image64bit;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          evento == null ? 'Agregar evento' : 'Editar evento',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: tituloController,
                decoration: const InputDecoration(
                  hintText: 'Titulo',
                  labelText: 'Titulo del evento',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: descripcionController,
              decoration: const InputDecoration(
                hintText: 'Descripcion',
                labelText: 'Descripcion del evento',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                byte64String = await pickImage();
                print("byt6 64 string: $byte64String");
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Color rojo
                onPrimary: Colors.white, // Texto en blanco
              ),
              child: const Text("Elegir Imagen"),
            ),
            Text(
              byte64String != null ? 'Imagen seleccionada en el formulario' : '',
              style: TextStyle(color: Colors.green),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    final titulo = tituloController.value.text;
                    final descripcion = descripcionController.value.text;

                    if(titulo.isEmpty || descripcion.isEmpty){
                      return;
                    }
                    final createdAt = evento?.createdAt ?? DateTime.now(); // Si no hay evento, usa la fecha actual
                    final Evento model = Evento(id: evento?.id, createdAt: createdAt, titulo: titulo, descripcion: descripcion, image64bit: byte64String);
                    if(evento == null) {
                      await DatabaseHelper.insertEvento(model);
                    } else {
                      await DatabaseHelper.updateEvento(model);
                    }
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Color de fondo rojo
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Color de texto blanco
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 0.75),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    evento == null ? 'Agregar' : 'Editar',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
