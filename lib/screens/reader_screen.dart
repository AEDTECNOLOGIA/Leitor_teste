import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';
import 'package:leitor_acessivel/services/auth_service.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final AuthService _authService = AuthService();
  final List<String> _supportedFormats = [
    'epub',
    'doc',
    'docx',
    'rtf',
    'txt',
    'pdf',
  ];
  String? _selectedFilePath;
  String? _fileName;

  Future<void> _pickFile() async {
    try {
      final typeGroup = XTypeGroup(
        label: 'Arquivos de texto',
        extensions: _supportedFormats,
      );

      final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);

      if (!mounted) return;

      if (file != null) {
        setState(() {
          _selectedFilePath = file.path;
          _fileName = file.name;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao selecionar arquivo: $e')));
    }
  }

  Future<void> _openFile() async {
    if (_selectedFilePath != null) {
      try {
        // Usando o file_selector para abrir o arquivo
        final typeGroup = XTypeGroup(
          label: 'Abrir arquivo',
          extensions: _supportedFormats,
        );

        // Aqui estamos apenas abrindo o arquivo selecionado
        await openFile(
          acceptedTypeGroups: [typeGroup],
          initialDirectory: _selectedFilePath,
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao abrir arquivo: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _logout() async {
    try {
      await _authService.signOut();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout realizado com sucesso!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer logout: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF9),
      appBar: AppBar(
        title: const Text('Leitor de Textos'),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Sair',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Formas circulares de fundo
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

          // Conteúdo principal
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(51),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Selecione um arquivo para ler',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: textScaler.scale(24),
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: _pickFile,
                            icon: const Icon(Icons.upload_file),
                            label: const Text('Selecionar Arquivo'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8A61A9),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          if (_fileName != null)
                            Column(
                              children: [
                                const SizedBox(height: 24),
                                Text(
                                  'Arquivo selecionado: $_fileName',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  onPressed: _openFile,
                                  icon: const Icon(Icons.open_in_new),
                                  label: const Text('Abrir Arquivo'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8A61A9),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Formatos suportados:\nEPUB, DOC, DOCX, RTF, TXT, PDF',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _backgroundCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
