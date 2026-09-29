
import 'package:flutter/material.dart';
import 'splash.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Aplicativo',

      theme: ThemeData(
        useMaterial3: true,

        // Fundo padrão de todas as páginas
        scaffoldBackgroundColor: const Color(0xFF3D196F),

        // Cores da paleta do Luan Victor
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF196F3D),
          secondary: Color(0xFF3D196F),
          tertiary: Color(0xFF6F3D19),
          surface: Color(0xFF3D196F),
        ),

        // Barra superior
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF196F3D),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        // Botões
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6F3D19),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // Campos de texto
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(
            color: Color(0xFF3D196F),
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF2ECC71),
              width: 2,
            ),
          ),
        ),

        // Textos
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Menu inferior
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF196F3D),
          selectedItemColor: Color(0xFF2ECC71),
          unselectedItemColor: Colors.white,
        ),

        // Menu lateral
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFF3D196F),
        ),

        // Cartões
        cardTheme: const CardThemeData(
          color: Color(0xFF6F3D19),
          margin: EdgeInsets.all(10),
        ),
      ),

      home: const Splash(),
    );
  }
}