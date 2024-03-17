import 'package:flutter/material.dart';
import 'package:crystal_examen_2/screens/registro_evento_screen.dart';
import 'package:crystal_examen_2/screens/eventos_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    RegistroEventoScreen(),
    EventosScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Registro de Evento'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista de Eventos'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.redAccent,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}