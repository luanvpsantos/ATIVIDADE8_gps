
import 'package:flutter/material.dart';

class Trabalho extends StatefulWidget {
  const Trabalho({super.key});

  @override
  State<Trabalho> createState() => _TrabalhoState();
}

class _TrabalhoState extends State<Trabalho> {
  int paginaSelecionada = 0;

  final List<String> titulos = [
    'Início',
    'Serviços',
    'Perfil',
  ];

  final List<String> textos = [
    'Bem-vindo à tela de Trabalho!',
    'Aqui ficam os serviços do sistema.',
    'Esta é a tela de Perfil.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6F3D19),
      appBar: AppBar(
        title: Text(titulos[paginaSelecionada]),
      ),
      body: Center(
        child: Text(
          textos[paginaSelecionada],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            color: Color(0xFF3D196F),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaSelecionada,
        selectedItemColor: const Color(0xFF6F3D19),
        unselectedItemColor: const Color(0xFF6F3D19),
        onTap: (index) {
          setState(() {
            paginaSelecionada = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Serviços',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}