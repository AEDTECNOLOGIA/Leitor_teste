import 'package:flutter/material.dart';
import 'package:leitor_acessivel/screens/login_screen.dart'; // Adicionado para navegação para LoginScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward(); // Inicia animação

    // Adiciona timer para navegação automática após 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _navigateToNextScreen(context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Método para navegação
  void _navigateToNextScreen(BuildContext context) {
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(userType: 'responsável'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF9),
      body: Stack(
        children: [
          // Fundo com formas circulares suaves
          Positioned(
            top: -80,
            left: -80,
            child: _backgroundCircle(
              200,
              Colors.blueGrey.withAlpha((0.05 * 255).round()),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -60,
            child: _backgroundCircle(
              180,
              Colors.teal.withAlpha((0.05 * 255).round()),
            ),
          ),
          Positioned(
            top: 120,
            right: -100,
            child: _backgroundCircle(
              140,
              Colors.tealAccent.withAlpha((0.05 * 255).round()),
            ),
          ),

          // Conteúdo com fade-in
          SafeArea(
            child: FadeTransition(
              opacity: _fadeIn,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bem-vindo(a) à Biblioteca Acessível',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: textScaler.scale(28),
                          fontWeight: FontWeight.bold,
                          color: const Color(
                            0xFF8A61A9,
                          ), // Cor unificada para todo o título
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 50),

                      Image.asset(
                        'assets/images/reader.png', // Alterado para .png
                        height: 200,
                        errorBuilder: (context, error, stackTrace) {
                          // Adicionado errorBuilder para feedback
                          return Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: Center(
                              child: Text(
                                'Erro ao carregar imagem: reader.png',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 60),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _navigateToNextScreen(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF44C3E0),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Continuar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para gerar círculos de fundo decorativos
  Widget _backgroundCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.05), // Usando opacity em vez de withAlpha
        shape: BoxShape.circle,
      ),
    );
  }
}
