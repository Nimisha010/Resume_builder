/*import 'package:flutter/material.dart';

class ChooseTemplatePage extends StatelessWidget {
  const ChooseTemplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Template')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Resume Template',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two templates per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 4, // Add more templates as needed
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle template selection
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Template ${index + 1} selected')),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.picture_as_pdf,
                              size: 50, color: Colors.blue),
                          const SizedBox(height: 10),
                          Text('Template ${index + 1}',
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the next page (e.g., PDF Preview or Summary)
                },
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import '../services/template_service.dart'; // Import template fetching service

class ChooseTemplatePage extends StatefulWidget {
  final Map<String, dynamic> userData; // User details passed to this page

  const ChooseTemplatePage({super.key, required this.userData});

  @override
  _ChooseTemplatePageState createState() => _ChooseTemplatePageState();
}

class _ChooseTemplatePageState extends State<ChooseTemplatePage> {
  final TemplateService _templateService = TemplateService();
  List<Map<String, dynamic>> templates = [];
  String? selectedTemplateId;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    List<Map<String, dynamic>> fetchedTemplates = await _templateService
        .fetchAllTemplates(); // Fetch templates from Firestore
    setState(() {
      templates = fetchedTemplates;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Template')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Resume Template',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: templates.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: templates.length,
                      itemBuilder: (context, index) {
                        var template = templates[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTemplateId = template['template_id'];
                            });
                          },
                          child: Card(
                            elevation: 3,
                            color: selectedTemplateId == template['template_id']
                                ? Colors
                                    .teal[100] // Highlight selected template
                                : Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.picture_as_pdf,
                                    size: 50, color: Colors.blue),
                                const SizedBox(height: 10),
                                Text(
                                  template['template_name'],
                                  style: const TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: selectedTemplateId != null
                    ? () {
                        // Navigate to final resume preview or generation page
                        Navigator.pushNamed(
                          context,
                          '/resume_preview',
                          arguments: {
                            'userData': widget.userData,
                            'selectedTemplate': selectedTemplateId,
                          },
                        );
                      }
                    : null,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*

import 'package:flutter/material.dart';
import '../services/template_service.dart'; // Import template fetching service

class ChooseTemplatePage extends StatefulWidget {
  final Map<String, dynamic> userData; // User details passed to this page

  const ChooseTemplatePage({super.key, required this.userData});

  @override
  _ChooseTemplatePageState createState() => _ChooseTemplatePageState();
}

class _ChooseTemplatePageState extends State<ChooseTemplatePage> {
  final TemplateService _templateService = TemplateService();
  List<Map<String, dynamic>> templates = [];
  String? selectedTemplateId;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    try {
      List<Map<String, dynamic>> fetchedTemplates =
          await _templateService.fetchAllTemplates();

      setState(() {
        templates = fetchedTemplates
            .where((template) => template is Map<String, dynamic>)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching templates: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Template')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Resume Template',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : templates.isEmpty
                      ? const Center(child: Text("No templates available."))
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: templates.length,
                          itemBuilder: (context, index) {
                            var template = templates[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTemplateId = template['template_id'];
                                });
                              },
                              child: Card(
                                elevation: 3,
                                color: selectedTemplateId ==
                                        template['template_id']
                                    ? Colors.teal[
                                        100] // Highlight selected template
                                    : Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.picture_as_pdf,
                                        size: 50, color: Colors.blue),
                                    const SizedBox(height: 10),
                                    Text(
                                      template['template_name'] ?? "Unnamed",
                                      style: const TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: selectedTemplateId != null
                    ? () {
                        // Navigate to final resume preview or generation page
                        Navigator.pushNamed(
                          context,
                          '/resume_preview',
                          arguments: {
                            'userData': widget.userData,
                            'selectedTemplate': selectedTemplateId,
                          },
                        );
                      }
                    : null,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import '../services/template_service.dart'; // Import template fetching service

class ChooseTemplatePage extends StatefulWidget {
  final Map<String, dynamic> userData; // User details passed to this page

  const ChooseTemplatePage({super.key, required this.userData});

  @override
  _ChooseTemplatePageState createState() => _ChooseTemplatePageState();
}

class _ChooseTemplatePageState extends State<ChooseTemplatePage> {
  final TemplateService _templateService = TemplateService();
  List<Map<String, dynamic>> templates = [];
  String? selectedTemplateId;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    try {
      List<Map<String, dynamic>> fetchedTemplates =
          await _templateService.fetchAllTemplates();

      setState(() {
        templates = fetchedTemplates
            .where((template) => template is Map<String, dynamic>)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching templates: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Template')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Resume Template',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : templates.isEmpty
                      ? const Center(child: Text("No templates available."))
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: templates.length,
                          itemBuilder: (context, index) {
                            var template = templates[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTemplateId = template['template_id'];
                                });
                              },
                              child: Card(
                                elevation: 3,
                                color: selectedTemplateId ==
                                        template['template_id']
                                    ? Colors.teal[
                                        100] // Highlight selected template
                                    : Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.picture_as_pdf,
                                        size: 50, color: Colors.blue),
                                    const SizedBox(height: 10),
                                    Text(
                                      template['template_name'] ?? "Unnamed",
                                      style: const TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: selectedTemplateId != null
                    ? () {
                        // Find the selected template data
                        Map<String, dynamic>? selectedTemplate =
                            templates.firstWhere(
                          (template) =>
                              template['template_id'] == selectedTemplateId,
                          orElse: () => {}, // Return empty map if not found
                        );

                        if (selectedTemplate.isNotEmpty) {
                          // Navigate to Resume Preview Page
                          Navigator.pushNamed(
                            context,
                            '/resume_preview',
                            arguments: {
                              'userData': widget.userData,
                              'selectedTemplate':
                                  selectedTemplate, // Pass full template data
                            },
                          );
                        } else {
                          // Show error if template not found
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Error: Template not found!")),
                          );
                        }
                      }
                    : null,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import '../services/template_service.dart'; // Import template fetching service

class ChooseTemplatePage extends StatefulWidget {
  final Map<String, dynamic> userData; // User details passed to this page

  const ChooseTemplatePage({super.key, required this.userData});

  @override
  _ChooseTemplatePageState createState() => _ChooseTemplatePageState();
}

class _ChooseTemplatePageState extends State<ChooseTemplatePage> {
  final TemplateService _templateService = TemplateService();
  List<Map<String, dynamic>> templates = [];
  String? selectedTemplateId;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    try {
      List<Map<String, dynamic>> fetchedTemplates =
          await _templateService.fetchAllTemplates();

      setState(() {
        templates = fetchedTemplates
            .where((template) => template is Map<String, dynamic>)
            .toList();
        isLoading = false;
      });

      // Debugging: Print fetched templates
      print("Fetched Templates: $templates");
    } catch (e) {
      print("Error fetching templates: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Template')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Resume Template',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : templates.isEmpty
                      ? const Center(child: Text("No templates available."))
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: templates.length,
                          itemBuilder: (context, index) {
                            var template = templates[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTemplateId = template['template_id'];
                                });

                                // Debugging: Print selected template ID
                                print(
                                    "Selected Template ID: $selectedTemplateId");
                              },
                              child: Card(
                                elevation: 3,
                                color: selectedTemplateId ==
                                        template['template_id']
                                    ? Colors.teal[
                                        100] // Highlight selected template
                                    : Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.picture_as_pdf,
                                        size: 50, color: Colors.blue),
                                    const SizedBox(height: 10),
                                    Text(
                                      template['template_name'] ?? "Unnamed",
                                      style: const TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: selectedTemplateId != null
                    ? () {
                        // Navigate to Resume Preview Page
                        Navigator.pushNamed(
                          context,
                          '/resume_preview',
                          arguments: {
                            'userData': widget.userData,
                            'templateId':
                                selectedTemplateId, // Pass only template ID
                          },
                        );
                      }
                    : null,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import '../services/template_service.dart'; // Import template fetching service

class ChooseTemplatePage extends StatefulWidget {
  final Map<String, dynamic> userData; // User details passed to this page

  const ChooseTemplatePage({super.key, required this.userData});

  @override
  _ChooseTemplatePageState createState() => _ChooseTemplatePageState();
}

class _ChooseTemplatePageState extends State<ChooseTemplatePage> {
  final TemplateService _templateService = TemplateService();
  List<Map<String, dynamic>> templates = [];
  String? selectedTemplateId;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    try {
      List<Map<String, dynamic>> fetchedTemplates =
          await _templateService.fetchAllTemplates();

      setState(() {
        templates = fetchedTemplates
            .where((template) => template is Map<String, dynamic>)
            .toList();
        isLoading = false;
      });

      // Debugging: Print fetched templates
      print("✅ Fetched Templates: $templates");
    } catch (e) {
      print("⚠️ Error fetching templates: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Template')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Resume Template',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : templates.isEmpty
                      ? const Center(child: Text("No templates available."))
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: templates.length,
                          itemBuilder: (context, index) {
                            var template = templates[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTemplateId = template['template_id'];
                                });

                                // Debugging: Print selected template ID
                                print(
                                    "📌 Selected Template ID: $selectedTemplateId");
                              },
                              child: Card(
                                elevation: 3,
                                color: selectedTemplateId ==
                                        template['template_id']
                                    ? Colors.teal[
                                        100] // Highlight selected template
                                    : Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.picture_as_pdf,
                                        size: 50, color: Colors.blue),
                                    const SizedBox(height: 10),
                                    Text(
                                      template['template_name'] ?? "Unnamed",
                                      style: const TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: selectedTemplateId != null
                    ? () {
                        // Navigate to Resume Preview Page
                        Navigator.pushNamed(
                          context,
                          '/resume_preview',
                          arguments: {
                            'userData': widget.userData,
                            'templateId':
                                selectedTemplateId, // Pass only template ID
                          },
                        );
                      }
                    : null,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import '../services/template_service.dart';

class ChooseTemplatePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ChooseTemplatePage({super.key, required this.userData});

  @override
  _ChooseTemplatePageState createState() => _ChooseTemplatePageState();
}

class _ChooseTemplatePageState extends State<ChooseTemplatePage> {
  final TemplateService _templateService = TemplateService();
  List<Map<String, dynamic>> templates = [];
  String? selectedTemplateId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    try {
      List<Map<String, dynamic>> fetchedTemplates =
          await _templateService.fetchAllTemplates();

      setState(() {
        templates = fetchedTemplates;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching templates: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Template')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select a Resume Template',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : templates.isEmpty
                      ? const Center(child: Text("No templates available."))
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: templates.length,
                          itemBuilder: (context, index) {
                            var template = templates[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTemplateId = template['template_id'];
                                });
                              },
                              child: Card(
                                elevation: 3,
                                color: selectedTemplateId ==
                                        template['template_id']
                                    ? Colors.teal[100]
                                    : Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.picture_as_pdf,
                                        size: 50, color: Colors.blue),
                                    const SizedBox(height: 10),
                                    Text(
                                      template['template_name'] ?? "Unnamed",
                                      style: const TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: selectedTemplateId != null
                    ? () {
                        Navigator.pushNamed(
                          context,
                          '/resume_preview',
                          arguments: {
                            'userData': widget.userData,
                            'templateId': selectedTemplateId,
                          },
                        );
                      }
                    : null,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import '../services/template_service.dart';

class ChooseTemplatePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ChooseTemplatePage({super.key, required this.userData});

  @override
  _ChooseTemplatePageState createState() => _ChooseTemplatePageState();
}

class _ChooseTemplatePageState extends State<ChooseTemplatePage> {
  final TemplateService _templateService = TemplateService();
  List<Map<String, dynamic>> templates = [];
  String? selectedTemplateId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    try {
      List<Map<String, dynamic>> fetchedTemplates =
          await _templateService.fetchAllTemplates();

      setState(() {
        templates = fetchedTemplates;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching templates: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Template')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Resume Template',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : templates.isEmpty
                      ? const Center(
                          child: Text(
                            "No templates available.",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4, // Adjust for better layout
                          ),
                          itemCount: templates.length,
                          itemBuilder: (context, index) {
                            var template = templates[index];

                            // Extract template details
                            String templateId = template['template_id'] ?? '';
                            String templateName =
                                template['template_name'] ?? 'Unnamed';

                            return GestureDetector(
                              onTap: () {
                                
                                print(
                                    "Selected Template ID: ${template['template_id']}");
                                setState(() {
                                  selectedTemplateId = templateId;
                                });
                              },
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: selectedTemplateId == templateId
                                        ? Colors.teal
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                color: selectedTemplateId == templateId
                                    ? Colors.teal[100]
                                    : Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.picture_as_pdf,
                                        size: 50, color: Colors.blue),
                                    const SizedBox(height: 10),
                                    Text(
                                      templateName,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: selectedTemplateId != null
                    ? () {
                        print(
                            "Navigating with template ID: $selectedTemplateId");
                        Navigator.pushNamed(
                          context,
                          '/resume_preview',
                          arguments: {
                            'userData': widget.userData,
                            'templateId': selectedTemplateId,
                          },
                        );
                      }
                    : null,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import '../services/template_service.dart';

class ChooseTemplatePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ChooseTemplatePage({super.key, required this.userData});

  @override
  _ChooseTemplatePageState createState() => _ChooseTemplatePageState();
}

class _ChooseTemplatePageState extends State<ChooseTemplatePage> {
  final TemplateService _templateService = TemplateService();
  List<Map<String, dynamic>> templates = [];
  String? selectedTemplateId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    try {
      List<Map<String, dynamic>> fetchedTemplates =
          await _templateService.fetchAllTemplates();

      setState(() {
        templates = fetchedTemplates;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching templates: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Template')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Resume Template',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : templates.isEmpty
                      ? const Center(
                          child: Text(
                            "No templates available.",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4, // Adjust for better layout
                          ),
                          itemCount: templates.length,
                          itemBuilder: (context, index) {
                            var template = templates[index];

                            // Extract template details from json_data
                            final jsonData =
                                template['json_data'] as Map<String, dynamic>?;
                            final templateId =
                                jsonData?['template_id'] as String? ?? '';
                            final templateName =
                                jsonData?['template_name'] as String? ??
                                    'Unnamed';

                            return GestureDetector(
                              onTap: () {
                                print("Selected Template ID: $templateId");
                                setState(() {
                                  selectedTemplateId = templateId;
                                });
                              },
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: selectedTemplateId == templateId
                                        ? Colors.teal
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                color: selectedTemplateId == templateId
                                    ? Colors.teal[100]
                                    : Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.picture_as_pdf,
                                        size: 50, color: Colors.blue),
                                    const SizedBox(height: 10),
                                    Text(
                                      templateName,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: selectedTemplateId != null
                    ? () {
                        print(
                            "Navigating with template ID: $selectedTemplateId");
                        Navigator.pushNamed(
                          context,
                          '/resume_preview',
                          arguments: {
                            'userData': widget.userData,
                            'templateId': selectedTemplateId,
                          },
                        );
                      }
                    : null,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'template_preview_page.dart';

class ChooseTemplatePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ChooseTemplatePage({super.key, required this.userData});

  @override
  _ChooseTemplatePageState createState() => _ChooseTemplatePageState();
}

class _ChooseTemplatePageState extends State<ChooseTemplatePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedTemplateJson; // Store the selected template JSON

  Future<void> _fetchTemplate(String templateId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('templates').doc(templateId).get();

    if (snapshot.exists) {
      setState(() {
        selectedTemplateJson = snapshot['json_data']; // Load template JSON
      });
    }
  }

  void _onSelectTemplate(String templateId) {
    _fetchTemplate(templateId);
  }

  void _onContinue() {
    if (selectedTemplateJson != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TemplatePreviewPage(
            userData: widget.userData,
            templateJson: selectedTemplateJson!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a template')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Template')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Select a Resume Template',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildTemplateTile('template_1', 'Modern Template'),
                _buildTemplateTile('template_2', 'Classic Template'),
                _buildTemplateTile('template_3', 'Minimalist Template'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: ElevatedButton(
                onPressed: _onContinue,
                child: const Text('Continue'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateTile(String templateId, String title) {
    return ListTile(
      title: Text(title),
      trailing: ElevatedButton(
        onPressed: () => _onSelectTemplate(templateId),
        child: const Text('Select'),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _templatesFuture = _firestoreService.getTemplates();
  }

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ResumePreviewScreen(template: template),
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
/*
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _templatesFuture = _firestoreService.getTemplates();
  }

  Future<Map<String, String>> _getUserData(String userId) async {
    return await _firestoreService.getUserData(userId);
  }

  @override
  Widget build(BuildContext context) {
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
                    String userId =
                        "180JTXEYpjh9XZcLIuM5znqJEm83"; // Replace with the actual user ID
                    Map<String, String> userData = await _getUserData(userId);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResumePreviewScreen(
                          template: template,
                          userData: userData,
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

/*correct one

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
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
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  @override
  void initState() {
    super.initState();
    _templatesFuture = _firestoreService.getTemplates();
  }

  Future<Map<String, String>> _getUserData(String userId) async {
    return await _firestoreService.getUserData(userId);
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser; // Get the currently logged-in user

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
                    Map<String, String> userId = await _getUserData(
                        user.uid); // Fetch user data dynamically
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResumePreviewScreen(
                          template: template,
                          userId: userId,
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
/*correct one 
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

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResumePreviewScreen(
                          template: template,
                          userId: userData, // Pass correct user data
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
