import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crystal_examen_2/models/evento.dart';
import 'package:crystal_examen_2/services/database_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crystal_examen_2/widgets/navbar.dart';

class RegistroEventoScreen extends StatefulWidget {
  final Evento? evento;
  RegistroEventoScreen({Key? key, this.evento}) : super(key: key);

  @override
  _RegistroEventoScreenState createState() => _RegistroEventoScreenState();
}

class _RegistroEventoScreenState extends State<RegistroEventoScreen> {
  final tituloController = TextEditingController();
  final descripcionController = TextEditingController();
  String? byte64String;  // Variable para almacenar la imagen como una cadena Base64.

  @override
  void initState() {
    super.initState();
    // Si se proporciona un evento, inicializa los campos con sus valores.
    if (widget.evento != null) {
      tituloController.text = widget.evento!.titulo;
      descripcionController.text = widget.evento!.descripcion;
      byte64String = widget.evento!.image64bit;
    }
  }
  // Método para seleccionar una imagen desde la galería.
  Future<void> pickImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 45,
    );
    if (image != null) {
      var imageBytes = await image.readAsBytes();
      setState(() {
        byte64String = base64Encode(imageBytes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.evento == null ? 'Agregar evento' : 'Editar evento',
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
                      color: Colors.white,
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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: pickImage,
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
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

                    if (titulo.isEmpty || descripcion.isEmpty) {
                      return;
                    }
                    final createdAt = widget.evento?.createdAt ?? DateTime.now();
                    final Evento model = Evento(
                      id: widget.evento?.id,
                      createdAt: createdAt,
                      titulo: titulo,
                      descripcion: descripcion,
                      image64bit: byte64String,
                    );
                    if (widget.evento == null) {
                      await DatabaseHelper.insertEvento(model);
                    } else {
                      await DatabaseHelper.updateEvento(model);
                    }
                    Navigator.pop(context, model);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 0.75),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    widget.evento == null ? 'Agregar' : 'Editar',
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
