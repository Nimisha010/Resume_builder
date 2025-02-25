/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResumePreviewPage extends StatefulWidget {
  final String templateId;
  final Map<String, dynamic>? userData;

  const ResumePreviewPage({
    super.key,
    required this.templateId,
    this.userData,
  });

  @override
  _ResumePreviewPageState createState() => _ResumePreviewPageState();
}

class _ResumePreviewPageState extends State<ResumePreviewPage> {
  Map<String, dynamic>? resumeData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchResumeTemplate();
  }

  Future<void> fetchResumeTemplate() async {
    try {
      debugPrint("Fetching template for ID: ${widget.templateId}");
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('resume_templates')
          .doc(widget.templateId)
          .get();

      if (snapshot.exists) {
        debugPrint("✅ Template found: ${snapshot.data()}");
        setState(() {
          resumeData = snapshot.data() as Map<String, dynamic>;
          isLoading = false;
        });
      } else {
        debugPrint("❌ Template not found!");
        setState(() {
          errorMessage = "Template not found!";
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("⚠️ Error fetching template: $e");
      setState(() {
        errorMessage = "Error loading template.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Resume Preview"), backgroundColor: Colors.teal),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Text(errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 18)))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: ResumeTemplate(
                    data: resumeData!,
                    userData: widget.userData ?? {},
                  ),
                ),
    );
  }
}

class ResumeTemplate extends StatelessWidget {
  final Map<String, dynamic> data;
  final Map<String, dynamic> userData;

  const ResumeTemplate({super.key, required this.data, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            data['template_name'] ?? "Resume",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        for (var section in data['sections'] ?? [])
          ResumeSection(
            section: section,
            userData: userData[section['section_id']] ?? {},
          ),
      ],
    );
  }
}

class ResumeSection extends StatelessWidget {
  final Map<String, dynamic> section;
  final Map<String, dynamic> userData;

  const ResumeSection({
    super.key,
    required this.section,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "📌 ${section['title']}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(thickness: 1),
          if (section['fields'] != null && section['fields'].isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: section['fields']
                  .map<Widget>((field) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_right, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "$field: ${userData[field] ?? 'N/A'}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            )
          else
            const Text(
              "No data available",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
        ],
      ),
    );
  }
}
*/
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResumePreviewPage extends StatefulWidget {
  final String templateId;
  final Map<String, dynamic>? userData;

  const ResumePreviewPage({
    super.key,
    required this.templateId,
    this.userData,
  });

  @override
  _ResumePreviewPageState createState() => _ResumePreviewPageState();
}

class _ResumePreviewPageState extends State<ResumePreviewPage> {
  Map<String, dynamic>? resumeData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchResumeTemplate();
  }

  Future<void> fetchResumeTemplate() async {
    try {
      debugPrint("Fetching template for ID: ${widget.templateId}");

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('resume_templates')
          .doc(widget.templateId)
          .get();

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('json_data')) {
          try {
            // 🔥 Decode json_data if stored as a string
            String jsonDataString = data['json_data'];
            Map<String, dynamic> jsonData = jsonDecode(jsonDataString);

            debugPrint("✅ Template found: $jsonData");

            setState(() {
              resumeData = jsonData; // ✅ Use decoded JSON
              isLoading = false;
            });
          } catch (e) {
            debugPrint("⚠️ Error decoding JSON: $e");
            setState(() {
              errorMessage = "Error parsing template data.";
              isLoading = false;
            });
          }
        } else {
          debugPrint("❌ json_data field missing or null!");
          setState(() {
            errorMessage = "Template data is incomplete.";
            isLoading = false;
          });
        }
      } else {
        debugPrint("❌ Template not found in Firestore!");
        setState(() {
          errorMessage = "Template not found!";
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("⚠️ Error fetching template: $e");
      setState(() {
        errorMessage = "Error loading template.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume Preview"),
        backgroundColor: Colors.teal,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Text(errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 18)),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: ResumeTemplate(
                    data: resumeData!,
                    userData: widget.userData ?? {},
                  ),
                ),
    );
  }
}

class ResumeTemplate extends StatelessWidget {
  final Map<String, dynamic> data;
  final Map<String, dynamic> userData;

  const ResumeTemplate({super.key, required this.data, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            data['template_name'] ?? "Resume",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        for (var section in data['sections'] ?? [])
          ResumeSection(
            section: section,
            userData: userData[section['section_id']] ?? {},
          ),
      ],
    );
  }
}

class ResumeSection extends StatelessWidget {
  final Map<String, dynamic> section;
  final Map<String, dynamic> userData;

