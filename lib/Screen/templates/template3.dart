/*import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class Template3 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template3({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Red Template"),
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
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(120),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 595,
              height: 842,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.redAccent, width: 5),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(userId["contactDetails"] ?? {}),
                    _buildExperienceSection(userId["experience"] ?? []),
                    _buildSkillsSection(userId["skills"] ?? {}),
                    _buildSection(
                        "PROJECTS", _formatProjects(userId["projects"] ?? [])),
                    _buildSection("EDUCATION",
                        _formatEducation(userId["education"] ?? [])),
                    _buildSection("AWARDS & ACHIEVEMENTS",
                        _formatList(userId["awards"] ?? [])),
                    _buildSection("CERTIFICATIONS",
                        _formatList(userId["certifications"] ?? [])),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(Map<String, dynamic> skills) {
    List<String> technicalSkills = _formatList(skills["technical"] ?? []);
    List<String> softSkills = _formatList(skills["soft"] ?? []);
    if (technicalSkills.isEmpty && softSkills.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        Text(
          "KEY SKILLS",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 8),
        if (technicalSkills.isNotEmpty)
          _buildSection("Technical Skills", technicalSkills, isBulleted: true),
        if (softSkills.isNotEmpty)
          _buildSection("Soft Skills", softSkills, isBulleted: true),
        SizedBox(height: 16),
      ],
    );
  }

  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.redAccent, width: 5),
            ),
            padding: pw.EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildPdfHeader(userData["contactDetails"] ?? {}),
                _buildPdfExperienceSection(userData["experience"] ?? []),
                _buildPdfSkillsSection(userData["skills"] ?? {}),
                _buildPdfSection(
                    "PROJECTS", _formatProjects(userData["projects"] ?? [])),
                _buildPdfSection(
                    "EDUCATION", _formatEducation(userData["education"] ?? [])),
                _buildPdfSection("AWARDS & ACHIEVEMENTS",
                    _formatList(userData["awards"] ?? [])),
                _buildPdfSection("CERTIFICATIONS",
                    _formatList(userData["certifications"] ?? [])),
              ],
            ),
          );
        },
      ),
    );
    return pdf;
  }

  pw.Widget _buildPdfSkillsSection(Map<String, dynamic> skills) {
    List<String> technicalSkills = _formatList(skills["technical"] ?? []);
    List<String> softSkills = _formatList(skills["soft"] ?? []);
    if (technicalSkills.isEmpty && softSkills.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 8),
        pw.Text(
          "KEY SKILLS",
          style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 8),
        if (technicalSkills.isNotEmpty)
          _buildPdfSection("Technical Skills", technicalSkills,
              isBulleted: true),
        if (softSkills.isNotEmpty)
          _buildPdfSection("Soft Skills", softSkills, isBulleted: true),
        pw.SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatList(List<dynamic> list) {
    return list.map((item) => item.toString().trim()).toList();
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
              color: Colors.redAccent),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} . ${contactDetails["email"] ?? "Not Provided"} . ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSection(String title, List<String> items,
      {bool isBulleted = false}) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 8),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isBulleted)
                  Text(". ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<String> items,
      {bool isBulleted = false}) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 8),
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (isBulleted)
                  pw.Text(". ",
                      style: pw.TextStyle(
                          fontSize: 11, fontWeight: pw.FontWeight.bold)),
                pw.Expanded(
                  child: pw.Text(
                    item,
                    style: pw.TextStyle(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  Widget _buildExperienceSection(List<dynamic> experience) {
    if (experience.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        Text(
          "PROFESSIONAL EXPERIENCE",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 8),
        for (var exp in experience)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 11, color: Colors.black),
                      children: [
                        TextSpan(
                            text: exp["Job Title"] ?? "Not Provided",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " | ${exp["Company"] ?? "Not Provided"}"),
                      ],
                    ),
                  ),
                ),
                Text(
                  "${_formatDate(exp["Start Date"] ?? "")} - ${_formatDate(exp["End Date"] ?? "Present")}",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfExperienceSection(List<dynamic> experience) {
    if (experience.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 8),
        pw.Text(
          "PROFESSIONAL EXPERIENCE",
          style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 8),
        for (var exp in experience)
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.RichText(
                  text: pw.TextSpan(
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black),
                    children: [
                      pw.TextSpan(
                          text: exp["Job Title"] ?? "Not Provided",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.TextSpan(
                          text: " | ${exp["Company"] ?? "Not Provided"}"),
                    ],
                  ),
                ),
              ),
              pw.Text(
                "${_formatDate(exp["Start Date"] ?? "")} - ${_formatDate(exp["End Date"] ?? "Present")}",
                style:
                    pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      String joinDate = _formatDate(edu["Join Date"] ?? "");
      String completionDate = _formatDate(edu["Completion Date"] ?? "");
      String qualification = edu["Qualification"] ?? "Not Provided";
      String institution = edu["Institution"] ?? "Not Provided";

      return "$completionDate - $joinDate\n$qualification\n$institution";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) {
    return projects.map((proj) {
      return "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\n"
          "Technologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}";
    }).toList();
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: 30,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          "${contactDetails["phone"] ?? "Not Provided"} . ${contactDetails["email"] ?? "Not Provided"} . ${contactDetails["address"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  String _formatDate(String date) {
    if (date.isEmpty || date.toLowerCase() == "present") {
      return "Present";
    }

    try {
      // Try parsing with the expected format (MM/dd/yyyy)
      DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
      return DateFormat("MMMM yyyy").format(parsedDate);
    } catch (e) {
      // If parsing fails, try parsing with an alternative format (dd/MM/yyyy)
      try {
        DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
        return DateFormat("MMMM yyyy").format(parsedDate);
      } catch (e) {
        // If both formats fail, return "Invalid Date"
        return "Invalid Date";
      }
    }
  }
}
*/

