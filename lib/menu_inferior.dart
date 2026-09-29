
import 'package:flutter/material.dart';
import 'package:gps_08/consulta_gps.dart';
import 'consulta_cep.dart';
import 'consulta_cnpj.dart';
import 'cotacao_dolar.dart';
import 'trabalho.dart';

class MenuInferior extends StatelessWidget {
  const MenuInferior({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6F3D19),
      appBar: AppBar(
        title: const Text('Tela Principal'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF196F3D),
              ),
              child: Text(
                'Menu do Sistema',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Principal'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Consulta de CEP'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConsultaCep(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Consulta de CNPJ'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConsultaCnpj(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Cotação do Dólar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CotacaoDolar(),
                  ),
                );
              },
            ),

            ListTile(
              title: const Text('Localização'),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
               builder: (context) => const Localizacao(),
              ),
            );
           },
          ),

            ListTile(
              title: const Text('Trabalho'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Trabalho(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Sair / Logout'),
              onTap: () {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sejam Bem Vindos!!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF196F3D),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Escolha uma opção no menu lateral.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3D196F),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Trabalho(),
                    ),
                  );
                },
                child: const Text('Acessar Trabalho'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}