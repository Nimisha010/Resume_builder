/*import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class Template4 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template4({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Green Template"),
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
          width: 595,
          height: 842,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(userId["contactDetails"] ?? {}),
                _buildSection("Experience",
                    _formatExperience(userId["experience"] ?? [])),
                _buildSection(
                    "Education", _formatEducation(userId["education"] ?? [])),
                _buildSkillsSection(userId["skills"] ?? []),
                _buildSection(
                    "Projects", _formatProjects(userId["projects"] ?? [])),
                _buildSection("Awards & Achievements",
                    _formatList(userId["awards"] ?? [])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            padding: pw.EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildPdfHeader(userData["contactDetails"] ?? {}),
                _buildPdfSection("Experience",
                    _formatExperience(userData["experience"] ?? [])),
                _buildPdfSection(
                    "Education", _formatEducation(userData["education"] ?? [])),
                _buildPdfSkillsSection(userData["skills"] ?? []),
                _buildPdfSection(
                    "Projects", _formatProjects(userData["projects"] ?? [])),
                _buildPdfSection("Awards & Achievements",
                    _formatList(userData["awards"] ?? [])),
              ],
            ),
          );
        },
      ),
    );
    return pdf;
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(contactDetails["name"] ?? "No Name",
            style: pw.TextStyle(
                fontSize: 32,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.green)),
        pw.SizedBox(height: 5),
        pw.Text(contactDetails["title"] ?? "",
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Text(contactDetails["phone"] ?? ""),
        pw.Text(contactDetails["email"] ?? ""),
        pw.Text(contactDetails["address"] ?? ""),
        pw.Text(contactDetails["website"] ?? ""),
        pw.SizedBox(height: 16),
      ],
    );
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
      return DateFormat("MMMM yyyy").format(parsedDate);
    } catch (e) {
      return "Invalid Date"; // Return fallback if parsing fails
    }
  }

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      String jobTitle = exp["Job Title"] ?? "Not Provided";
      String company = exp["Company"] ?? "Not Provided";
      String startDate = _formatDate(exp["Start Date"] ?? "");
      String endDate = exp["End Date"] == "Present"
          ? "Present"
          : _formatDate(exp["End Date"] ?? "");

      String description = exp["Description"] ?? ""; // Include job description

      return "$jobTitle    |    $company\n$startDate - $endDate\n\n$description"
          .trim();
    }).toList();
  }

  Widget _buildHeader(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} | ${contactDetails["email"] ?? "Not Provided"} | ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSkillsSection(List<dynamic> skills) {
    if (skills.isEmpty) {
      return SizedBox();
    }

    // Convert to a List<String> safely
    List<String> formattedSkills =
        skills.map((skill) => skill.toString()).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          "Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
              formattedSkills.map((skill) => Chip(label: Text(skill))).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSkillsSection(List<dynamic> skills) {
    if (skills.isEmpty) return pw.SizedBox();

    List<String> formattedSkills =
        skills.map((skill) => skill.toString()).toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 8),
        pw.Text(
          "Skills",
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        pw.Wrap(
          spacing: 10,
          runSpacing: 10,
          children: formattedSkills
              .map((skill) => pw.Container(
                    padding: pw.EdgeInsets.all(5),
                    decoration: pw.BoxDecoration(
                      border:
                          pw.Border.all(color: PdfColors.green900, width: 1),
                      borderRadius: pw.BorderRadius.circular(5),
                    ),
                    child: pw.Text(skill, style: pw.TextStyle(fontSize: 14)),
                  ))
              .toList(),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<String> items) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 8),
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: pw.EdgeInsets.only(bottom: 6.0),
            child: pw.RichText(
              text: pw.TextSpan(
                text: item.split("\n")[0],
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                children: [
                  pw.TextSpan(
                    text: "\n" + item.split("\n").skip(1).join("\n"),
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.normal),
                  )
                ],
              ),
            ),
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      String qualification = edu["Qualification"] ?? "Not Provided";
      String institution = edu["Institution"] ?? "Not Provided";
      String joinDate = _formatDate(edu["Join Date"] ?? "");
      String completionDate =
          _formatDate(edu["Completion Date"] ?? ""); // Format completion date

      return "$qualification\n$institution\n$completionDate - $joinDate";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) => projects
      .map((proj) =>
          "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\nTechnologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}")
      .toList();

  List<String> _formatList(List<dynamic> list) =>
      list.map((item) => item.toString()).toList();

  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(item, style: TextStyle(fontSize: 14)),
                  ))
              .toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class Template4 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template4({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Green Template"),
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
          width: 595,
          height: 842,
          padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(color: Colors.green[900]!, width: 5),
              right: BorderSide(color: Colors.green[900]!, width: 5),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(userId["contactDetails"] ?? {}),
                _buildSection("Experience",
                    _formatExperience(userId["experience"] ?? [])),
                _buildSection(
                    "Education", _formatEducation(userId["education"] ?? [])),
                _buildSkillsSection(userId["skills"] ?? []),
                _buildSection(
                    "Projects", _formatProjects(userId["projects"] ?? [])),
                _buildSection("Awards & Achievements",
                    _formatList(userId["awards"] ?? [])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            padding: pw.EdgeInsets.fromLTRB(40, 30, 40, 30),
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(color: PdfColors.green900, width: 5),
                right: pw.BorderSide(color: PdfColors.green900, width: 5),
              ),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildPdfHeader(userData["contactDetails"] ?? {}),
                _buildPdfSection("Experience",
                    _formatExperience(userData["experience"] ?? [])),
                _buildPdfSection(
                    "Education", _formatEducation(userData["education"] ?? [])),
                _buildPdfSkillsSection(userData["skills"] ?? []),
                _buildPdfSection(
                    "Projects", _formatProjects(userData["projects"] ?? [])),
                _buildPdfSection("Awards & Achievements",
                    _formatList(userData["awards"] ?? [])),
              ],
            ),
          );
        },
      ),
    );
    return pdf;
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(contactDetails["name"] ?? "No Name",
            style: pw.TextStyle(
                fontSize: 32,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.green)),
        pw.SizedBox(height: 5),
        pw.Text(contactDetails["title"] ?? "",
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Text(contactDetails["phone"] ?? ""),
        pw.Text(contactDetails["email"] ?? ""),
        pw.Text(contactDetails["address"] ?? ""),
        pw.Text(contactDetails["website"] ?? ""),
        pw.SizedBox(height: 16),
      ],
    );
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
      return DateFormat("MMMM yyyy").format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

  Widget _buildHeader(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} | ${contactDetails["email"] ?? "Not Provided"} | ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSkillsSection(List<dynamic> skills) {
    if (skills.isEmpty) {
      return SizedBox();
    }

    // Convert to a List<String> safely
    List<String> formattedSkills =
        skills.map((skill) => skill.toString()).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          "Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
              formattedSkills.map((skill) => Chip(label: Text(skill))).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSkillsSection(List<dynamic> skills) {
    if (skills.isEmpty) return pw.SizedBox();

    List<String> formattedSkills =
        skills.map((skill) => skill.toString()).toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 8),
        pw.Text(
          "Skills",
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        pw.Wrap(
          spacing: 10,
          runSpacing: 10,
          children: formattedSkills
              .map((skill) => pw.Container(
                    padding: pw.EdgeInsets.all(5),
                    decoration: pw.BoxDecoration(
                      border:
                          pw.Border.all(color: PdfColors.green900, width: 1),
                      borderRadius: pw.BorderRadius.circular(5),
                    ),
                    child: pw.Text(skill, style: pw.TextStyle(fontSize: 14)),
                  ))
              .toList(),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<String> items) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 8),
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: pw.EdgeInsets.only(bottom: 6.0),
            child: pw.RichText(
              text: pw.TextSpan(
                text: item.split("\n")[0],
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                children: [
                  pw.TextSpan(
                    text: "\n" + item.split("\n").skip(1).join("\n"),
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.normal),
                  )
                ],
              ),
            ),
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      String qualification = edu["Qualification"] ?? "Not Provided";
      String institution = edu["Institution"] ?? "Not Provided";
      String joinDate = _formatDate(edu["Join Date"] ?? "");
      String completionDate =
          _formatDate(edu["Completion Date"] ?? ""); // Format completion date

      return "$qualification\n$institution\n$completionDate - $joinDate";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) => projects
      .map((proj) =>
          "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\nTechnologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}")
      .toList();

  List<String> _formatList(List<dynamic> list) =>
      list.map((item) => item.toString()).toList();

  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(item, style: TextStyle(fontSize: 14)),
                  ))
              .toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      String jobTitle = exp["Job Title"] ?? "Not Provided";
      String company = exp["Company"] ?? "Not Provided";
      String startDate = _formatDate(exp["Start Date"] ?? "");
      String endDate = exp["End Date"] == "Present"
          ? "Present"
          : _formatDate(exp["End Date"] ?? "");
      String description = exp["Description"] ?? "";
      return "$jobTitle    |    $company\n$startDate - $endDate\n\n$description"
          .trim();
    }).toList();
  }
}
*/

