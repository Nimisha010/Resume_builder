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
/* correct one
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
*/

// resume_preview.dart
/*
import 'package:flutter/material.dart';
import '../models/resume_template.dart';
import '../Screen/templates/template1.dart'; // Import other templates as needed

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId;

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    Widget resumeWidget;

    switch (template.templateName) {
      case 'Classic Resume':
        resumeWidget = Template1(userId: userId);
        break;
      // Add cases for other templates
      default:
        resumeWidget = Center(child: Text('Template not found'));
    }

    return Scaffold(
      appBar: AppBar(title: Text(template.templateName)),
      body: Center(child: resumeWidget),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import '../models/resume_template.dart';
import '../Screen/templates/template1.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeTemplate template;
  final Map<String, dynamic> userId;
  final GlobalKey _globalKey = GlobalKey();

  ResumePreviewScreen({required this.template, required this.userId});

  @override
  Widget build(BuildContext context) {
    Widget resumeWidget;

    switch (template.templateName) {
      case 'Classic Resume':
        resumeWidget = Template1(userId: userId);
        break;
      default:
        resumeWidget = Center(child: Text('Template not found'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(template.templateName),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () => _printResume(context),
          ),
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () => _savePdf(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: _globalKey,
          child: Center(child: resumeWidget),
        ),
      ),
    );
  }

  Future<void> _savePdf(BuildContext context) async {
    final pdf = pw.Document();
    final image = await _capturePng();

    if (image != null) {
      final imagePdf = pw.MemoryImage(image);
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(imagePdf),
            );
          },
        ),
      );
    }

    await Printing.sharePdf(bytes: await pdf.save(), filename: 'resume.pdf');
  }

  Future<void> _printResume(BuildContext context) async {
    final pdf = pw.Document();
    final image = await _capturePng();

    if (image != null) {
      final imagePdf = pw.MemoryImage(image);
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(imagePdf),
            );
          },
        ),
      );
    }

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  Future<Uint8List?> _capturePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print('Error capturing image: $e');
      return null;
    }
  }
}
*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'templates/template1.dart';
import 'templates/template2.dart';
import 'templates/template3.dart';
import 'templates/template4.dart';
import 'templates/template5.dart';
import 'templates/template6.dart';
import 'templates/template7.dart';

class ResumePreviewScreen extends StatefulWidget {
  final String templateName;
  final String userId;

  ResumePreviewScreen({required this.templateName, required this.userId});

  @override
  _ResumePreviewScreenState createState() => _ResumePreviewScreenState();
}

class _ResumePreviewScreenState extends State<ResumePreviewScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();
      if (doc.exists) {
        setState(() {
          userData = doc.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Resume Preview")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      //appBar: AppBar(title: Text("Preview - ${widget.templateName}")),
      body: _getTemplateWidget(widget.templateName, userData!),
    );
  }

  Widget _getTemplateWidget(
      String templateName, Map<String, dynamic> userData) {
    switch (templateName) {
      case 'Classic Resume':
        return Template1(userId: userData);
      case 'Modern Resume':
        return Template2(userData: userData);
      case 'Red Template':
        return Template3(userId: userData);
      case 'Green Template':
        return Template4(userId: userData);
      case 'Column Resume':
        return Template5(userId: widget.userId);
      case 'Professional Resume':
        return Template6(userId: widget.userId);
      case 'Column Template':
        return Template7(userId: widget.userId);
      default:
        return Center(child: Text('Template not found'));
    }
  }
}
