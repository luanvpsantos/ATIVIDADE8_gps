
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CotacaoDolar extends StatefulWidget {
  const CotacaoDolar({super.key});

  @override
  State<CotacaoDolar> createState() => _CotacaoDolarState();
}

class _CotacaoDolarState extends State<CotacaoDolar> {
  String cotacao = '';
  String maxima = '';
  String minima = '';
  String atualizacao = '';
  String erro = '';
  bool carregando = false;

  Future<void> consultarDolar() async {
    setState(() {
      carregando = true;
      erro = '';
    });

    try {
      final resposta = await http.get(
        Uri.parse(
          'https://economia.awesomeapi.com.br/last/USD-BRL',
        ),
      );

      if (resposta.statusCode == 200) {
        final dados = jsonDecode(resposta.body);
        final dolar = dados['USDBRL'];

        setState(() {
          cotacao = dolar['bid'] ?? '';
          maxima = dolar['high'] ?? '';
          minima = dolar['low'] ?? '';
          atualizacao = dolar['create_date'] ?? '';
        });
      } else {
        erro = 'Erro ao consultar a cotação.';
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
  void initState() {
    super.initState();
    consultarDolar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6F3D19),
      appBar: AppBar(
        title: const Text('Cotação do Dólar'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: carregando
              ? const CircularProgressIndicator()
              : erro.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(erro),
                        ElevatedButton(
                          onPressed: consultarDolar,
                          child: const Text('Tentar novamente'),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Dólar Americano (USD)',
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF196F3D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'R\$ $cotacao',
                          style: const TextStyle(
                            fontSize: 36,
                            color: Color(0xFF3D196F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text('Máxima: R\$ $maxima'),
                        Text('Mínima: R\$ $minima'),
                        const SizedBox(height: 10),
                        Text('Atualização: $atualizacao'),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF196F3D),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: consultarDolar,
                          child: const Text('Atualizar cotação'),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}