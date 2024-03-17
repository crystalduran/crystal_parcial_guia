import 'package:crystal_examen_2/screens/evento_details.dart';
import 'package:flutter/material.dart';
import '../models/evento.dart';
import '../services/database_helper.dart';
import '../widgets/evento_widget.dart';
import 'registro_evento_screen.dart';
import 'package:crystal_examen_2/widgets/navbar.dart';

class EventosScreen extends StatefulWidget {
  const EventosScreen({Key? key}) : super(key: key);

  @override
  State<EventosScreen> createState() => _EventosScreenState();
}

class _EventosScreenState extends State<EventosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            width: 100,
          height: 40,
        ),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
          MaterialPageRoute(builder: (context) => RegistroEventoScreen()));
          setState(() {});
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<Evento>?>(
        future: DatabaseHelper.getAllEventos(),
        builder: (context, AsyncSnapshot<List<Evento>?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if(snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) => EventoWidget(
                  evento: snapshot.data![index],
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetallesEventoScreen(
                          evento: snapshot.data![index],
                        )));
                    setState(() {});
                  },
              ),
              itemCount: snapshot.data!.length,
            );
          }
          return const Center(
            child: Text('Aun no hay eventos'),
          );
        }
      ),
    );
  }
}