import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/user_type_selection_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/reader_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Leitura Inclusivo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8A61A9), // Roxo
          secondary: const Color(0xFF44C3E0), // Azul
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.lexend().fontFamily, // Fonte Lexend
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const LoginScreen(userType: 'responsável'),
        '/sign_up': (context) => const SignUpScreen(),
        '/user_type': (context) => const UserTypeSelectionScreen(userType: 'responsável'),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/leitor': (context) => const ReaderScreen(),
        '/splash': (context) => const SplashScreen(),
        '/reader': (context) => const ReaderScreen(),
        '/user_type_selection': (context) => const UserTypeSelectionScreen(userType: 'default'),
      },
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        
        if (snapshot.hasData) {
          // Usuário está logado
          return const ReaderScreen();
        }
        
        // Usuário não está logado
        return LoginScreen(userType: 'responsável');
      },
    );
  }
}

// A classe HomeScreen pode ser movida para outro arquivo ou excluída, se não for usada
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Biblioteca'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text(
          'Bem-vindo ao App de Leitura!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
