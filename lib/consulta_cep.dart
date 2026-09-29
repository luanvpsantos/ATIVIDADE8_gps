
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConsultaCep extends StatefulWidget {
  const ConsultaCep({super.key});

  @override
  State<ConsultaCep> createState() => _ConsultaCepState();
}

class _ConsultaCepState extends State<ConsultaCep> {
  final cepController = TextEditingController();

  String resultado = '';
  bool carregando = false;

  Future<void> consultarCep() async {
    String cep = cepController.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    if (cep.length != 8) {
      setState(() {
        resultado = 'Digite um CEP válido com 8 números.';
      });
      return;
    }

    setState(() {
      carregando = true;
      resultado = '';
    });

    try {
      final resposta = await http.get(
        Uri.parse('https://viacep.com.br/ws/$cep/json/'),
      );

      if (resposta.statusCode == 200) {
        final dados = jsonDecode(resposta.body);

        if (dados['erro'] == true) {
          resultado = 'CEP não encontrado.';
        } else {
          resultado =
              'CEP: ${dados['cep']}\n'
              'Logradouro: ${dados['logradouro']}\n'
              'Bairro: ${dados['bairro']}\n'
              'Cidade: ${dados['localidade']}\n'
              'Estado: ${dados['uf']}';
        }
      } else {
        resultado = 'Erro ao consultar o CEP.';
      }
    } catch (e) {
      resultado = 'Não foi possível conectar à API.';
    }

    if (mounted) {
      setState(() {
        carregando = false;
      });
    }
  }

  @override
  void dispose() {
    cepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6F3D19),
      appBar: AppBar(
        title: const Text('Consulta de CEP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite o CEP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: carregando ? null : consultarCep,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF196F3D),
                foregroundColor: Colors.white,
              ),
              child: const Text('Consultar'),
            ),
            const SizedBox(height: 20),
            if (carregando)
              const CircularProgressIndicator(),
            Text(
              resultado,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}