/* correct green template

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class Template4 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template4({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Green Template"),
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
          width: 595,
          height: 842,
          child: Row(
            children: [
              Container(
                width: 5, // Left Border
                color: Colors.green[900],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(userId["contactDetails"] ?? {}),
                        _buildSection("Experience",
                            _formatExperience(userId["experience"] ?? [])),
                        _buildSection("Education",
                            _formatEducation(userId["education"] ?? [])),
                        _buildSkillsSection(userId["skills"] ?? []),
                        _buildSection("Projects",
                            _formatProjects(userId["projects"] ?? [])),
                        _buildSection("Awards & Achievements",
                            _formatList(userId["awards"] ?? [])),
                        _buildSection("Certificates",
                            _formatList(userId["certificates"] ?? [])),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 5, // Right Border
                color: Colors.green[900],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Row(
            children: [
              pw.Container(
                width: 5, // Left Border
                height: double.infinity,
                color: PdfColors.green900,
              ),
              pw.Expanded(
                child: pw.Padding(
                  padding: pw.EdgeInsets.fromLTRB(40, 30, 40, 30),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildPdfHeader(userData["contactDetails"] ?? {}),
                      _buildPdfSection("Experience",
                          _formatExperience(userData["experience"] ?? [])),
                      _buildPdfSection("Education",
                          _formatEducation(userData["education"] ?? [])),
                      _buildPdfSkillsSection(userData["skills"] ?? []),
                      _buildPdfSection("Projects",
                          _formatProjects(userData["projects"] ?? [])),
                      _buildPdfSection("Awards & Achievements",
                          _formatList(userData["awards"] ?? [])),
                      _buildPdfSection("Certificates",
                          _formatList(userData["certificates"] ?? [])),
                    ],
                  ),
                ),
              ),
              pw.Container(
                width: 5, // Right Border
                height: double.infinity,
                color: PdfColors.green900,
              ),
            ],
          );
        },
      ),
    );
    return pdf;
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(contactDetails["name"] ?? "No Name",
            style: pw.TextStyle(
                fontSize: 32,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.green900)),
        pw.SizedBox(height: 5),
        pw.Text(contactDetails["title"] ?? "",
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Text(contactDetails["phone"] ?? ""),
        pw.Text(contactDetails["email"] ?? ""),
        pw.Text(contactDetails["address"] ?? ""),
        pw.Text(contactDetails["website"] ?? ""),
        pw.SizedBox(height: 16),
      ],
    );
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
      return DateFormat("MMMM yyyy").format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

  Widget _buildHeader(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} | ${contactDetails["email"] ?? "Not Provided"} | ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSkillsSection(List<dynamic> skills) {
    if (skills.isEmpty) {
      return SizedBox();
    }

    // Convert to a List<String> safely
    List<String> formattedSkills =
        skills.map((skill) => skill.toString()).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          "Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
              formattedSkills.map((skill) => Chip(label: Text(skill))).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSkillsSection(List<dynamic> skills) {
    if (skills.isEmpty) return pw.SizedBox();

    List<String> formattedSkills =
        skills.map((skill) => skill.toString()).toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 8),
        pw.Text(
          "Skills",
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        pw.Wrap(
          spacing: 10,
          runSpacing: 10,
          children: formattedSkills
              .map((skill) => pw.Container(
                    padding: pw.EdgeInsets.all(5),
                    decoration: pw.BoxDecoration(
                      border:
                          pw.Border.all(color: PdfColors.green900, width: 1),
                      borderRadius: pw.BorderRadius.circular(5),
                    ),
                    child: pw.Text(skill, style: pw.TextStyle(fontSize: 14)),
                  ))
              .toList(),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<String> items) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 8),
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: pw.EdgeInsets.only(bottom: 6.0),
            child: pw.RichText(
              text: pw.TextSpan(
                text: item.split("\n")[0],
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                children: [
                  pw.TextSpan(
                    text: "\n" + item.split("\n").skip(1).join("\n"),
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.normal),
                  )
                ],
              ),
            ),
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      String qualification = edu["Qualification"] ?? "Not Provided";
      String institution = edu["Institution"] ?? "Not Provided";
      String joinDate = _formatDate(edu["Join Date"] ?? "");
      String completionDate =
          _formatDate(edu["Completion Date"] ?? ""); // Format completion date

      return "$qualification\n$institution\n$completionDate - $joinDate";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) => projects
      .map((proj) =>
          "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\nTechnologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}")
      .toList();

  List<String> _formatList(List<dynamic> list) =>
      list.map((item) => item.toString()).toList();

  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(item, style: TextStyle(fontSize: 14)),
                  ))
              .toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      String jobTitle = exp["Job Title"] ?? "Not Provided";
      String company = exp["Company"] ?? "Not Provided";
      String startDate = _formatDate(exp["Start Date"] ?? "");
      String endDate = exp["End Date"] == "Present"
          ? "Present"
          : _formatDate(exp["End Date"] ?? "");
      String description = exp["Description"] ?? "";
      return "$jobTitle    |    $company\n$startDate - $endDate\n\n$description"
          .trim();
    }).toList();
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class Template4 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template4({required this.userId});

  @override
  Widget build(BuildContext context) {
    print("User ID Data: $userId");
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Green Template"),
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
          width: 595,
          height: 842,
          child: Row(
            children: [
              Container(
                width: 5, // Left Border
                color: Colors.green[900],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(userId["contactDetails"] ?? {}),
                        _buildSection("Experience",
                            _formatExperience(userId["experience"] ?? [])),
                        _buildSection("Education",
                            _formatEducation(userId["education"] ?? [])),
                        _buildSkillsSection(userId),
                        _buildSection("Projects",
                            _formatProjects(userId["projects"] ?? [])),
                        _buildSection("Awards & Achievements",
                            _formatList(userId["awards"] ?? [])),
                        _buildSection("Certificates",
                            _formatList(userId["certificates"] ?? [])),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 5, // Right Border
                color: Colors.green[900],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();

    // Wait for the skills section to be built
    final skillsSection = await _buildPdfSkillsSection(userData);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Row(
            children: [
              pw.Container(
                width: 5, // Left Border
                height: double.infinity,
                color: PdfColors.green900,
              ),
              pw.Expanded(
                child: pw.Padding(
                  padding: pw.EdgeInsets.fromLTRB(40, 30, 40, 30),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildPdfHeader(userData["contactDetails"] ?? {}),
                      _buildPdfSection("Experience",
                          _formatExperience(userData["experience"] ?? [])),
                      _buildPdfSection("Education",
                          _formatEducation(userData["education"] ?? [])),
                      _buildPdfSkillsSection(userData),
                      _buildPdfSection("Projects",
                          _formatProjects(userData["projects"] ?? [])),
                      _buildPdfSection("Awards & Achievements",
                          _formatList(userData["awards"] ?? [])),
                      _buildPdfSection("Certificates",
                          _formatList(userData["certificates"] ?? [])),
                    ],
                  ),
                ),
              ),
              pw.Container(
                width: 5, // Right Border
                height: double.infinity,
                color: PdfColors.green900,
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(contactDetails["name"] ?? "No Name",
            style: pw.TextStyle(
                fontSize: 32,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.green900)),
        pw.SizedBox(height: 5),
        pw.Text(contactDetails["title"] ?? "",
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Text(contactDetails["phone"] ?? ""),
        pw.Text(contactDetails["email"] ?? ""),
        pw.Text(contactDetails["address"] ?? ""),
        pw.Text(contactDetails["website"] ?? ""),
        pw.SizedBox(height: 16),
      ],
    );
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
      return DateFormat("MMMM yyyy").format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

  Widget _buildHeader(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} | ${contactDetails["email"] ?? "Not Provided"} | ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Map<String, dynamic> getSectionById(
      List<dynamic> sections, String sectionId) {
    print("Sections: $sections"); // Debugging line
    for (var section in sections) {
      if (section["section_id"] == sectionId) {
        return section;
      }
    }
    return {}; // Return an empty map if the section is not found
  }

  Widget _buildSkillsSection(Map<String, dynamic> userData) {
    // Extract soft skills and technical skills
    List<dynamic> softSkills = userData["softSkills"] ?? [];
    List<dynamic> technicalSkills = userData["technicalSkills"] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Soft Skills Subheading
        SizedBox(height: 8),
        Text(
          "Soft Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        // Display soft skills as bullet points
        ...softSkills
            .map((skill) => Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: Text(
                    "• $skill",
                    style: TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        SizedBox(height: 16),

        // Technical Skills Subheading
        Text(
          "Technical Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        // Display technical skills as bullet points
        ...technicalSkills
            .map((skill) => Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: Text(
                    "• $skill",
                    style: TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSkillsSection(Map<String, dynamic> userData) {
    // Extract soft skills and technical skills
    List<dynamic> softSkills = userData["softSkills"] ?? [];
    List<dynamic> technicalSkills = userData["technicalSkills"] ?? [];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Soft Skills Subheading
        pw.SizedBox(height: 8),
        pw.Text(
          "Soft Skills",
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        // Display soft skills as bullet points
        ...softSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: pw.Text(
                    "- $skill",
                    style: pw.TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 16),

        // Technical Skills Subheading
        pw.Text(
          "Technical Skills",
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        // Display technical skills as bullet points
        ...technicalSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: pw.Text(
                    "- $skill",
                    style: pw.TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<String> items) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 8),
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: pw.EdgeInsets.only(bottom: 6.0),
            child: pw.RichText(
              text: pw.TextSpan(
                text: item.split("\n")[0],
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                children: [
                  pw.TextSpan(
                    text: "\n" + item.split("\n").skip(1).join("\n"),
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.normal),
                  )
                ],
              ),
            ),
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      String qualification = edu["Qualification"] ?? "Not Provided";
      String institution = edu["Institution"] ?? "Not Provided";
      String joinDate = _formatDate(edu["Join Date"] ?? "");
      String completionDate =
          _formatDate(edu["Completion Date"] ?? ""); // Format completion date

      return "$qualification\n$institution\n$completionDate - $joinDate";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) => projects
      .map((proj) =>
          "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\nTechnologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}")
      .toList();

  List<String> _formatList(List<dynamic> list) =>
      list.map((item) => item.toString()).toList();

  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(item, style: TextStyle(fontSize: 14)),
                  ))
              .toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      String jobTitle = exp["Job Title"] ?? "Not Provided";
      String company = exp["Company"] ?? "Not Provided";
      String startDate = _formatDate(exp["Start Date"] ?? "");
      String endDate = exp["End Date"] == "Present"
          ? "Present"
          : _formatDate(exp["End Date"] ?? "");
      String description = exp["Description"] ?? "";
      return "$jobTitle    |    $company\n$startDate - $endDate\n\n$description"
          .trim();
    }).toList();
  }
}
*/
/* CORRECT ONE GREEN

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class Template4 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template4({required this.userId});

  @override
  Widget build(BuildContext context) {
    print("User ID Data: $userId");
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Green Template"),
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
          width: 595,
          height: 842,
          child: Row(
            children: [
              Container(
                width: 4, // Left Border
                color: Colors.green[900],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(userId["contactDetails"] ?? {}),
                        _buildSection("Experience",
                            _formatExperience(userId["experience"] ?? [])),
                        _buildSection("Education",
                            _formatEducation(userId["education"] ?? [])),
                        _buildSkillsSection(userId),
                        _buildSection("Projects",
                            _formatProjects(userId["projects"] ?? [])),
                        _buildSection("Awards & Achievements",
                            _formatList(userId["awards"] ?? [])),
                        _buildSection("Certificates",
                            _formatList(userId["certificates"] ?? [])),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 4, // Right Border
                color: Colors.green[900],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();

    // Add a page with flexible layout
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Row(
            children: [
              pw.Container(
                width: 4, // Left Border
                height: double.infinity,
                color: PdfColors.green900,
              ),
              pw.Expanded(
                child: pw.Padding(
                  padding: pw.EdgeInsets.fromLTRB(40, 30, 40, 30),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildPdfHeader(userData["contactDetails"] ?? {}),
                      _buildPdfSection("Experience",
                          _formatExperience(userData["experience"] ?? [])),
                      _buildPdfSection("Education",
                          _formatEducation(userData["education"] ?? [])),
                      _buildPdfSkillsSection(userData),
                      _buildPdfSection("Projects",
                          _formatProjects(userData["projects"] ?? [])),
                      _buildPdfSection("Awards & Achievements",
                          _formatList(userData["awards"] ?? [])),
                      _buildPdfSection("Certificates",
                          _formatList(userData["certificates"] ?? [])),
                    ],
                  ),
                ),
              ),
              pw.Container(
                width: 4, // Right Border
                height: double.infinity,
                color: PdfColors.green900,
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(contactDetails["name"] ?? "No Name",
            style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.green900)),
        pw.SizedBox(height: 5),
        pw.Text(contactDetails["title"] ?? "",
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Text(contactDetails["phone"] ?? ""),
        pw.Text(contactDetails["email"] ?? ""),
        pw.Text(contactDetails["address"] ?? ""),
        pw.Text(contactDetails["website"] ?? ""),
        pw.SizedBox(height: 14),
      ],
    );
  }

  pw.Widget _buildPdfSkillsSection(Map<String, dynamic> userData) {
    // Extract soft skills and technical skills
    List<dynamic> softSkills = userData["softSkills"] ?? [];
    List<dynamic> technicalSkills = userData["technicalSkills"] ?? [];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Soft Skills Subheading
        pw.SizedBox(height: 8),
        pw.Text(
          "Soft Skills",
          style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        // Display soft skills as bullet points
        ...softSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: pw.Text(
                    "- $skill",
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 16),

        // Technical Skills Subheading
        pw.Text(
          "Technical Skills",
          style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        // Display technical skills as bullet points
        ...technicalSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: pw.Text(
                    "- $skill",
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<String> items) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 8),
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: pw.EdgeInsets.only(bottom: 6.0),
            child: pw.RichText(
              text: pw.TextSpan(
                text: item.split("\n")[0],
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                children: [
                  pw.TextSpan(
                    text: "\n" + item.split("\n").skip(1).join("\n"),
                    style: pw.TextStyle(
                        fontSize: 10, fontWeight: pw.FontWeight.normal),
                  )
                ],
              ),
            ),
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
      return DateFormat("MMMM yyyy").format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

  Widget _buildHeader(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} | ${contactDetails["email"] ?? "Not Provided"} | ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Map<String, dynamic> getSectionById(
      List<dynamic> sections, String sectionId) {
    print("Sections: $sections"); // Debugging line
    for (var section in sections) {
      if (section["section_id"] == sectionId) {
        return section;
      }
    }
    return {}; // Return an empty map if the section is not found
  }

  Widget _buildSkillsSection(Map<String, dynamic> userData) {
    // Extract soft skills and technical skills
    List<dynamic> softSkills = userData["softSkills"] ?? [];
    List<dynamic> technicalSkills = userData["technicalSkills"] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Soft Skills Subheading
        SizedBox(height: 8),
        Text(
          "Soft Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        // Display soft skills as bullet points
        ...softSkills
            .map((skill) => Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: Text(
                    "• $skill",
                    style: TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        SizedBox(height: 16),

        // Technical Skills Subheading
        Text(
          "Technical Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        // Display technical skills as bullet points
        ...technicalSkills
            .map((skill) => Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: Text(
                    "• $skill",
                    style: TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      String qualification = edu["Qualification"] ?? "Not Provided";
      String institution = edu["Institution"] ?? "Not Provided";
      String joinDate = _formatDate(edu["Join Date"] ?? "");
      String completionDate =
          _formatDate(edu["Completion Date"] ?? ""); // Format completion date

      return "$qualification\n$institution\n$completionDate - $joinDate";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) => projects
      .map((proj) =>
          "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\nTechnologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}")
      .toList();

  List<String> _formatList(List<dynamic> list) =>
      list.map((item) => item.toString()).toList();

  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(item, style: TextStyle(fontSize: 14)),
                  ))
              .toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      String jobTitle = exp["Job Title"] ?? "Not Provided";
      String company = exp["Company"] ?? "Not Provided";
      String startDate = _formatDate(exp["Start Date"] ?? "");
      String endDate = exp["End Date"] == "Present"
          ? "Present"
          : _formatDate(exp["End Date"] ?? "");
      String description = exp["Description"] ?? "";
      return "$jobTitle    |    $company\n$startDate - $endDate\n\n$description"
          .trim();
    }).toList();
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class Template4 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template4({required this.userId});

  @override
  Widget build(BuildContext context) {
    print("User ID Data: $userId");
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Green Template"),
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
          width: 595,
          height: 842,
          child: Row(
            children: [
              Container(
                width: 4, // Left Border
                color: Colors.green[900],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // Reduced padding
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(userId["contactDetails"] ?? {}),
                        _buildSection("Experience",
                            _formatExperience(userId["experience"] ?? [])),
                        _buildSection("Education",
                            _formatEducation(userId["education"] ?? [])),
                        _buildSkillsSection(userId),
                        _buildSection("Projects",
                            _formatProjects(userId["projects"] ?? [])),
                        _buildSection("Awards & Achievements",
                            _formatList(userId["awards"] ?? [])),
                        _buildSection("Certificates",
                            _formatList(userId["certificates"] ?? [])),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 4, // Right Border
                color: Colors.green[900],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();

    // Add a page with flexible layout
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Row(
            children: [
              pw.Container(
                width: 4, // Left Border
                height: double.infinity,
                color: PdfColors.green900,
              ),
              pw.Expanded(
                child: pw.Padding(
                  padding:
                      pw.EdgeInsets.fromLTRB(20, 10, 20, 10), // Reduced padding
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildPdfHeader(userData["contactDetails"] ?? {}),
                      _buildPdfSection("Experience",
                          _formatExperience(userData["experience"] ?? [])),
                      _buildPdfSection("Education",
                          _formatEducation(userData["education"] ?? [])),
                      _buildPdfSkillsSection(userData),
                      _buildPdfSection("Projects",
                          _formatProjects(userData["projects"] ?? [])),
                      _buildPdfSection("Awards & Achievements",
                          _formatList(userData["awards"] ?? [])),
                      _buildPdfSection("Certificates",
                          _formatList(userData["certificates"] ?? [])),
                    ],
                  ),
                ),
              ),
              pw.Container(
                width: 4, // Right Border
                height: double.infinity,
                color: PdfColors.green900,
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(contactDetails["name"] ?? "No Name",
            style: pw.TextStyle(
                fontSize: 20, // Reduced font size
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.green900)),
        pw.SizedBox(height: 4), // Reduced spacing
        pw.Text(contactDetails["title"] ?? "",
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 6), // Reduced spacing
        pw.Text(contactDetails["phone"] ?? "",
            style: pw.TextStyle(fontSize: 10)),
        pw.Text(contactDetails["email"] ?? "",
            style: pw.TextStyle(fontSize: 10)),
        pw.Text(contactDetails["address"] ?? "",
            style: pw.TextStyle(fontSize: 10)),
        pw.Text(contactDetails["website"] ?? "",
            style: pw.TextStyle(fontSize: 10)),
        pw.SizedBox(height: 8), // Reduced spacing
      ],
    );
  }

  pw.Widget _buildPdfSkillsSection(Map<String, dynamic> userData) {
    // Extract soft skills and technical skills
    List<dynamic> softSkills = userData["softSkills"] ?? [];
    List<dynamic> technicalSkills = userData["technicalSkills"] ?? [];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Soft Skills Subheading
        pw.SizedBox(height: 6), // Reduced spacing
        pw.Text(
          "Soft Skills",
          style: pw.TextStyle(
              fontSize: 12, // Reduced font size
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 4), // Reduced spacing
        // Display soft skills as bullet points
        ...softSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(
                      left: 8.0, bottom: 2.0), // Reduced padding
                  child: pw.Text(
                    "- $skill",
                    style: pw.TextStyle(fontSize: 10), // Reduced font size
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 8), // Reduced spacing

        // Technical Skills Subheading
        pw.Text(
          "Technical Skills",
          style: pw.TextStyle(
              fontSize: 12, // Reduced font size
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 4), // Reduced spacing
        // Display technical skills as bullet points
        ...technicalSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(
                      left: 8.0, bottom: 2.0), // Reduced padding
                  child: pw.Text(
                    "- $skill",
                    style: pw.TextStyle(fontSize: 10), // Reduced font size
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 8), // Reduced spacing
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<String> items) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 6), // Reduced spacing
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 12, // Reduced font size
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 4), // Reduced spacing
        for (var item in items)
          pw.Padding(
            padding: pw.EdgeInsets.only(bottom: 4.0), // Reduced padding
            child: pw.RichText(
              text: pw.TextSpan(
                text: item.split("\n")[0],
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                children: [
                  pw.TextSpan(
                    text: "\n" + item.split("\n").skip(1).join("\n"),
                    style: pw.TextStyle(
                        fontSize: 10, fontWeight: pw.FontWeight.normal),
                  )
                ],
              ),
            ),
          ),
        pw.SizedBox(height: 8), // Reduced spacing
      ],
    );
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
      return DateFormat("MMMM yyyy").format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

  Widget _buildHeader(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 4), // Reduced spacing
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} | ${contactDetails["email"] ?? "Not Provided"} | ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 8), // Reduced spacing
      ],
    );
  }

  Widget _buildSkillsSection(Map<String, dynamic> userData) {
    // Extract soft skills and technical skills
    List<dynamic> softSkills = userData["softSkills"] ?? [];
    List<dynamic> technicalSkills = userData["technicalSkills"] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Soft Skills Subheading
        SizedBox(height: 6), // Reduced spacing
        Text(
          "Soft Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 4), // Reduced spacing
        // Display soft skills as bullet points
        ...softSkills
            .map((skill) => Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, bottom: 2.0), // Reduced padding
                  child: Text(
                    "• $skill",
                    style: TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        SizedBox(height: 8), // Reduced spacing

        // Technical Skills Subheading
        Text(
          "Technical Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 4), // Reduced spacing
        // Display technical skills as bullet points
        ...technicalSkills
            .map((skill) => Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, bottom: 2.0), // Reduced padding
                  child: Text(
                    "• $skill",
                    style: TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        SizedBox(height: 8), // Reduced spacing
      ],
    );
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      String qualification = edu["Qualification"] ?? "Not Provided";
      String institution = edu["Institution"] ?? "Not Provided";
      String joinDate = _formatDate(edu["Join Date"] ?? "");
      String completionDate = _formatDate(edu["Completion Date"] ?? "");

      return "$qualification\n$institution\n$completionDate - $joinDate";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) => projects
      .map((proj) =>
          "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\nTechnologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}")
      .toList();

  List<String> _formatList(List<dynamic> list) =>
      list.map((item) => item.toString()).toList();

  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6), // Reduced spacing
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 4), // Reduced spacing
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: 4.0), // Reduced padding
                    child: Text(item, style: TextStyle(fontSize: 14)),
                  ))
              .toList(),
        ),
        SizedBox(height: 8), // Reduced spacing
      ],
    );
  }

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      String jobTitle = exp["Job Title"] ?? "Not Provided";
      String company = exp["Company"] ?? "Not Provided";
      String startDate = _formatDate(exp["Start Date"] ?? "");
      String endDate = exp["End Date"] == "Present"
          ? "Present"
          : _formatDate(exp["End Date"] ?? "");
      String description = exp["Description"] ?? "";
      return "$jobTitle    |    $company\n$startDate - $endDate\n\n$description"
          .trim();
    }).toList();
  }
}
*/