  const ResumeSection({
    super.key,
    required this.section,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "📌 ${section['title']}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(thickness: 1),
          if (section['fields'] is List &&
              (section['fields'] as List).isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (section['fields'] as List)
                  .map<Widget>((field) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_right, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "$field: ${userData[field] ?? 'N/A'}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            )
          else
            const Text(
              "No data available",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
        ],
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResumePreviewPage extends StatefulWidget {
  final String templateId;
  final Map<String, dynamic>? userData;

  const ResumePreviewPage({
    super.key,
    required this.templateId,
    this.userData,
  });

  @override
  _ResumePreviewPageState createState() => _ResumePreviewPageState();
}

class _ResumePreviewPageState extends State<ResumePreviewPage> {
  Map<String, dynamic>? resumeData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchResumeTemplate();
  }

  Future<void> fetchResumeTemplate() async {
    try {
      if (widget.templateId.isEmpty) {
        print("⚠️ Template ID is empty!");
        return;
      }
      debugPrint("Fetching template for ID: ${widget.templateId}");

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('templates') // Updated collection name
          .doc(widget.templateId)
          .get();

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('json_data')) {
          debugPrint("✅ Template found: $data");
          setState(() {
            resumeData = data['json_data']; // No need for jsonDecode()
            isLoading = false;
          });
        } else {
          debugPrint("❌ json_data field missing or null!");
          setState(() {
            errorMessage = "Template data is incomplete.";
            isLoading = false;
          });
        }
      } else {
        debugPrint("❌ Template not found in Firestore!");
        setState(() {
          errorMessage = "Template not found!";
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("⚠️ Error fetching template: $e");
      setState(() {
        errorMessage = "Error loading template.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume Preview"),
        backgroundColor: Colors.teal,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Text(errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 18)),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: ResumeTemplate(
                    data: resumeData!,
                    userData: widget.userData ?? {},
                  ),
                ),
    );
  }
}

class ResumeTemplate extends StatelessWidget {
  final Map<String, dynamic> data;
  final Map<String, dynamic> userData;

  const ResumeTemplate({super.key, required this.data, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            data['template_name'] ?? "Resume",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        for (var section in data['sections'] ?? [])
          ResumeSection(
            section: section,
            userData: userData[section['section_id']] ?? {},
          ),
      ],
    );
  }
}

class ResumeSection extends StatelessWidget {
  final Map<String, dynamic> section;
  final Map<String, dynamic> userData;

  const ResumeSection({
    super.key,
    required this.section,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "📌 ${section['title']}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(thickness: 1),
          if (section['fields'] is List &&
              (section['fields'] as List).isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (section['fields'] as List)
                  .map<Widget>((field) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_right, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "$field: ${userData[field] ?? 'N/A'}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            )
          else
            const Text(
              "No data available",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
        ],
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'dart:convert';

class TemplatePreviewPage extends StatelessWidget {
  final Map<String, dynamic> userData;
  final String templateJson;

  const TemplatePreviewPage(
      {super.key, required this.userData, required this.templateJson});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> template = jsonDecode(templateJson); // Parse JSON

    return Scaffold(
      appBar: AppBar(title: const Text('Resume Preview')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(
                  userData['name'], userData['email'], userData['phone']),
              const SizedBox(height: 20),
              _buildSection("Projects", userData['projects']),
              _buildSection("Awards", userData['awards']),
              _buildSection("Certificates", userData['certificates']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String name, String email, String phone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(email, style: const TextStyle(fontSize: 18, color: Colors.grey)),
        Text(phone, style: const TextStyle(fontSize: 18, color: Colors.grey)),
      ],
    );
  }

  Widget _buildSection(String title, dynamic items) {
    if (items == null || (items is List && items.isEmpty)) {
      return Container(); // Don't show empty sections
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ...items.map<Widget>((item) {
          return Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(item.toString(), style: const TextStyle(fontSize: 16)),
          );
        }).toList(),
        const SizedBox(height: 10),
      ],
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/template_service.dart';

class TemplatePreviewPage extends StatefulWidget {
  final String templateId;
  final Map<String, dynamic> userData;

  const TemplatePreviewPage({
    super.key,
    required this.templateId,
    required this.userData,
  });

  @override
  _TemplatePreviewPageState createState() => _TemplatePreviewPageState();
}

class _TemplatePreviewPageState extends State<TemplatePreviewPage> {
  final TemplateService _templateService = TemplateService();
  Map<String, dynamic>? _templateData;

  @override
  void initState() {
    super.initState();
    _loadTemplate();
  }

  Future<void> _loadTemplate() async {
    String? templateJson =
        await _templateService.fetchTemplate(widget.templateId);
    if (templateJson != null) {
      setState(() {
        _templateData = jsonDecode(templateJson);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview Template: ${widget.templateId}")),
      body: _templateData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Template: ${_templateData!['template_name']}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...List<Map<String, dynamic>>.from(
                          _templateData!['sections'] ?? [])
                      .map((section) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${section['title']}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        if (section['fields'] != null)
                          ...List<String>.from(section['fields']).map((field) {
                            return Text(
                                "• ${widget.userData[field] ?? 'Not provided'}");
                          }).toList(),
                        const SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import '../models/resume_template.dart';
import '../widgets/resume_section.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  ResumePreviewScreen({required this.template});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(template.templateName)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: template.sections.map((section) {
            return ResumeSection(section: section);
          }).toList(),
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import '../models/resume_template.dart';
import '../widgets/resume_section.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  ResumePreviewScreen({required this.template});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(template.templateName)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Template ID: ${template.templateId}",
                style: TextStyle(fontSize: 18)),
            Text("ATS Compliant: ${template.atsCompliant ? "Yes" : "No"}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Sections:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: template.sections.length,
                itemBuilder: (context, index) {
                  Section section = template.sections[index];
                  return ListTile(
                    title: Text(section.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(section.fields.join(", ")), // ✅ Show fields
                  );
                },
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
import '../models/resume_template.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, String>
      userData; // User data passed into the preview screen

  ResumePreviewScreen({required this.template, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(template.templateName)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: 210.0, // Width of A4 paper in mm (approx 210mm x 297mm)
            height: 297.0, // Height of A4 paper in mm
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black), // A simple border for A4 paper
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template.templateName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "Template ID: ${template.templateId}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "ATS Compliant: ${template.atsCompliant ? "Yes" : "No"}",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                // Render sections with user data
                Expanded(
                  child: ListView.builder(
                    itemCount: template.sections.length,
                    itemBuilder: (context, index) {
                      Section section = template.sections[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section.title,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            for (var field in section.fields)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Text(
                                  "$field: ${userData[field.toLowerCase()] ?? 'Not provided'}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
/*

import 'package:flutter/material.dart';
import '../models/resume_template.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId;

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Extract contact details safely
    Map<String, dynamic> contactDetails = userId["contactDetails"] ?? {};

    return Scaffold(
      appBar: AppBar(title: Text(template.templateName)), // Fixed Template Name
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Details Section
              _buildSection("Personal Information", [
                "Name: ${contactDetails["name"] ?? "No Name"}",
                "Address: ${contactDetails["address"] ?? "No Address"}",
                "Phone: ${contactDetails["phone"] ?? "Not Provided"}",
                "Email: ${contactDetails["email"] ?? "Not Provided"}",
                "GitHub: ${contactDetails["github"] ?? "Not Provided"}",
                "LinkedIn: ${contactDetails["linkedin"] ?? "Not Provided"}",
                "Languages: ${contactDetails["languages"] ?? "Not Provided"}",
              ]),

              // Dynamically Build Resume Sections
              for (var section in template.jsonData["sections"] ?? [])
                _buildSection(
                  section["title"] ?? "Untitled Section",
                  (section["fields"] as List<dynamic>?)
                          ?.map((field) =>
                              "$field: ${userId[field.toString().toLowerCase()] ?? 'Not Provided'}")
                          .toList() ??
                      [],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build sections dynamically
  Widget _buildSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                item,
                style: TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}*/
/*

import 'package:flutter/material.dart';
import '../models/resume_template.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId; // Renamed from userId to userData ✅

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    // 🔥 Debugging: Print userData in console
    print("🔥 Debug - User Data: $userId");

    // Extract contact details safely
    Map<String, dynamic> contactDetails = userId["contactDetails"] ?? {};

    return Scaffold(
      appBar: AppBar(
          title: Text(template.templateName)), // ✅ Shows correct template name
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // ✅ Prevents overflow issues
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Contact Details Section
              _buildSection("Personal Information", [
                "Name: ${contactDetails["name"] ?? "No Name"}",
                "Address: ${contactDetails["address"] ?? "No Address"}",
                "Phone: ${contactDetails["phone"] ?? "Not Provided"}",
                "Email: ${contactDetails["email"] ?? "Not Provided"}",
                "GitHub: ${contactDetails["github"] ?? "Not Provided"}",
                "LinkedIn: ${contactDetails["linkedin"] ?? "Not Provided"}",
                "Languages: ${contactDetails["languages"] ?? "Not Provided"}",
              ]),

              // ✅ Dynamically Generate Resume Sections
              for (var section in template.jsonData["sections"] ?? [])
                _buildSection(
                  section["title"] ?? "Untitled Section",
                  (section["fields"] as List<dynamic>?)
                          ?.map((field) =>
                              "$field: ${_getFieldValue(userId, field)}")
                          .toList() ??
                      [],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔍 Helper function to extract field value safely
  String _getFieldValue(Map<String, dynamic> data, dynamic field) {
    String key = field.toString().toLowerCase();
    return data[key] ?? 'Not Provided';
  }

  // 🎨 Helper method to build sections dynamically
  Widget _buildSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                item,
                style: TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}
*/
/* 
import 'package:flutter/material.dart';
import '../models/resume_template.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId; // ✅ Ensure it's `Map<String, dynamic>`

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    print("🔥 Debug - User Data: $userId"); // Debugging print

    // Extract `contactDetails` properly
    Map<String, dynamic> contactDetails = userId["contactDetails"] ?? {};

    return Scaffold(
      appBar: AppBar(title: Text(template.templateName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Contact Details Section
              _buildSection("Personal Information", [
                "Name: ${contactDetails["name"] ?? "No Name"}",
                "Address: ${contactDetails["address"] ?? "No Address"}",
                "Phone: ${contactDetails["phone"] ?? "Not Provided"}",
                "Email: ${contactDetails["email"] ?? "Not Provided"}",
                "GitHub: ${contactDetails["github"] ?? "Not Provided"}",
                "LinkedIn: ${contactDetails["linkedin"] ?? "Not Provided"}",
                "Languages: ${contactDetails["languages"] ?? "Not Provided"}",
              ]
              ),
            
              // ✅ Dynamically Generate Resume Sections
              for (var section in template.jsonData["sections"] ?? [])
                _buildSection(
                  section["title"] ?? "Untitled Section",
                  (section["fields"] as List<dynamic>?)
                          ?.map((field) =>
                              "$field: ${_getFieldValue(userId, field)}")
                          .toList() ??
                      [],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔍 Fix `_getFieldValue` to check `contactDetails`
  String _getFieldValue(Map<String, dynamic> data, dynamic field) {
    String key = field.toString().toLowerCase();
    return data["contactDetails"]?[key] ?? 'Not Provided';
  }

  // 🎨 Helper method to build sections dynamically
  Widget _buildSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          for (var item in items)
            Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Text(item, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
*/

/*
import 'package:flutter/material.dart';
import '../models/resume_template.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId;

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    print("🔥 Debug - User Data: $userId");

    Map<String, dynamic> contactDetails = userId["contactDetails"] ?? {};
    Map<String, dynamic> education = userId["education"] ?? {};
    Map<String, dynamic> experience = userId["experience"] ?? {};
    Map<String, dynamic> projects = userId["projects"] ?? {};
    Map<String, dynamic> skills = userId["skills"] ?? {};
    Map<String, dynamic> awards = userId["awards"] ?? {};
    Map<String, dynamic> certificates = userId["certificates"] ?? {};

    return Scaffold(
      appBar: AppBar(title: Text(template.templateName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection("Personal Information", [
                "Name: ${contactDetails["name"] ?? "No Name"}",
                "Address: ${contactDetails["address"] ?? "No Address"}",
                "Phone: ${contactDetails["phone"] ?? "Not Provided"}",
                "Email: ${contactDetails["email"] ?? "Not Provided"}",
                "GitHub: ${contactDetails["github"] ?? "Not Provided"}",
                "LinkedIn: ${contactDetails["linkedin"] ?? "Not Provided"}",
                "Languages: ${contactDetails["languages"] ?? "Not Provided"}",
              ]),
              _buildSection("Education", [
                "Qualification: ${education["qualification"] ?? "Not Provided"}",
                "Institution Name: ${education["institution"] ?? "Not Provided"}",
                "Course Join Date: ${education["course_join_date"] ?? "Not Provided"}",
                "Course Completion Date: ${education["course_completion_date"] ?? "Not Provided"}",
              ]),
              _buildSection("Experience", [
                "Company: ${experience["company"] ?? "Not Provided"}",
                "Role: ${experience["role"] ?? "Not Provided"}",
                "Duration: ${experience["duration"] ?? "Not Provided"}",
              ]),
              _buildSection("Projects", [
                "Project Title: ${projects["title"] ?? "Not Provided"}",
                "Description: ${projects["description"] ?? "Not Provided"}",
              ]),
              _buildSection("Skills", [
                "Skills: ${skills["list"] ?? "Not Provided"}",
              ]),
              _buildSection("Awards", [
                "Award: ${awards["title"] ?? "Not Provided"}",
                "Year: ${awards["year"] ?? "Not Provided"}",
              ]),
              _buildSection("Certificates", [
                "Certificate Name: ${certificates["name"] ?? "Not Provided"}",
                "Issued By: ${certificates["issued_by"] ?? "Not Provided"}",
              ]),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Format Map data properly (for lists like education, experience, etc.)
  String _formatMap(dynamic item) {
    if (item is Map<String, dynamic>) {
      return item.entries.map((e) => "${e.key}: ${e.value}").join(", ");
    }
    return item.toString();
  }

  Widget _buildSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(item, style: TextStyle(fontSize: 16)),
            ),
        ],
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import '../models/resume_template.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId; // ✅ Ensure it's `Map<String, dynamic>`

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    print("🔥 Debug - User Data: $userId"); // Debugging print

    // Extracting data from userId
    Map<String, dynamic> contactDetails = userId["contactDetails"] ?? {};
    List<dynamic> education = userId["education"] ?? [];
    List<dynamic> experience = userId["experience"] ?? [];
    List<dynamic> skills = userId["skills"] ?? [];
    List<dynamic> awards = userId["awards"] ?? [];
    List<dynamic> certificates = userId["certificates"] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(template.templateName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Contact Details Section
              _buildSection("Personal Information", [
                "Name: ${contactDetails["name"] ?? "No Name"}",
                "Address: ${contactDetails["address"] ?? "No Address"}",
                "Phone: ${contactDetails["phone"] ?? "Not Provided"}",
                "Email: ${contactDetails["email"] ?? "Not Provided"}",
                "GitHub: ${contactDetails["github"] ?? "Not Provided"}",
                "LinkedIn: ${contactDetails["linkedin"] ?? "Not Provided"}",
                "Languages: ${contactDetails["languages"] ?? "Not Provided"}",
              ]),

              // ✅ Education Section
              _buildSection("Education",
                  education.map((edu) => _formatMap(edu)).toList()),

              // ✅ Experience Section
              _buildSection("Experience",
                  experience.map((exp) => _formatMap(exp)).toList()),

              // ✅ Skills Section
              _buildSection("Skills", skills.map((s) => s.toString()).toList()),

              // ✅ Awards Section
              _buildSection("Awards", awards.map((a) => a.toString()).toList()),

              // ✅ Certificates Section
              _buildSection("Certificates",
                  certificates.map((c) => c.toString()).toList()),

              // ✅ Dynamically Generate Additional Sections
              for (var section in template.jsonData["sections"] ?? [])
                _buildSection(
                  section["title"] ?? "Untitled Section",
                  (userId[section["key"]] as List<dynamic>?)
                          ?.map((item) => _formatMap(item))
                          .toList() ??
                      [],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Format key-value pairs properly (for education, experience, etc.)
  String _formatMap(dynamic item) {
    if (item is Map<String, dynamic>) {
      return item.entries.map((e) => "${e.key}: ${e.value}").join(", ");
    }
    return item.toString();
  }

  // 🎨 Helper method to build sections dynamically
  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(item, style: TextStyle(fontSize: 16)),
            ),
        ],
      ),
    );
  }
}
*/

/*

import 'package:flutter/material.dart';
import '../models/resume_template.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId; // ✅ Ensure it's `Map<String, dynamic>`

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    print("🔥 Debug - User Data: $userId"); // Debugging print

    // Extract user data
    Map<String, dynamic> contactDetails = userId["contactDetails"] ?? {};
    List<dynamic> education = userId["education"] ?? [];
    List<dynamic> experience = userId["experience"] ?? [];
    List<dynamic> technicalSkills = userId["technicalSkills"] ?? [];
    List<dynamic> softSkills = userId["softSkills"] ?? [];
    List<dynamic> projects = userId["projects"] ?? [];
    List<dynamic> awards = userId["awards"] ?? [];
    List<dynamic> certificates = userId["certificates"] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(template.templateName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Personal Information Section
              _buildSection("Personal Information", [
                "Name: ${contactDetails["name"] ?? "No Name"}",
                "Address: ${contactDetails["address"] ?? "No Address"}",
                "Phone: ${contactDetails["phone"] ?? "Not Provided"}",
                "Email: ${contactDetails["email"] ?? "Not Provided"}",
                "GitHub: ${contactDetails["github"] ?? "Not Provided"}",
                "LinkedIn: ${contactDetails["linkedin"] ?? "Not Provided"}",
                "Languages: ${contactDetails["languages"] ?? "Not Provided"}",
              ]),

              // ✅ Education Section
              _buildSection(
                  "Education",
                  education
                      .map((edu) =>
                          "Qualification: ${edu['Qualification'] ?? "Not Provided"}\n"
                          "Institution: ${edu['Institution'] ?? "Not Provided"}\n"
                          "Join Date: ${edu['Join Date'] ?? "Not Provided"}\n"
                          "Completion Date: ${edu['Completion Date'] ?? "Not Provided"}\n")
                      .toList()),

              // ✅ Experience Section
              _buildSection(
                  "Work Experience",
                  experience
                      .map((exp) =>
                          "Job Title: ${exp['Job Title'] ?? "Not Provided"}\n"
                          "Company: ${exp['Company'] ?? "Not Provided"}\n"
                          "Start Date: ${exp['Start Date'] ?? "Not Provided"}\n"
                          "End Date: ${exp['End Date'] ?? "Not Provided"}\n")
                      .toList()),

              // ✅ Skills Section (Both Technical & Soft Skills)
              _buildSection("Technical Skills",
                  technicalSkills.map((skill) => skill.toString()).toList()),
              _buildSection("Soft Skills",
                  softSkills.map((skill) => skill.toString()).toList()),

              // ✅ Projects Section
              _buildSection(
                  "Projects",
                  projects
                      .map((proj) =>
                          "Title: ${proj['title'] ?? "Not Provided"}\n"
                          "Role: ${proj['role'] ?? "Not Provided"}\n"
                          "Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n")
                      .toList()),

              // ✅ Awards & Certifications Section
              _buildSection("Awards & Achievements",
                  awards.map((award) => award.toString()).toList()),

              _buildSection("Certificates",
                  certificates.map((cert) => cert.toString()).toList()),
            ],
          ),
        ),
      ),
    );
  }

  // 🎨 Helper method to build sections dynamically (Same format as Personal Information)
  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox(); // Hide if empty

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(item, style: TextStyle(fontSize: 16)),
            ),
        ],
      ),
    );
  }
}
*/
/*correct one

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/resume_template.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId;

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> contactDetails = userId["contactDetails"] ?? {};
    List<dynamic> education = userId["education"] ?? [];
    List<dynamic> experience = userId["experience"] ?? [];
    List<dynamic> technicalSkills = userId["technicalSkills"] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text("Resume Preview")),
      body: Center(
        child: Container(
          width: 595, // A4 width in pixels
          height: 842, // A4 height in pixels
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Center(
                  child: Column(
                    children: [
                      Text(contactDetails["name"] ?? "No Name",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(
                          "${contactDetails["address"] ?? "No Address"} | ${contactDetails["phone"] ?? "Not Provided"} | ${contactDetails["email"] ?? "Not Provided"} | ${contactDetails["github"] ?? "Not Provided"}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
                Divider(thickness: 2),
                SizedBox(height: 16),

                // Experience Section
                _buildSection(
                    "EXPERIENCE",
                    experience
                        .map((exp) =>
                            "${exp['Job Title'] ?? "Unknown"}\n${exp['Company'] ?? "No Company"} | ${exp['Start Date'] ?? "-"} - ${exp['End Date'] ?? "Present"}\n${exp['Description'] ?? "No Description"}")
                        .toList()),
                Divider(),

                // Education Section
                _buildSection(
                    "EDUCATION",
                    education
                        .map((edu) =>
                            "${edu['Qualification'] ?? "Unknown"}\n${edu['Institution'] ?? "No Institution"} | ${edu['Join Date'] ?? "-"} - ${edu['Completion Date'] ?? "Present"}\nGPA: ${edu['GPA'] ?? "N/A"}")
                        .toList()),
                Divider(),

                // Skills Section
                _buildSection("SKILLS",
                    technicalSkills.map((skill) => "• $skill").toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(item, style: TextStyle(fontSize: 16)),
            ),
        ],
      ),
    );
  }
}
*/

/*deepseek code

import 'package:flutter/material.dart';
import '../models/resume_template.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId;

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Extract user data
    Map<String, dynamic> contactDetails = userId["contactDetails"] ?? {};
    List<dynamic> education = userId["education"] ?? [];
    List<dynamic> experience = userId["experience"] ?? [];
    List<dynamic> technicalSkills = userId["technicalSkills"] ?? [];
    List<dynamic> softSkills = userId["softSkills"] ?? [];
    List<dynamic> projects = userId["projects"] ?? [];
    List<dynamic> awards = userId["awards"] ?? [];
    List<dynamic> certificates = userId["certificates"] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(template.templateName)),
      body: Center(
        child: Container(
          width: 595, // A4 width in pixels (595px ≈ 210mm)
          height: 842, // A4 height in pixels (842px ≈ 297mm)
          padding: const EdgeInsets.all(40), // Add padding to simulate margins
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.black, width: 1), // Add border for A4 simulation
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeaderSection(contactDetails),

                // Summary Section
                _buildSection("SUMMARY", [
                  "Analytical, organized and detail-oriented accountant with GAAP expertise and experience in the full spectrum of public accounting. Collaborative team player with ownership mentality and a track record of delivering the highest quality strategic solutions to resolve challenges and propel business growth.",
                ]),

                // Experience Section
                _buildSection("EXPERIENCE", [
                  for (var exp in experience)
                    "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}\n"
                        "${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"}\n"
                        "${exp['Description'] ?? "No description provided."}\n",
                ]),

                // Education Section
                _buildSection("EDUCATION", [
                  for (var edu in education)
                    "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}\n"
                        "${edu['Completion Date'] ?? "Not Provided"}\n",
                ]),

                // Skills Section
                _buildSection("SKILLS", [
                  "Technical Skills: ${technicalSkills.join(", ")}",
                  "Soft Skills: ${softSkills.join(", ")}",
                ]),

                // Projects Section
                _buildSection("PROJECTS", [
                  for (var proj in projects)
                    "${proj['title'] ?? "Not Provided"} | ${proj['role'] ?? "Not Provided"}\n"
                        "Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n",
                ]),

                // Awards & Certificates Section
                _buildSection("AWARDS & CERTIFICATES", [
                  for (var award in awards) award.toString(),
                  for (var cert in certificates) cert.toString(),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🎨 Header Section
  Widget _buildHeaderSection(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "${contactDetails["address"] ?? "No Address"} | "
          "${contactDetails["phone"] ?? "Not Provided"} | "
          "${contactDetails["email"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  // 🎨 Helper method to build sections dynamically
  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox(); // Hide if empty

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                item,
                style: TextStyle(fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }
}
*/
/*chatgpt code
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/resume_template.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId;

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> contactDetails = userId["contactDetails"] ?? {};
    List<dynamic> education = userId["education"] ?? [];
    List<dynamic> experience = userId["experience"] ?? [];
    List<dynamic> technicalSkills = userId["technicalSkills"] ?? [];
    List<dynamic> projects = userId["projects"] ?? [];
    List<dynamic> awards = userId["awards"] ?? [];
    List<dynamic> certificates = userId["certificates"] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text("Resume Preview")),
      body: Center(
        child: Container(
          width: 595, // A4 width in pixels
          height: 842, // A4 height in pixels
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Center(
                  child: Column(
                    children: [
                      Text(contactDetails["name"] ?? "No Name",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(
                          "${contactDetails["address"] ?? "No Address"} | ${contactDetails["phone"] ?? "Not Provided"} | ${contactDetails["email"] ?? "Not Provided"} | ${contactDetails["github"] ?? "Not Provided"}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
                Divider(thickness: 2),
                SizedBox(height: 16),

                // Experience Section
                _buildSection(
                    "EXPERIENCE",
                    experience
                        .map((exp) =>
                            "${exp['Job Title'] ?? "Unknown"}\n${exp['Company'] ?? "No Company"} | ${exp['Start Date'] ?? "-"} - ${exp['End Date'] ?? "Present"}\n${exp['Description'] ?? "No Description"}")
                        .toList()),
                Divider(),

                // Education Section
                _buildSection(
                    "EDUCATION",
                    education
                        .map((edu) =>
                            "${edu['Qualification'] ?? "Unknown"}\n${edu['Institution'] ?? "No Institution"} | ${edu['Join Date'] ?? "-"} - ${edu['Completion Date'] ?? "Present"}\nGPA: ${edu['GPA'] ?? "N/A"}")
                        .toList()),
                Divider(),

                // Skills Section
                _buildSection("SKILLS",
                    technicalSkills.map((skill) => "• $skill").toList()),
                Divider(),

                // Projects Section
                _buildSection(
                    "PROJECTS",
                    projects
                        .map((proj) =>
                            "Title: ${proj['title'] ?? "Not Provided"}\nRole: ${proj['role'] ?? "Not Provided"}\nTechnologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n")
                        .toList()),
                Divider(),

                // Awards & Achievements Section
                _buildSection("AWARDS & ACHIEVEMENTS",
                    awards.map((award) => "• $award").toList()),
                Divider(),

                // Certificates Section
                _buildSection("CERTIFICATES",
                    certificates.map((cert) => "• $cert").toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(item, style: TextStyle(fontSize: 16)),
            ),
        ],
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/resume_template.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId;

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(template.templateName),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = await _generatePdf(userId);
              await Printing.layoutPdf(
                onLayout: (format) => pdf.save(),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 595, // A4 width in pixels (595px ≈ 210mm)
          height: 842, // A4 height in pixels (842px ≈ 297mm)
          padding: const EdgeInsets.all(40), // Add padding to simulate margins
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.black, width: 1), // Add border for A4 simulation
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeaderSection(userId["contactDetails"] ?? {}),

                // Summary Section
                _buildSection("SUMMARY", [
                  "Analytical, organized and detail-oriented accountant with GAAP expertise and experience in the full spectrum of public accounting. Collaborative team player with ownership mentality and a track record of delivering the highest quality strategic solutions to resolve challenges and propel business growth.",
                ]),

                // Experience Section
                _buildSection("EXPERIENCE", [
                  for (var exp in userId["experience"] ?? [])
                    "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}\n"
                        "${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"}\n"
                        "${exp['Description'] ?? "No description provided."}\n",
                ]),

                // Education Section
                _buildSection("EDUCATION", [
                  for (var edu in userId["education"] ?? [])
                    "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}\n"
                        "${edu['Completion Date'] ?? "Not Provided"}\n",
                ]),

                // Skills Section
                _buildSection("SKILLS", [
                  "Technical Skills: ${(userId["technicalSkills"] ?? []).join(", ")}",
                  "Soft Skills: ${(userId["softSkills"] ?? []).join(", ")}",
                ]),

                // Projects Section
                _buildSection("PROJECTS", [
                  for (var proj in userId["projects"] ?? [])
                    "${proj['title'] ?? "Not Provided"} | ${proj['role'] ?? "Not Provided"}\n"
                        "Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n",
                ]),

                // Awards & Certificates Section
                _buildSection("AWARDS & CERTIFICATES", [
                  for (var award in userId["awards"] ?? []) award.toString(),
                  for (var cert in userId["certificates"] ?? [])
                    cert.toString(),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🎨 Header Section
  Widget _buildHeaderSection(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "${contactDetails["address"] ?? "No Address"} | "
          "${contactDetails["phone"] ?? "Not Provided"} | "
          "${contactDetails["email"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  // 🎨 Helper method to build sections dynamically
  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox(); // Hide if empty

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                item,
                style: TextStyle(fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }

  // 🎨 Generate PDF
  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildPdfHeaderSection(userData["contactDetails"] ?? {}),

              // Summary Section
              _buildPdfSection("SUMMARY", [
                "Analytical, organized and detail-oriented accountant with GAAP expertise and experience in the full spectrum of public accounting. Collaborative team player with ownership mentality and a track record of delivering the highest quality strategic solutions to resolve challenges and propel business growth.",
              ]),

              // Experience Section
              _buildPdfSection("EXPERIENCE", [
                for (var exp in userData["experience"] ?? [])
                  "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}\n"
                      "${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"}\n"
                      "${exp['Description'] ?? "No description provided."}\n",
              ]),

              // Education Section
              _buildPdfSection("EDUCATION", [
                for (var edu in userData["education"] ?? [])
                  "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}\n"
                      "${edu['Completion Date'] ?? "Not Provided"}\n",
              ]),

              // Skills Section
              _buildPdfSection("SKILLS", [
                "Technical Skills: ${(userData["technicalSkills"] ?? []).join(", ")}",
                "Soft Skills: ${(userData["softSkills"] ?? []).join(", ")}",
              ]),

              // Projects Section
              _buildPdfSection("PROJECTS", [
                for (var proj in userData["projects"] ?? [])
                  "${proj['title'] ?? "Not Provided"} | ${proj['role'] ?? "Not Provided"}\n"
                      "Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n",
              ]),

              // Awards & Certificates Section
              _buildPdfSection("AWARDS & CERTIFICATES", [
                for (var award in userData["awards"] ?? []) award.toString(),
                for (var cert in userData["certificates"] ?? [])
                  cert.toString(),
              ]),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  // 🎨 PDF Header Section
  pw.Widget _buildPdfHeaderSection(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          "${contactDetails["address"] ?? "No Address"} | "
          "${contactDetails["phone"] ?? "Not Provided"} | "
          "${contactDetails["email"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  // 🎨 PDF Section Builder
  pw.Widget _buildPdfSection(String title, List<String> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              item,
              style: pw.TextStyle(fontSize: 14),
            ),
          ),
      ],
    );
  }
}
*/
/* correct deepseek code
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/resume_template.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId;

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(template.templateName),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = await _generatePdf(userId);
              await Printing.layoutPdf(
                onLayout: (format) => pdf.save(),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 595, // A4 width in pixels (595px ≈ 210mm)
          height: 842, // A4 height in pixels (842px ≈ 297mm)
          padding: const EdgeInsets.all(40), // Add padding to simulate margins
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.black, width: 1), // Add border for A4 simulation
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeaderSection(userId["contactDetails"] ?? {}),

                // Summary Section
                _buildSection("SUMMARY", [
                  "Analytical, organized and detail-oriented accountant with GAAP expertise and experience in the full spectrum of public accounting. Collaborative team player with ownership mentality and a track record of delivering the highest quality strategic solutions to resolve challenges and propel business growth.",
                ]),

                // Experience Section
                _buildSection("EXPERIENCE", [
                  for (var exp in userId["experience"] ?? [])
                    "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}\n"
                        "${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"}\n"
                        "${exp['Description'] ?? "No description provided."}\n",
                ]),

                // Education Section
                _buildSection("EDUCATION", [
                  for (var edu in userId["education"] ?? [])
                    "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}\n"
                        "${edu['Completion Date'] ?? "Not Provided"}\n",
                ]),

                // Skills Section
                _buildSection("SKILLS", [
                  "Technical Skills: ${(userId["technicalSkills"] ?? []).join(", ")}",
                  "Soft Skills: ${(userId["softSkills"] ?? []).join(", ")}",
                ]),

                // Projects Section
                _buildSection("PROJECTS", [
                  for (var proj in userId["projects"] ?? [])
                    "${proj['title'] ?? "Not Provided"} | ${proj['role'] ?? "Not Provided"}\n"
                        "Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n",
                ]),

                // Awards & Certificates Section
                _buildSection("AWARDS & CERTIFICATES", [
                  for (var award in userId["awards"] ?? []) award.toString(),
                  for (var cert in userId["certificates"] ?? [])
                    cert.toString(),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🎨 Header Section
  Widget _buildHeaderSection(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "${contactDetails["address"] ?? "No Address"} | "
          "${contactDetails["phone"] ?? "Not Provided"} | "
          "${contactDetails["email"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  // 🎨 Helper method to build sections dynamically
  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox(); // Hide if empty

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                item,
                style: TextStyle(fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }

  // 🎨 Generate PDF
  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildPdfHeaderSection(userData["contactDetails"] ?? {}),

              // Summary Section
              _buildPdfSection("SUMMARY", [
                "Analytical, organized and detail-oriented accountant with GAAP expertise and experience in the full spectrum of public accounting. Collaborative team player with ownership mentality and a track record of delivering the highest quality strategic solutions to resolve challenges and propel business growth.",
              ]),
              
              // Experience Section
              if ((userData["experience"] ?? []).isNotEmpty)
                _buildPdfSection("EXPERIENCE", [
                  for (var exp in userData["experience"] ?? [])
                    "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}\n"
                        "${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"}\n"
                        "${exp['Description'] ?? "No description provided."}\n",
                ]),

              // Education Section
              if ((userData["education"] ?? []).isNotEmpty)
                _buildPdfSection("EDUCATION", [
                  for (var edu in userData["education"] ?? [])
                    "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}\n"
                        "${edu['Completion Date'] ?? "Not Provided"}\n",
                ]),

              // Skills Section
              if ((userData["technicalSkills"] ?? []).isNotEmpty ||
                  (userData["softSkills"] ?? []).isNotEmpty)
                _buildPdfSection("SKILLS", [
                  if ((userData["technicalSkills"] ?? []).isNotEmpty)
                    "Technical Skills: ${(userData["technicalSkills"] ?? []).join(", ")}",
                  if ((userData["softSkills"] ?? []).isNotEmpty)
                    "Soft Skills: ${(userData["softSkills"] ?? []).join(", ")}",
                ]),

              // Projects Section
              if ((userData["projects"] ?? []).isNotEmpty)
                _buildPdfSection("PROJECTS", [
                  for (var proj in userData["projects"] ?? [])
                    "${proj['title'] ?? "Not Provided"} | ${proj['role'] ?? "Not Provided"}\n"
                        "Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n",
                ]),

              // Awards & Certificates Section
              if ((userData["awards"] ?? []).isNotEmpty ||
                  (userData["certificates"] ?? []).isNotEmpty)
                _buildPdfSection("AWARDS & CERTIFICATES", [
                  for (var award in userData["awards"] ?? []) award.toString(),
                  for (var cert in userData["certificates"] ?? [])
                    cert.toString(),
                ]),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  // 🎨 PDF Header Section
  pw.Widget _buildPdfHeaderSection(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          "${contactDetails["address"] ?? "No Address"} | "
          "${contactDetails["phone"] ?? "Not Provided"} | "
          "${contactDetails["email"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  // 🎨 PDF Section Builder
  pw.Widget _buildPdfSection(String title, List<String> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              item,
              style: pw.TextStyle(fontSize: 14),
            ),
          ),
      ],
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/resume_template.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId;

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(template.templateName),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = await _generatePdf(userId);
              await Printing.layoutPdf(
                onLayout: (format) => pdf.save(),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 595, // A4 width in pixels (595px ≈ 210mm)
          height: 842, // A4 height in pixels (842px ≈ 297mm)
          padding: const EdgeInsets.all(40), // Add padding to simulate margins
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.black, width: 1), // Add border for A4 simulation
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeaderSection(userId["contactDetails"] ?? {}),

                // Summary Section
                _buildSection("SUMMARY", [
                  "Analytical, organized and detail-oriented accountant with GAAP expertise and experience in the full spectrum of public accounting. Collaborative team player with ownership mentality and a track record of delivering the highest quality strategic solutions to resolve challenges and propel business growth.",
                ]),

                // Experience Section
                _buildSection("EXPERIENCE", [
                  for (var exp in userId["experience"] ?? [])
                    "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}\n"
                        "${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"}\n"
                        "${exp['Description'] ?? "No description provided."}\n",
                ]),

                // Education Section
                _buildSection("EDUCATION", [
                  for (var edu in userId["education"] ?? [])
                    "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}\n"
                        "${edu['Completion Date'] ?? "Not Provided"}\n",
                ]),

                // Skills Section
                _buildSection("SKILLS", [
                  "Technical Skills: ${(userId["technicalSkills"] ?? []).join(", ")}",
                  "Soft Skills: ${(userId["softSkills"] ?? []).join(", ")}",
                ]),

                // Projects Section
                _buildSection("PROJECTS", [
                  for (var proj in userId["projects"] ?? [])
                    "${proj['title'] ?? "Not Provided"} | ${proj['role'] ?? "Not Provided"}\n"
                        "Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n",
                ]),

                // Awards & Certificates Section
                _buildSection("AWARDS & CERTIFICATES", [
                  for (var award in userId["awards"] ?? []) award.toString(),
                  for (var cert in userId["certificates"] ?? [])
                    cert.toString(),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🎨 Header Section
  Widget _buildHeaderSection(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "${contactDetails["address"] ?? "No Address"} | "
          "${contactDetails["phone"] ?? "Not Provided"} | "
          "${contactDetails["email"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  // 🎨 Helper method to build sections dynamically
  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox(); // Hide if empty

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 2, color: Colors.black), // Add a line separator
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              item,
              style: TextStyle(fontSize: 14),
            ),
          ),
        SizedBox(height: 16), // Add extra space after each section
      ],
    );
  }

  // 🎨 Generate PDF
  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildPdfHeaderSection(userData["contactDetails"] ?? {}),

              // Summary Section
              _buildPdfSection("SUMMARY", [
                "Analytical, organized and detail-oriented accountant with GAAP expertise and experience in the full spectrum of public accounting. Collaborative team player with ownership mentality and a track record of delivering the highest quality strategic solutions to resolve challenges and propel business growth.",
              ]),

              // Experience Section
              if ((userData["experience"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(), // Add a line separator
                _buildPdfSection("EXPERIENCE", [
                  for (var exp in userData["experience"] ?? [])
                    "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}\n"
                        "${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"}\n"
                        "${exp['Description'] ?? "No description provided."}\n",
                ]),
              ],

              // Education Section
              if ((userData["education"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(), // Add a line separator
                _buildPdfSection("EDUCATION", [
                  for (var edu in userData["education"] ?? [])
                    "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}\n"
                        "${edu['Completion Date'] ?? "Not Provided"}\n",
                ]),
              ],

              // Skills Section
              if ((userData["technicalSkills"] ?? []).isNotEmpty ||
                  (userData["softSkills"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(), // Add a line separator
                _buildPdfSection("SKILLS", [
                  if ((userData["technicalSkills"] ?? []).isNotEmpty)
                    "Technical Skills: ${(userData["technicalSkills"] ?? []).join(", ")}",
                  if ((userData["softSkills"] ?? []).isNotEmpty)
                    "Soft Skills: ${(userData["softSkills"] ?? []).join(", ")}",
                ]),
              ],

              // Projects Section
              if ((userData["projects"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(), // Add a line separator
                _buildPdfSection("PROJECTS", [
                  for (var proj in userData["projects"] ?? [])
                    "${proj['title'] ?? "Not Provided"} | ${proj['role'] ?? "Not Provided"}\n"
                        "Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n",
                ]),
              ],

              // Awards & Certificates Section
              if ((userData["awards"] ?? []).isNotEmpty ||
                  (userData["certificates"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(), // Add a line separator
                _buildPdfSection("AWARDS & CERTIFICATES", [
                  for (var award in userData["awards"] ?? []) award.toString(),
                  for (var cert in userData["certificates"] ?? [])
                    cert.toString(),
                ]),
              ],
            ],
          );
        },
      ),
    );

    return pdf;
  }

  // 🎨 PDF Header Section
  pw.Widget _buildPdfHeaderSection(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          "${contactDetails["address"] ?? "No Address"} | "
          "${contactDetails["phone"] ?? "Not Provided"} | "
          "${contactDetails["email"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  // 🎨 PDF Section Builder
  pw.Widget _buildPdfSection(String title, List<String> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              item,
              style: pw.TextStyle(fontSize: 14),
            ),
          ),
        pw.SizedBox(height: 16), // Add extra space after each section
      ],
    );
  }

  // 🎨 PDF Divider
  pw.Widget _buildPdfDivider() {
    return pw.Divider(
      thickness: 2,
      color: PdfColors.black,
    );
  }
}
