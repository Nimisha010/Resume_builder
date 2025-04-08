/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/resume_template.dart';
import '../services/firestore_service.dart';
import 'resume_preview.dart'; // Updated preview screen

class ResumeSelectionScreen extends StatefulWidget {
  @override
  _ResumeSelectionScreenState createState() => _ResumeSelectionScreenState();
}

class _ResumeSelectionScreenState extends State<ResumeSelectionScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<ResumeTemplate>> _templatesFuture;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _templatesFuture = _firestoreService.getTemplates();
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser; // Get logged-in user

    if (user == null) {
      return Scaffold(
        body: Center(child: Text("Please log in to continue")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Select Resume Template")),
      body: FutureBuilder<List<ResumeTemplate>>(
        future: _templatesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No templates found"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              ResumeTemplate template = snapshot.data![index];

              return Card(
                child: ListTile(
                  title: Text(template.templateName),
                  subtitle: Text(
                      "ATS Compliant: ${template.atsCompliant ? "Yes" : "No"}"),
                  onTap: () async {
                    Map<String, dynamic> userData =
                        await _firestoreService.getUserData(user.uid);

                    // Save selected template in Firebase
                    await _firestoreService.saveSelectedTemplate(
                        user.uid, template.templateName);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResumePreviewScreen(
                          templateName:
                              template.templateName, // Pass only template name
                          userId: user.uid, // Pass user ID
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
*/
/* correct one
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/resume_template.dart';
import '../services/firestore_service.dart';
import 'resume_preview.dart';

class ResumeSelectionScreen extends StatefulWidget {
  @override
  _ResumeSelectionScreenState createState() => _ResumeSelectionScreenState();
}

class _ResumeSelectionScreenState extends State<ResumeSelectionScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<ResumeTemplate>> _templatesFuture;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Map<String, String> _templateImages = {
    'Classic Resume': 'assets/templates/Classic Resume.png',
    'Green Template': 'assets/templates/Green Template.png',
    'Red Template': 'assets/templates/Red Template.png',
    'Modern Resume': 'assets/templates/Modern Resume.png',
    'Professional Resume': 'assets/templates/Professional Resume.png',
    'Column Template': 'assets/templates/Column Template.png',
  };

  Future<bool> _showAISuggestionDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Include AI Suggestions?"),
        content: Text(
            "Would you like to include AI-generated content in your resume?"),
        actions: [
          TextButton(
            child: Text("No"),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text("Yes"),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    // Default to false if dialog is dismissed
    return result ?? false;
  }

  @override
  void initState() {
    super.initState();
    _templatesFuture = _firestoreService.getTemplates();
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text("Please log in to continue")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Resume Template"),
        backgroundColor: Color(0xFF184D47),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD1D1D1), Color(0xFF4B6965)],
          ),
        ),
        child: FutureBuilder<List<ResumeTemplate>>(
          future: _templatesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No templates found"));
            }

            return GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ResumeTemplate template = snapshot.data![index];
                String imagePath = _templateImages[template.templateName] ??
                    'assets/templates/default.png';

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      Map<String, dynamic> userData =
                          await _firestoreService.getUserData(user.uid);

                      try {
                        bool includeAI = await _showAISuggestionDialog(context);

                        await _firestoreService.saveSelectedTemplate(
                            user.uid, template.templateName);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResumePreviewScreen(
                              templateName: template.templateName,
                              userId: user.uid,
                              includeAISuggestions: includeAI,
                            ),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: ${e.toString()}")),
                        );
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.error_outline, size: 50),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                template.templateName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    template.atsCompliant
                                        ? Icons.verified
                                        : Icons.warning,
                                    color: template.atsCompliant
                                        ? Colors.green
                                        : Colors.orange,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    template.atsCompliant
                                        ? "ATS Compliant"
                                        : "Not ATS Optimized",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/resume_template.dart';
import '../services/firestore_service.dart';
import 'resume_preview.dart';

class ResumeSelectionScreen extends StatefulWidget {
  @override
  _ResumeSelectionScreenState createState() => _ResumeSelectionScreenState();
}

class _ResumeSelectionScreenState extends State<ResumeSelectionScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<ResumeTemplate>> _templatesFuture;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Map<String, String> _templateImages = {
    'Classic Resume': 'assets/templates/Classic Resume.png',
    'Green Template': 'assets/templates/Green Template.png',
    'Red Template': 'assets/templates/Red Template.png',
    'Modern Resume': 'assets/templates/Modern Resume.png',
    'Professional Resume': 'assets/templates/Professional Resume.png',
    'Column Template': 'assets/templates/Column Template.png',
  };

  Future<bool> _showAISuggestionDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Include AI Suggestions?"),
            content: const Text(
                "Would you like to include AI-generated content in your resume?"),
            actions: [
              TextButton(
                child: const Text("No"),
                onPressed: () => Navigator.pop(context, false),
              ),
              TextButton(
                child: const Text("Yes"),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    _templatesFuture = _firestoreService.getTemplates();
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Please log in to continue")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Resume Template"),
        backgroundColor: const Color(0xFF184D47),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD1D1D1), Color(0xFF4B6965)],
          ),
        ),
        child: FutureBuilder<List<ResumeTemplate>>(
          future: _templatesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No templates found"));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ResumeTemplate template = snapshot.data![index];
                String imagePath = _templateImages[template.templateName] ??
                    'assets/templates/default.png';

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      try {
                        Map<String, dynamic> userData =
                            await _firestoreService.getUserData(user.uid);
                        bool includeAI = await _showAISuggestionDialog(context);

                        await _firestoreService.saveSelectedTemplate(
                            user.uid, template.templateName);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResumePreviewScreen(
                              templateName: template.templateName,
                              userId: user.uid,
                              includeAISuggestions: includeAI,
                              userData: userData,
                            ),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: ${e.toString()}")),
                        );
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error_outline, size: 50),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                template.templateName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    template.atsCompliant
                                        ? Icons.verified
                                        : Icons.warning,
                                    color: template.atsCompliant
                                        ? Colors.green
                                        : Colors.orange,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    template.atsCompliant
                                        ? "ATS Compliant"
                                        : "Not ATS Optimized",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