/*correct one

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Template4 extends StatefulWidget {
  final Map<String, dynamic> userId;

  Template4({required this.userId});

  @override
  _Template4State createState() => _Template4State();
}

class _Template4State extends State<Template4> {
  String _summary = ''; // To store the fetched summary
  bool _isLoading = true; // To show loading state

  @override
  void initState() {
    super.initState();
    _fetchSummary(); // Fetch summary when the widget is initialized
  }

  // Fetch summary from Firestore
  Future<void> _fetchSummary() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('users').doc(user.uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        _summary = data['selected_summary'] ?? 'No summary available';
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("User ID Data: ${widget.userId}");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userId["templateName"] ?? "Green Template"),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = await _generatePdf(widget.userId);
              await Printing.layoutPdf(
                onLayout: (format) => pdf.save(),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                width: 595,
                height: 842,
                child: Row(
                  children: [
                    Container(
                      width: 4, // Left Border
                      color: Color(0xFF2C7A7B),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(
                                  widget.userId["contactDetails"] ?? {}),
                              if (_summary.isNotEmpty)
                                _buildSection("Summary", [_summary]),
                              _buildSection(
                                  "Experience",
                                  _formatExperience(
                                      widget.userId["experience"] ?? [])),
                              _buildSection(
                                  "Education",
                                  _formatEducation(
                                      widget.userId["education"] ?? [])),
                              _buildSkillsSection(widget.userId),
                              _buildSection(
                                  "Projects",
                                  _formatProjects(
                                      widget.userId["projects"] ?? [])),
                              _buildSection("Awards & Achievements",
                                  _formatList(widget.userId["awards"] ?? [])),
                              _buildSection(
                                  "Certificates",
                                  _formatList(
                                      widget.userId["certificates"] ?? [])),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 4, // Right Border
                      color: Color(0xFF2C7A7B),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();

    // Add a page with flexible layout
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Row(
            children: [
              pw.Container(
                width: 4, // Left Border
                height: double.infinity,
                color: PdfColor.fromInt(0xFF2C7A7B),
              ),
              pw.Expanded(
                child: pw.Padding(
                  padding: pw.EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildPdfHeader(userData["contactDetails"] ?? {}),
                      if (_summary.isNotEmpty)
                        _buildPdfSection("Summary", [_summary]),
                      _buildPdfSection("Experience",
                          _formatExperience(userData["experience"] ?? [])),
                      _buildPdfSection("Education",
                          _formatEducation(userData["education"] ?? [])),
                      _buildPdfSkillsSection(userData),
                      _buildPdfSection("Projects",
                          _formatProjects(userData["projects"] ?? [])),
                      _buildPdfSection("Awards & Achievements",
                          _formatList(userData["awards"] ?? [])),
                      _buildPdfSection("Certificates",
                          _formatList(userData["certificates"] ?? [])),
                    ],
                  ),
                ),
              ),
              pw.Container(
                width: 4, // Right Border
                height: double.infinity,
                color: PdfColor.fromInt(0xFF2C7A7B),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(contactDetails["name"] ?? "No Name",
            style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromInt(0xFF2C7A7B))),
        pw.SizedBox(height: 4),
        pw.Text(contactDetails["title"] ?? "",
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 6),
        pw.Text(contactDetails["phone"] ?? "",
            style: pw.TextStyle(fontSize: 10)),
        pw.Text(contactDetails["email"] ?? "",
            style: pw.TextStyle(fontSize: 10)),
        pw.Text(contactDetails["address"] ?? "",
            style: pw.TextStyle(fontSize: 10)),
        pw.Text(contactDetails["website"] ?? "",
            style: pw.TextStyle(fontSize: 10)),
        pw.SizedBox(height: 8),
      ],
    );
  }

  pw.Widget _buildPdfSkillsSection(Map<String, dynamic> userData) {
    List<dynamic> softSkills = userData["softSkills"] ?? [];
    List<dynamic> technicalSkills = userData["technicalSkills"] ?? [];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 6),
        pw.Text(
          "Soft Skills",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        ...softSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(left: 8.0, bottom: 2.0),
                  child: pw.Text(
                    "- $skill",
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 8),
        pw.Text(
          "Technical Skills",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        ...technicalSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(left: 8.0, bottom: 2.0),
                  child: pw.Text(
                    "- $skill",
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 8),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<String> items) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 6),
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        for (var item in items)
          pw.Padding(
            padding: pw.EdgeInsets.only(bottom: 4.0),
            child: pw.RichText(
              text: pw.TextSpan(
                text: item.split("\n")[0],
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                children: [
                  pw.TextSpan(
                    text: "\n" + item.split("\n").skip(1).join("\n"),
                    style: pw.TextStyle(
                        fontSize: 10, fontWeight: pw.FontWeight.normal),
                  )
                ],
              ),
            ),
          ),
        pw.SizedBox(height: 8),
      ],
    );
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
      return DateFormat("MMMM yyyy").format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

  Widget _buildHeader(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} | ${contactDetails["email"] ?? "Not Provided"} | ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSkillsSection(Map<String, dynamic> userData) {
    List<dynamic> softSkills = userData["softSkills"] ?? [];
    List<dynamic> technicalSkills = userData["technicalSkills"] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Text(
          "Soft Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        ...softSkills
            .map((skill) => Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
                  child: Text(
                    "• $skill",
                    style: TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        SizedBox(height: 8),
        Text(
          "Technical Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        ...technicalSkills
            .map((skill) => Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
                  child: Text(
                    "• $skill",
                    style: TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        SizedBox(height: 8),
      ],
    );
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      String qualification = edu["Qualification"] ?? "Not Provided";
      String institution = edu["Institution"] ?? "Not Provided";
      String joinDate = _formatDate(edu["Join Date"] ?? "");
      String completionDate = _formatDate(edu["Completion Date"] ?? "");

      return "$qualification\n$institution\n$completionDate - $joinDate";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) => projects
      .map((proj) =>
          "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\nTechnologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}")
      .toList();

  List<String> _formatList(List<dynamic> list) =>
      list.map((item) => item.toString()).toList();

  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(item, style: TextStyle(fontSize: 14)),
                  ))
              .toList(),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      String jobTitle = exp["Job Title"] ?? "Not Provided";
      String company = exp["Company"] ?? "Not Provided";
      String startDate = _formatDate(exp["Start Date"] ?? "");
      String endDate = exp["End Date"] == "Present"
          ? "Present"
          : _formatDate(exp["End Date"] ?? "");
      String description = exp["Description"] ?? "";
      return "$jobTitle    |    $company\n$startDate - $endDate\n\n$description"
          .trim();
    }).toList();
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Template4 extends StatefulWidget {
  final String templateName;
  final Map<String, dynamic> userId;
  final bool includeAISuggestions;

  const Template4({
    Key? key,
    required this.templateName,
    required this.userId,
    this.includeAISuggestions = false,
  }) : super(key: key);

  @override
  _Template4State createState() => _Template4State();
}

class _Template4State extends State<Template4> {
  String _summary = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSummary();
  }

  Future<void> _fetchSummary() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('users').doc(user.uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        _summary = data['selected_summary'] ?? 'No summary available';
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getContent(dynamic item) {
    if (item is String) return item;

    final Map<String, dynamic> contentItem = (item is Map
        ? Map<String, dynamic>.from(item)
        : {'content': item.toString()});

    if (contentItem['is_ai_generated'] == true) {
      return widget.includeAISuggestions
          ? contentItem['content']?.toString() ?? ''
          : '';
    }
    return widget.includeAISuggestions
        ? ''
        : contentItem['content']?.toString() ?? '';
  }

  List<dynamic> _filterSectionItems(List<dynamic> items,
      {bool isExperience = false, bool isProjects = false}) {
    if (items == null) return [];
    if (isProjects) return items;

    if (isExperience) return items;

    return items.where((item) {
      if (item is Map) {
        return widget.includeAISuggestions
            ? item['is_ai_generated'] == true
            : item['is_ai_generated'] != true;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.templateName),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = await _generatePdf();
              await Printing.layoutPdf(
                onLayout: (format) => pdf.save(),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                width: 595,
                height: 842,
                child: Row(
                  children: [
                    Container(
                      width: 4, // Left Border
                      color: Color(0xFF2C7A7B),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(
                                  widget.userId["contactDetails"] ?? {}),
                              if (_summary.isNotEmpty)
                                _buildSection("Summary", [_summary]),
                              _buildExperienceSection(
                                  widget.userId["experience"] ?? []),
                              _buildEducationSection(
                                  widget.userId["education"] ?? []),
                              _buildSkillsSection(widget.userId),
                              _buildProjectsSection(
                                  widget.userId["projects"] ?? []),
                              _buildSection("Awards & Achievements",
                                  widget.userId["awards"] ?? []),
                              _buildSection("Certificates",
                                  widget.userId["certificates"] ?? []),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 4, // Right Border
                      color: Color(0xFF2C7A7B),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} | ${contactDetails["email"] ?? "Not Provided"} | ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSkillsSection(Map<String, dynamic> userData) {
    final softSkills = _filterSectionItems(userData["softSkills"] ?? []);
    final technicalSkills =
        _filterSectionItems(userData["technicalSkills"] ?? []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Text(
          "Soft Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        ...softSkills
            .map((skill) => Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
                  child: Text(
                    "• ${_getContent(skill)}",
                    style: TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        SizedBox(height: 8),
        Text(
          "Technical Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        ...technicalSkills
            .map((skill) => Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
                  child: Text(
                    "• ${_getContent(skill)}",
                    style: TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSection(String title, List<dynamic> items) {
    final filteredItems = _filterSectionItems(items);
    if (filteredItems.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: filteredItems
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      _getContent(item),
                      style: TextStyle(fontSize: 14),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildExperienceSection(List<dynamic> experiences) {
    final filteredExperiences =
        _filterSectionItems(experiences, isExperience: true);
    if (filteredExperiences.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Text(
          "Experience",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        for (var exp in filteredExperiences)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (exp['is_ai_generated'] == true &&
                    widget.includeAISuggestions)
                  Text(
                    _getContent(exp),
                    style: TextStyle(fontSize: 14),
                  )
                else ...[
                  Text(
                    "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${_formatDate(exp['Start Date'] ?? "")} - ${exp['End Date'] == "Present" ? "Present" : _formatDate(exp['End Date'] ?? "")}",
                    style: TextStyle(fontSize: 14),
                  ),
                  if (exp['Description'] != null)
                    for (var desc
                        in (exp['Description'] as List<dynamic>? ?? []))
                      Text(
                        "• ${_getContent(desc)}",
                        style: TextStyle(fontSize: 14),
                      ),
                ],
              ],
            ),
          ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildEducationSection(List<dynamic> educationList) {
    final filteredEducation = _filterSectionItems(educationList);
    if (filteredEducation.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Text(
          "Education",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        for (var edu in filteredEducation)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (edu['is_ai_generated'] == true &&
                    widget.includeAISuggestions)
                  Text(
                    _getContent(edu),
                    style: TextStyle(fontSize: 14),
                  )
                else ...[
                  Text(
                    "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${_formatDate(edu['Completion Date'] ?? "")}",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ],
            ),
          ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildProjectsSection(List<dynamic> projects) {
    final filteredProjects = _filterSectionItems(projects, isProjects: true);
    if (filteredProjects.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Text(
          "Projects",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        for (var proj in filteredProjects)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${proj['title'] ?? "Not Provided"} | ${proj['role'] ?? "Not Provided"}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}",
                  style: TextStyle(fontSize: 14),
                ),
                if (_getContent(proj).isNotEmpty)
                  Text(
                    _getContent(proj),
                    style: TextStyle(fontSize: 14),
                  ),
              ],
            ),
          ),
        SizedBox(height: 8),
      ],
    );
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
      return DateFormat("MMMM yyyy").format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

  Future<pw.Document> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Row(
            children: [
              pw.Container(
                width: 4, // Left Border
                height: double.infinity,
                color: PdfColor.fromInt(0xFF2C7A7B),
              ),
              pw.Expanded(
                child: pw.Padding(
                  padding: pw.EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildPdfHeader(widget.userId["contactDetails"] ?? {}),
                      if (_summary.isNotEmpty)
                        _buildPdfSection("Summary", [_summary]),
                      _buildPdfExperienceSection(
                          widget.userId["experience"] ?? []),
                      _buildPdfEducationSection(
                          widget.userId["education"] ?? []),
                      _buildPdfSkillsSection(widget.userId),
                      _buildPdfProjectsSection(widget.userId["projects"] ?? []),
                      _buildPdfSection("Awards & Achievements",
                          widget.userId["awards"] ?? []),
                      _buildPdfSection(
                          "Certificates", widget.userId["certificates"] ?? []),
                    ],
                  ),
                ),
              ),
              pw.Container(
                width: 4, // Right Border
                height: double.infinity,
                color: PdfColor.fromInt(0xFF2C7A7B),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(contactDetails["name"] ?? "No Name",
            style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromInt(0xFF2C7A7B))),
        pw.SizedBox(height: 4),
        pw.Text(
            "${contactDetails["phone"] ?? ""} | ${contactDetails["email"] ?? ""} | ${contactDetails["address"] ?? ""}",
            style: pw.TextStyle(fontSize: 10)),
        pw.SizedBox(height: 8),
      ],
    );
  }

  pw.Widget _buildPdfSkillsSection(Map<String, dynamic> userData) {
    final softSkills = _filterSectionItems(userData["softSkills"] ?? []);
    final technicalSkills =
        _filterSectionItems(userData["technicalSkills"] ?? []);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 6),
        pw.Text(
          "Soft Skills",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        ...softSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(left: 8.0, bottom: 2.0),
                  child: pw.Text(
                    "- ${_getContent(skill)}",
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 8),
        pw.Text(
          "Technical Skills",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        ...technicalSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(left: 8.0, bottom: 2.0),
                  child: pw.Text(
                    "- ${_getContent(skill)}",
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 8),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<dynamic> items) {
    final filteredItems = _filterSectionItems(items);
    if (filteredItems.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 6),
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        for (var item in filteredItems)
          pw.Padding(
            padding: pw.EdgeInsets.only(bottom: 4.0),
            child: pw.Text(
              _getContent(item),
              style: pw.TextStyle(fontSize: 10),
            ),
          ),
        pw.SizedBox(height: 8),
      ],
    );
  }

  pw.Widget _buildPdfExperienceSection(List<dynamic> experiences) {
    final filteredExperiences =
        _filterSectionItems(experiences, isExperience: true);
    if (filteredExperiences.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 6),
        pw.Text(
          "Experience",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        for (var exp in filteredExperiences)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (exp['is_ai_generated'] == true && widget.includeAISuggestions)
                pw.Text(
                  _getContent(exp),
                  style: pw.TextStyle(fontSize: 10),
                )
              else ...[
                pw.Text(
                  "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}",
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  "${_formatDate(exp['Start Date'] ?? "")} - ${exp['End Date'] == "Present" ? "Present" : _formatDate(exp['End Date'] ?? "")}",
                  style: pw.TextStyle(fontSize: 10),
                ),
                if (exp['Description'] != null)
                  for (var desc in (exp['Description'] as List<dynamic>? ?? []))
                    pw.Text(
                      "- ${_getContent(desc)}",
                      style: pw.TextStyle(fontSize: 10),
                    ),
              ],
              pw.SizedBox(height: 8),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildPdfEducationSection(List<dynamic> educationList) {
    final filteredEducation = _filterSectionItems(educationList);
    if (filteredEducation.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 6),
        pw.Text(
          "Education",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        for (var edu in filteredEducation)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (edu['is_ai_generated'] == true && widget.includeAISuggestions)
                pw.Text(
                  _getContent(edu),
                  style: pw.TextStyle(fontSize: 10),
                )
              else ...[
                pw.Text(
                  "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}",
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  "${_formatDate(edu['Completion Date'] ?? "")}",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ],
              pw.SizedBox(height: 8),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildPdfProjectsSection(List<dynamic> projects) {
    final filteredProjects = _filterSectionItems(projects, isProjects: true);
    if (filteredProjects.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 6),
        pw.Text(
          "Projects",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        for (var proj in filteredProjects)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "${proj['title'] ?? "Not Provided"} | ${proj['role'] ?? "Not Provided"}",
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                "Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}",
                style: pw.TextStyle(fontSize: 10),
              ),
              if (_getContent(proj).isNotEmpty)
                pw.Text(
                  _getContent(proj),
                  style: pw.TextStyle(fontSize: 10),
                ),
              pw.SizedBox(height: 8),
            ],
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
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Template4 extends StatefulWidget {
  final String templateName;
  final Map<String, dynamic> userId;
  final bool includeAISuggestions;

  const Template4({
    Key? key,
    required this.templateName,
    required this.userId,
    this.includeAISuggestions = false,
  }) : super(key: key);

  @override
  _Template4State createState() => _Template4State();
}

class _Template4State extends State<Template4> {
  String _summary = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSummary();
  }

  Future<void> _fetchSummary() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('users').doc(user.uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        _summary = data['selected_summary'] ?? 'No summary available';
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getContent(dynamic item) {
    if (item is String) return item;

    final Map<String, dynamic> contentItem = (item is Map
        ? Map<String, dynamic>.from(item)
        : {'content': item.toString()});

    if (contentItem['is_ai_generated'] == true) {
      return widget.includeAISuggestions
          ? contentItem['content']?.toString() ?? ''
          : '';
    }
    return contentItem['content']?.toString() ?? '';
  }

  List<dynamic> _filterSectionItems(List<dynamic> items) {
    if (items == null) return [];

    return items.where((item) {
      if (item is Map) {
        return widget.includeAISuggestions
            ? item['is_ai_generated'] == true
            : item['is_ai_generated'] != true;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.templateName),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = await _generatePdf();
              await Printing.layoutPdf(
                onLayout: (format) => pdf.save(),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                width: 595,
                height: 842,
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      color: Color(0xFF2C7A7B),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeaderSection(),
                              _buildSummarySection(),
                              _buildExperienceSection(),
                              _buildEducationSection(),
                              _buildSkillsSection(),
                              _buildProjectsSection(),
                              _buildCertificatesSection(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 4,
                      color: Color(0xFF2C7A7B),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildHeaderSection() {
    final contact = widget.userId["contactDetails"] ?? {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contact["name"] ?? 'No Name',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        Text(
          "${contact["phone"] ?? 'Not Provided'} | ${contact["email"] ?? 'Not Provided'} | ${contact["address"] ?? 'Not Provided'}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSummarySection() {
    if (_summary.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SUMMARY",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        Text(
          _summary,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildExperienceSection() {
    final experiences = _filterSectionItems(widget.userId["experience"] ?? []);

    if (experiences.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "EXPERIENCE",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        for (var exp in experiences)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (exp['is_ai_generated'] == true &&
                    widget.includeAISuggestions)
                  Text(
                    _getContent(exp),
                    style: TextStyle(fontSize: 14),
                  )
                else if (exp['Job Title'] != null || exp['Company'] != null)
                  Text(
                    "${exp['Job Title'] ?? ''} | ${exp['Company'] ?? ''}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                if (exp['Start Date'] != null &&
                    exp['End Date'] != null &&
                    (exp['is_ai_generated'] != true ||
                        !widget.includeAISuggestions))
                  Text(
                    "${exp['Start Date']} - ${exp['End Date']}",
                    style: TextStyle(fontSize: 14),
                  ),
                if (_getContent(exp).isNotEmpty &&
                    !(exp['is_ai_generated'] == true &&
                        widget.includeAISuggestions))
                  Text(
                    _getContent(exp),
                    style: TextStyle(fontSize: 14),
                  ),
                SizedBox(height: 8),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildEducationSection() {
    final educationList = _filterSectionItems(widget.userId["education"] ?? []);

    if (educationList.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "EDUCATION",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        for (var edu in educationList)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (edu['is_ai_generated'] == true &&
                    widget.includeAISuggestions)
                  Text(
                    _getContent(edu),
                    style: TextStyle(fontSize: 14),
                  )
                else if (edu['Qualification'] != null ||
                    edu['Institution'] != null)
                  Text(
                    "${edu['Qualification'] ?? ''} | ${edu['Institution'] ?? ''}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                if (edu['Completion Date'] != null &&
                    (edu['is_ai_generated'] != true ||
                        !widget.includeAISuggestions))
                  Text(
                    "${edu['Completion Date']}",
                    style: TextStyle(fontSize: 14),
                  ),
                if (_getContent(edu).isNotEmpty &&
                    !(edu['is_ai_generated'] == true &&
                        widget.includeAISuggestions))
                  Text(
                    _getContent(edu),
                    style: TextStyle(fontSize: 14),
                  ),
                SizedBox(height: 8),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSkillsSection() {
    final techSkills =
        _filterSectionItems(widget.userId["technicalSkills"] ?? []);
    final softSkills = _filterSectionItems(widget.userId["softSkills"] ?? []);

    if (techSkills.isEmpty && softSkills.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SKILLS",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        if (techSkills.isNotEmpty) ...[
          Text(
            "Technical Skills:",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          ...techSkills.map((skill) => Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
                child: Text(
                  "• ${_getContent(skill)}",
                  style: TextStyle(fontSize: 14),
                ),
              )),
          SizedBox(height: 8),
        ],
        if (softSkills.isNotEmpty) ...[
          Text(
            "Soft Skills:",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          ...softSkills.map((skill) => Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
                child: Text(
                  "• ${_getContent(skill)}",
                  style: TextStyle(fontSize: 14),
                ),
              )),
          SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget _buildProjectsSection() {
    final projects = _filterSectionItems(widget.userId["projects"] ?? []);

    if (projects.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PROJECTS",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        for (var proj in projects)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (proj['is_ai_generated'] == true &&
                    widget.includeAISuggestions)
                  Text(
                    _getContent(proj),
                    style: TextStyle(fontSize: 14),
                  )
                else if (proj['title'] != null || proj['role'] != null)
                  Text(
                    "${proj['title'] ?? ''} | ${proj['role'] ?? ''}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                if (proj['technologies'] != null &&
                    (proj['is_ai_generated'] != true ||
                        !widget.includeAISuggestions))
                  Text(
                    "Technologies: ${proj['technologies']?.join(", ") ?? 'Not Provided'}",
                    style: TextStyle(fontSize: 14),
                  ),
                if (_getContent(proj).isNotEmpty &&
                    !(proj['is_ai_generated'] == true &&
                        widget.includeAISuggestions))
                  Text(
                    _getContent(proj),
                    style: TextStyle(fontSize: 14),
                  ),
                SizedBox(height: 8),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCertificatesSection() {
    final awards = _filterSectionItems(widget.userId["awards"] ?? []);
    final certificates =
        _filterSectionItems(widget.userId["certificates"] ?? []);

    if (awards.isEmpty && certificates.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "AWARDS & CERTIFICATES",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C7A7B)),
        ),
        SizedBox(height: 4),
        for (var award in awards)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              _getContent(award),
              style: TextStyle(fontSize: 14),
            ),
          ),
        for (var cert in certificates)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              _getContent(cert),
              style: TextStyle(fontSize: 14),
            ),
          ),
        SizedBox(height: 8),
      ],
    );
  }

  Future<pw.Document> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Row(
            children: [
              pw.Container(
                width: 4,
                height: double.infinity,
                color: PdfColor.fromInt(0xFF2C7A7B),
              ),
              pw.Expanded(
                child: pw.Padding(
                  padding: pw.EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildPdfHeaderSection(),
                      _buildPdfSummarySection(),
                      _buildPdfExperienceSection(),
                      _buildPdfEducationSection(),
                      _buildPdfSkillsSection(),
                      _buildPdfProjectsSection(),
                      _buildPdfCertificatesSection(),
                    ],
                  ),
                ),
              ),
              pw.Container(
                width: 4,
                height: double.infinity,
                color: PdfColor.fromInt(0xFF2C7A7B),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfHeaderSection() {
    final contact = widget.userId["contactDetails"] ?? {};
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(contact["name"] ?? "No Name",
            style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromInt(0xFF2C7A7B))),
        pw.SizedBox(height: 4),
        pw.Text(contact["title"] ?? "",
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 6),
        pw.Text(contact["phone"] ?? "", style: pw.TextStyle(fontSize: 10)),
        pw.Text(contact["email"] ?? "", style: pw.TextStyle(fontSize: 10)),
        pw.Text(contact["address"] ?? "", style: pw.TextStyle(fontSize: 10)),
        pw.Text(contact["website"] ?? "", style: pw.TextStyle(fontSize: 10)),
        pw.SizedBox(height: 8),
      ],
    );
  }

  pw.Widget _buildPdfSummarySection() {
    if (_summary.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "SUMMARY",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          _summary,
          style: const pw.TextStyle(fontSize: 10),
        ),
        pw.SizedBox(height: 8),
      ],
    );
  }

  pw.Widget _buildPdfExperienceSection() {
    final experiences = _filterSectionItems(widget.userId["experience"] ?? []);

    if (experiences.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "EXPERIENCE",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        for (var exp in experiences)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (exp['is_ai_generated'] == true && widget.includeAISuggestions)
                pw.Text(
                  _getContent(exp),
                  style: const pw.TextStyle(fontSize: 10),
                )
              else if (exp['Job Title'] != null || exp['Company'] != null)
                pw.Text(
                  "${exp['Job Title'] ?? ''} | ${exp['Company'] ?? ''}",
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold),
                ),
              if (exp['Start Date'] != null &&
                  exp['End Date'] != null &&
                  (exp['is_ai_generated'] != true ||
                      !widget.includeAISuggestions))
                pw.Text(
                  "${exp['Start Date']} - ${exp['End Date']}",
                  style: const pw.TextStyle(fontSize: 10),
                ),
              if (_getContent(exp).isNotEmpty &&
                  !(exp['is_ai_generated'] == true &&
                      widget.includeAISuggestions))
                pw.Text(
                  _getContent(exp),
                  style: const pw.TextStyle(fontSize: 10),
                ),
              pw.SizedBox(height: 8),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildPdfEducationSection() {
    final educationList = _filterSectionItems(widget.userId["education"] ?? []);

    if (educationList.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "EDUCATION",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        for (var edu in educationList)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (edu['is_ai_generated'] == true && widget.includeAISuggestions)
                pw.Text(
                  _getContent(edu),
                  style: const pw.TextStyle(fontSize: 10),
                )
              else if (edu['Qualification'] != null ||
                  edu['Institution'] != null)
                pw.Text(
                  "${edu['Qualification'] ?? ''} | ${edu['Institution'] ?? ''}",
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold),
                ),
              if (edu['Completion Date'] != null &&
                  (edu['is_ai_generated'] != true ||
                      !widget.includeAISuggestions))
                pw.Text(
                  "${edu['Completion Date']}",
                  style: const pw.TextStyle(fontSize: 10),
                ),
              if (_getContent(edu).isNotEmpty &&
                  !(edu['is_ai_generated'] == true &&
                      widget.includeAISuggestions))
                pw.Text(
                  _getContent(edu),
                  style: const pw.TextStyle(fontSize: 10),
                ),
              pw.SizedBox(height: 8),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildPdfSkillsSection() {
    final techSkills =
        _filterSectionItems(widget.userId["technicalSkills"] ?? []);
    final softSkills = _filterSectionItems(widget.userId["softSkills"] ?? []);

    if (techSkills.isEmpty && softSkills.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "SKILLS",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        if (techSkills.isNotEmpty) ...[
          pw.Text(
            "Technical Skills:",
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          ...techSkills.map((skill) => pw.Padding(
                padding: const pw.EdgeInsets.only(left: 8.0, bottom: 2.0),
                child: pw.Text(
                  "- ${_getContent(skill)}",
                  style: const pw.TextStyle(fontSize: 10),
                ),
              )),
          pw.SizedBox(height: 8),
        ],
        if (softSkills.isNotEmpty) ...[
          pw.Text(
            "Soft Skills:",
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          ...softSkills.map((skill) => pw.Padding(
                padding: const pw.EdgeInsets.only(left: 8.0, bottom: 2.0),
                child: pw.Text(
                  "- ${_getContent(skill)}",
                  style: const pw.TextStyle(fontSize: 10),
                ),
              )),
          pw.SizedBox(height: 8),
        ],
      ],
    );
  }

  pw.Widget _buildPdfProjectsSection() {
    final projects = _filterSectionItems(widget.userId["projects"] ?? []);

    if (projects.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "PROJECTS",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        for (var proj in projects)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (proj['is_ai_generated'] == true &&
                  widget.includeAISuggestions)
                pw.Text(
                  _getContent(proj),
                  style: const pw.TextStyle(fontSize: 10),
                )
              else if (proj['title'] != null || proj['role'] != null)
                pw.Text(
                  "${proj['title'] ?? ''} | ${proj['role'] ?? ''}",
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold),
                ),
              if (proj['technologies'] != null &&
                  (proj['is_ai_generated'] != true ||
                      !widget.includeAISuggestions))
                pw.Text(
                  "Technologies: ${proj['technologies']?.join(", ") ?? 'Not Provided'}",
                  style: const pw.TextStyle(fontSize: 10),
                ),
              if (_getContent(proj).isNotEmpty &&
                  !(proj['is_ai_generated'] == true &&
                      widget.includeAISuggestions))
                pw.Text(
                  _getContent(proj),
                  style: const pw.TextStyle(fontSize: 10),
                ),
              pw.SizedBox(height: 8),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildPdfCertificatesSection() {
    final awards = _filterSectionItems(widget.userId["awards"] ?? []);
    final certificates =
        _filterSectionItems(widget.userId["certificates"] ?? []);

    if (awards.isEmpty && certificates.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "AWARDS & CERTIFICATES",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromInt(0xFF2C7A7B)),
        ),
        pw.SizedBox(height: 4),
        for (var award in awards)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              _getContent(award),
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
        for (var cert in certificates)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              _getContent(cert),
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
        pw.SizedBox(height: 8),
      ],
    );
  }
}