/*correct one 

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class Template3 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template3({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Red Template"),
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
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(120),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 595,
              height: 842,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.redAccent, width: 5),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(userId["contactDetails"] ?? {}),
                    _buildExperienceSection(userId["experience"] ?? []),
                    _buildSkillsSection(userId),
                    _buildSection(
                        "PROJECTS", _formatProjects(userId["projects"] ?? [])),
                    _buildSection("EDUCATION",
                        _formatEducation(userId["education"] ?? [])),
                    _buildSection("AWARDS & ACHIEVEMENTS",
                        _formatList(userId["awards"] ?? [])),
                    _buildSection("CERTIFICATIONS",
                        _formatList(userId["certifications"] ?? [])),
                  ],
                ),
              ),
            ),
          ),
        ],
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
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.redAccent, width: 5),
            ),
            padding: pw.EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildPdfHeader(userData["contactDetails"] ?? {}),
                _buildPdfExperienceSection(userData["experience"] ?? []),
                _buildPdfSkillsSection(userData),
                _buildPdfSection(
                    "PROJECTS", _formatProjects(userData["projects"] ?? [])),
                _buildPdfSection(
                    "EDUCATION", _formatEducation(userData["education"] ?? [])),
                _buildPdfSection("AWARDS & ACHIEVEMENTS",
                    _formatList(userData["awards"] ?? [])),
                _buildPdfSection("CERTIFICATIONS",
                    _formatList(userData["certifications"] ?? [])),
              ],
            ),
          );
        },
      ),
    );
    return pdf;
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
          "SOFT SKILLS",
          style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 8),
        // Display soft skills as bullet points
        ...softSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: pw.Text(
                    "- $skill",
                    style: pw.TextStyle(fontSize: 11),
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 16),

        // Technical Skills Subheading
        pw.Text(
          "TECHNICAL SKILLS",
          style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 8),
        // Display technical skills as bullet points
        ...technicalSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: pw.Text(
                    "- $skill",
                    style: pw.TextStyle(fontSize: 11),
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatList(List<dynamic> list) {
    return list.map((item) => item.toString().trim()).toList();
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
              color: Colors.redAccent),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} . ${contactDetails["email"] ?? "Not Provided"} . ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 16),
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
        SizedBox(height: 8),
        Text(
          "Soft Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
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
              color: Colors.redAccent),
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

  Widget _buildSection(String title, List<String> items,
      {bool isBulleted = false}) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 8),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isBulleted)
                  Text(". ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<String> items,
      {bool isBulleted = false}) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 8),
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (isBulleted)
                  pw.Text(". ",
                      style: pw.TextStyle(
                          fontSize: 11, fontWeight: pw.FontWeight.bold)),
                pw.Expanded(
                  child: pw.Text(
                    item,
                    style: pw.TextStyle(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  Widget _buildExperienceSection(List<dynamic> experience) {
    if (experience.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        Text(
          "PROFESSIONAL EXPERIENCE",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 8),
        for (var exp in experience)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 11, color: Colors.black),
                      children: [
                        TextSpan(
                            text: exp["Job Title"] ?? "Not Provided",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " | ${exp["Company"] ?? "Not Provided"}"),
                      ],
                    ),
                  ),
                ),
                Text(
                  "${_formatDate(exp["Start Date"] ?? "")} - ${_formatDate(exp["End Date"] ?? "Present")}",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfExperienceSection(List<dynamic> experience) {
    if (experience.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 8),
        pw.Text(
          "PROFESSIONAL EXPERIENCE",
          style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 8),
        for (var exp in experience)
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.RichText(
                  text: pw.TextSpan(
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black),
                    children: [
                      pw.TextSpan(
                          text: exp["Job Title"] ?? "Not Provided",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.TextSpan(
                          text: " | ${exp["Company"] ?? "Not Provided"}"),
                    ],
                  ),
                ),
              ),
              pw.Text(
                "${_formatDate(exp["Start Date"] ?? "")} - ${_formatDate(exp["End Date"] ?? "Present")}",
                style:
                    pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      String joinDate = _formatDate(edu["Join Date"] ?? "");
      String completionDate = _formatDate(edu["Completion Date"] ?? "");
      String qualification = edu["Qualification"] ?? "Not Provided";
      String institution = edu["Institution"] ?? "Not Provided";

      return "$completionDate - $joinDate\n$qualification\n$institution";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) {
    return projects.map((proj) {
      return "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\n"
          "Technologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}";
    }).toList();
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: 30,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          "${contactDetails["phone"] ?? "Not Provided"} . ${contactDetails["email"] ?? "Not Provided"} . ${contactDetails["address"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  String _formatDate(String date) {
    if (date.isEmpty || date.toLowerCase() == "present") {
      return "Present";
    }

    try {
      // Try parsing with the expected format (MM/dd/yyyy)
      DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
      return DateFormat("MMMM yyyy").format(parsedDate);
    } catch (e) {
      // If parsing fails, try parsing with an alternative format (dd/MM/yyyy)
      try {
        DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
        return DateFormat("MMMM yyyy").format(parsedDate);
      } catch (e) {
        // If both formats fail, return "Invalid Date"
        return "Invalid Date";
      }
    }
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class Template3 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template3({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Red Template"),
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
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(120),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 595,
              height: 842,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.redAccent, width: 5),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(userId["contactDetails"] ?? {}),
                    _buildExperienceSection(userId["experience"] ?? []),
                    _buildSkillsSection(userId),
                    _buildSection(
                        "PROJECTS", _formatProjects(userId["projects"] ?? [])),
                    _buildSection("EDUCATION",
                        _formatEducation(userId["education"] ?? [])),
                    if (userId["awards"] != null && userId["awards"].isNotEmpty)
                      _buildSection("AWARDS & ACHIEVEMENTS",
                          _formatList(userId["awards"] ?? [])),
                    if (userId["certificates"] != null &&
                        userId["certificates"].isNotEmpty)
                      _buildSection("CERTIFICATES",
                          _formatList(userId["certificates"] ?? [])),
                  ],
                ),
              ),
            ),
          ),
        ],
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
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.redAccent, width: 5),
            ),
            padding: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildPdfHeader(userData["contactDetails"] ?? {}),
                _buildPdfExperienceSection(userData["experience"] ?? []),
                _buildPdfSkillsSection(userData),
                _buildPdfSection(
                    "PROJECTS", _formatProjects(userData["projects"] ?? [])),
                _buildPdfSection(
                    "EDUCATION", _formatEducation(userData["education"] ?? [])),
                if (userData["awards"] != null && userData["awards"].isNotEmpty)
                  _buildPdfSection("AWARDS & ACHIEVEMENTS",
                      _formatList(userData["awards"] ?? [])),
                if (userData["certificates"] != null &&
                    userData["certificates"].isNotEmpty)
                  _buildPdfSection("CERTIFICATES",
                      _formatList(userData["certificates"] ?? [])),
              ],
            ),
          );
        },
      ),
    );
    return pdf;
  }

  pw.Widget _buildPdfSkillsSection(Map<String, dynamic> userData) {
    List<dynamic> softSkills = userData["softSkills"] ?? [];
    List<dynamic> technicalSkills = userData["technicalSkills"] ?? [];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 8),
        pw.Text(
          "SOFT SKILLS",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 8),
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
        pw.Text(
          "TECHNICAL SKILLS",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 8),
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

  List<String> _formatList(List<dynamic> list) {
    return list.map((item) => item.toString().trim()).toList();
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
              color: Colors.redAccent),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} . ${contactDetails["email"] ?? "Not Provided"} . ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 14),
      ],
    );
  }

  Widget _buildSkillsSection(Map<String, dynamic> userData) {
    List<dynamic> softSkills = userData["softSkills"] ?? [];
    List<dynamic> technicalSkills = userData["technicalSkills"] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          "Soft Skills",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 8),
        ...softSkills
            .map((skill) => Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: Text(
                    "• $skill",
                    style: TextStyle(fontSize: 11),
                  ),
                ))
            .toList(),
        SizedBox(height: 16),
        Text(
          "Technical Skills",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 8),
        ...technicalSkills
            .map((skill) => Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: Text(
                    "• $skill",
                    style: TextStyle(fontSize: 11),
                  ),
                ))
            .toList(),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSection(String title, List<String> items,
      {bool isBulleted = false}) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 8),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isBulleted)
                  Text(". ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<String> items,
      {bool isBulleted = false}) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 8),
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (isBulleted)
                  pw.Text(". ",
                      style: pw.TextStyle(
                          fontSize: 10, fontWeight: pw.FontWeight.bold)),
                pw.Expanded(
                  child: pw.Text(
                    item,
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  Widget _buildExperienceSection(List<dynamic> experience) {
    if (experience.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        Text(
          "PROFESSIONAL EXPERIENCE",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 8),
        for (var exp in experience)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 11, color: Colors.black),
                      children: [
                        TextSpan(
                            text: exp["Job Title"] ?? "Not Provided",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " | ${exp["Company"] ?? "Not Provided"}"),
                      ],
                    ),
                  ),
                ),
                Text(
                  "${_formatDate(exp["Start Date"] ?? "")} - ${_formatDate(exp["End Date"] ?? "Present")}",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfExperienceSection(List<dynamic> experience) {
    if (experience.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 8),
        pw.Text(
          "PROFESSIONAL EXPERIENCE",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 8),
        for (var exp in experience)
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.RichText(
                  text: pw.TextSpan(
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black),
                    children: [
                      pw.TextSpan(
                          text: exp["Job Title"] ?? "Not Provided",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.TextSpan(
                          text: " | ${exp["Company"] ?? "Not Provided"}"),
                    ],
                  ),
                ),
              ),
              pw.Text(
                "${_formatDate(exp["Start Date"] ?? "")} - ${_formatDate(exp["End Date"] ?? "Present")}",
                style:
                    pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      String joinDate = _formatDate(edu["Join Date"] ?? "");
      String completionDate = _formatDate(edu["Completion Date"] ?? "");
      String qualification = edu["Qualification"] ?? "Not Provided";
      String institution = edu["Institution"] ?? "Not Provided";

      return "$completionDate - $joinDate\n$qualification\n$institution";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) {
    return projects.map((proj) {
      return "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\n"
          "Technologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}";
    }).toList();
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          "${contactDetails["phone"] ?? "Not Provided"} . ${contactDetails["email"] ?? "Not Provided"} . ${contactDetails["address"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 15),
      ],
    );
  }

  String _formatDate(String date) {
    if (date.isEmpty || date.toLowerCase() == "present") {
      return "Present";
    }

    try {
      DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
      return DateFormat("MMMM yyyy").format(parsedDate);
    } catch (e) {
      try {
        DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
        return DateFormat("MMMM yyyy").format(parsedDate);
      } catch (e) {
        return "Invalid Date";
      }
    }
  }
}
*/
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class Template3 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template3({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Red Template"),
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
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(120),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 595,
              height: 842,
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10), // Reduced padding
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.redAccent, width: 5),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(userId["contactDetails"] ?? {}),
                    if (userId["selected_summary"] != null &&
                        userId["selected_summary"].isNotEmpty)
                      _buildSection("SUMMARY", [userId["selected_summary"]]),
                    _buildExperienceSection(userId["experience"] ?? []),
                    _buildSkillsSection(userId),
                    _buildSection(
                        "PROJECTS", _formatProjects(userId["projects"] ?? [])),
                    _buildSection("EDUCATION",
                        _formatEducation(userId["education"] ?? [])),
                    if (userId["awards"] != null && userId["awards"].isNotEmpty)
                      _buildSection("AWARDS & ACHIEVEMENTS",
                          _formatList(userId["awards"] ?? [])),
                    if (userId["certificates"] != null &&
                        userId["certificates"].isNotEmpty)
                      _buildSection("CERTIFICATES",
                          _formatList(userId["certificates"] ?? [])),
                  ],
                ),
              ),
            ),
          ),
        ],
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
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.redAccent, width: 5),
            ),
            padding: pw.EdgeInsets.all(10), // Reduced padding for PDF
            margin: pw.EdgeInsets.zero, // Ensure no extra margin
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildPdfHeader(userData["contactDetails"] ?? {}),
                if (userData["selected_summary"] != null &&
                    userData["selected_summary"].isNotEmpty)
                  _buildPdfSection("SUMMARY", [userData["selected_summary"]]),
                _buildPdfExperienceSection(userData["experience"] ?? []),
                _buildPdfSkillsSection(userData),
                _buildPdfSection(
                    "PROJECTS", _formatProjects(userData["projects"] ?? [])),
                _buildPdfSection(
                    "EDUCATION", _formatEducation(userData["education"] ?? [])),
                if (userData["awards"] != null && userData["awards"].isNotEmpty)
                  _buildPdfSection("AWARDS & ACHIEVEMENTS",
                      _formatList(userData["awards"] ?? [])),
                if (userData["certificates"] != null &&
                    userData["certificates"].isNotEmpty)
                  _buildPdfSection("CERTIFICATES",
                      _formatList(userData["certificates"] ?? [])),
              ],
            ),
          );
        },
      ),
    );
    return pdf;
  }

  pw.Widget _buildPdfSkillsSection(Map<String, dynamic> userData) {
    List<dynamic> softSkills = userData["softSkills"] ?? [];
    List<dynamic> technicalSkills = userData["technicalSkills"] ?? [];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 7),
        pw.Text(
          "SOFT SKILLS",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 7),
        ...softSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: pw.Text(
                    "- $skill",
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 14),
        pw.Text(
          "TECHNICAL SKILLS",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 7),
        ...technicalSkills
            .map((skill) => pw.Padding(
                  padding: pw.EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: pw.Text(
                    "- $skill",
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ))
            .toList(),
        pw.SizedBox(height: 14),
      ],
    );
  }

  List<String> _formatList(List<dynamic> list) {
    return list.map((item) => item.toString().trim()).toList();
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
              color: Colors.redAccent),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} . ${contactDetails["email"] ?? "Not Provided"} . ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSkillsSection(Map<String, dynamic> userData) {
    List<dynamic> softSkills = userData["softSkills"] ?? [];
    List<dynamic> technicalSkills = userData["technicalSkills"] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          "Soft Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 8),
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
        Text(
          "Technical Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 8),
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

  Widget _buildSection(String title, List<String> items,
      {bool isBulleted = false}) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 8),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isBulleted)
                  Text(". ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<String> items,
      {bool isBulleted = false}) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 7),
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 7),
        for (var item in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (isBulleted)
                  pw.Text(". ",
                      style: pw.TextStyle(
                          fontSize: 10, fontWeight: pw.FontWeight.bold)),
                pw.Expanded(
                  child: pw.Text(
                    item,
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        pw.SizedBox(height: 14),
      ],
    );
  }

  Widget _buildExperienceSection(List<dynamic> experience) {
    if (experience.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        Text(
          "PROFESSIONAL EXPERIENCE",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 8),
        for (var exp in experience)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 11, color: Colors.black),
                      children: [
                        TextSpan(
                            text: exp["Job Title"] ?? "Not Provided",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " | ${exp["Company"] ?? "Not Provided"}"),
                      ],
                    ),
                  ),
                ),
                Text(
                  "${_formatDate(exp["Start Date"] ?? "")} - ${_formatDate(exp["End Date"] ?? "Present")}",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfExperienceSection(List<dynamic> experience) {
    if (experience.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 7),
        pw.Text(
          "PROFESSIONAL EXPERIENCE",
          style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 7),
        for (var exp in experience)
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.RichText(
                  text: pw.TextSpan(
                    style: pw.TextStyle(fontSize: 10, color: PdfColors.black),
                    children: [
                      pw.TextSpan(
                          text: exp["Job Title"] ?? "Not Provided",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.TextSpan(
                          text: " | ${exp["Company"] ?? "Not Provided"}"),
                    ],
                  ),
                ),
              ),
              pw.Text(
                "${_formatDate(exp["Start Date"] ?? "")} - ${_formatDate(exp["End Date"] ?? "Present")}",
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        pw.SizedBox(height: 14),
      ],
    );
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      String joinDate = _formatDate(edu["Join Date"] ?? "");
      String completionDate = _formatDate(edu["Completion Date"] ?? "");
      String qualification = edu["Qualification"] ?? "Not Provided";
      String institution = edu["Institution"] ?? "Not Provided";

      return "$completionDate - $joinDate\n$qualification\n$institution";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) {
    return projects.map((proj) {
      return "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\n"
          "Technologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}";
    }).toList();
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          "${contactDetails["phone"] ?? "Not Provided"} . ${contactDetails["email"] ?? "Not Provided"} . ${contactDetails["address"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 14),
      ],
    );
  }

  String _formatDate(String date) {
    if (date.isEmpty || date.toLowerCase() == "present") {
      return "Present";
    }

    try {
      DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
      return DateFormat("MMMM yyyy").format(parsedDate);
    } catch (e) {
      try {
        DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
        return DateFormat("MMMM yyyy").format(parsedDate);
      } catch (e) {
        return "Invalid Date";
      }
    }
  }
}
