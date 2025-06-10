import 'package:flutter/material.dart';

class AccessibilityService {
  static const Map<String, Map<String, Color>> _contrastThemes = {
    'blue_yellow': {
      'background': Color(0xFFFFF3CD), // Amarelo claro
      'text': Color(0xFF0D47A1), // Azul escuro
    },
    'black_yellow': {
      'background': Color(0xFFFFF3CD), // Amarelo claro
      'text': Colors.black,
    },
    'blue_white': {
      'background': Color(0xFF0D47A1), // Azul escuro
      'text': Colors.white,
    },
  };

  String _currentTheme = 'blue_white';

  Map<String, Color> get currentTheme => _contrastThemes[_currentTheme]!;

  void changeTheme(String themeName) {
    if (_contrastThemes.containsKey(themeName)) {
      _currentTheme = themeName;
    }
  }
}

class UserTypeSelectionScreen extends StatelessWidget {
  final String userType;

  const UserTypeSelectionScreen({
    super.key,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleção de Tipo de Usuário'),
      ),
      body: Center(
        child: Text('Tipo de usuário: $userType'),
      ),
    );
  }
}
