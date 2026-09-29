
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConsultaCnpj extends StatefulWidget {
  const ConsultaCnpj({super.key});

  @override
  State<ConsultaCnpj> createState() => _ConsultaCnpjState();
}

class _ConsultaCnpjState extends State<ConsultaCnpj> {
  final cnpjController = TextEditingController();

  Map<String, dynamic>? dados;
  String erro = '';
  bool carregando = false;

  Future<void> consultarCnpj() async {
    String cnpj = cnpjController.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    if (cnpj.length != 14) {
      setState(() {
        erro = 'Digite um CNPJ com 14 números.';
        dados = null;
      });
      return;
    }

    setState(() {
      carregando = true;
      erro = '';
      dados = null;
    });

    try {
      final resposta = await http.get(
        Uri.parse('https://api.opencnpj.org/$cnpj'),
      );

      if (resposta.statusCode == 200) {
        final resultado = jsonDecode(resposta.body);

        if (resultado is Map<String, dynamic>) {
          dados = resultado;
        } else {
          erro = 'Resposta inesperada da API.';
        }
      } else {
        erro = 'CNPJ não encontrado ou erro na consulta.';
      }
    } catch (e) {
      erro = 'Não foi possível conectar à API.';
    }

    if (mounted) {
      setState(() {
        carregando = false;
      });
    }
  }

  @override
  void dispose() {
    cnpjController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6F3D19),
      appBar: AppBar(
        title: const Text('Consulta de CNPJ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: cnpjController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite o CNPJ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: carregando ? null : consultarCnpj,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3D196F),
                foregroundColor: Colors.white,
              ),
              child: const Text('Consultar'),
            ),
            const SizedBox(height: 20),
            if (carregando)
              const CircularProgressIndicator(),
            if (erro.isNotEmpty)
              Text(
                erro,
                style: const TextStyle(color: Colors.red),
              ),
            if (dados != null)
              Expanded(
                child: ListView(
                  children: dados!.entries.map((item) {
                    return Card(
                      child: ListTile(
                        title: Text(item.key),
                        subtitle: Text(
                          item.value?.toString() ?? 'Não informado',
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}