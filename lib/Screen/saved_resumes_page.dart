import 'package:flutter/material.dart';

class SavedResumesPage extends StatelessWidget {
  const SavedResumesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Resumes')),
      body: Center(
        child: const Text(
          'Your saved resumes will appear here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
