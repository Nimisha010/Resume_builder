/*import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template2({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resume Template 2"),
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
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(userId["contactDetails"] ?? {}),
                _buildSection("EXPERIENCE", userId["experience"] ?? []),
                _buildSection("EDUCATION", userId["education"] ?? []),
                _buildSection("SKILLS", userId["skills"] ?? []),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        Text(contactDetails["address"] ?? "No Address",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 4), // Adds spacing
        Text(contactDetails["phone"] ?? "Not Provided",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 4),
        Text(contactDetails["email"] ?? "Not Provided",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSection(String title, List<dynamic> items) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              item.toString(),
              style: TextStyle(fontSize: 14),
            ),
          ),
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
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildPdfHeaderSection(userData["contactDetails"] ?? {}),
              _buildPdfSection("EXPERIENCE", userData["experience"] ?? []),
              _buildPdfSection("EDUCATION", userData["education"] ?? []),
              _buildPdfSection("SKILLS", userData["skills"] ?? []),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfHeaderSection(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: 26,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(contactDetails["address"] ?? "No Address",
                style: pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 4), // Adds spacing between lines
            pw.Text(contactDetails["phone"] ?? "Not Provided",
                style: pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 4),
            pw.Text(contactDetails["email"] ?? "Not Provided",
                style: pw.TextStyle(fontSize: 12)),
          ],
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<dynamic> items) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              item.toString(),
              style: pw.TextStyle(fontSize: 14),
            ),
          ),
        pw.SizedBox(height: 16),
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

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template2({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modern Resume"),
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
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                // Left & Right Green Border
                Positioned.fill(
                  child: Row(
                    children: [
                      Container(
                          width: 5,
                          color: const Color.fromARGB(
                              255, 97, 183, 100)), // Left Line
                      Expanded(child: Container()),
                      Container(
                          width: 5, color: Color.fromARGB(255, 97, 183, 100)),
                    ],
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderSection(userId["contactDetails"] ?? {}),
                      _buildSection("EXPERIENCE", userId["experience"] ?? []),
                      _buildSection("EDUCATION", userId["education"] ?? []),
                      _buildSection("SKILLS", userId["skills"] ?? []),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contactDetails["address"] ?? "No Address",
                style: TextStyle(fontSize: 14)),
            SizedBox(height: 4),
            Text(contactDetails["phone"] ?? "Not Provided",
                style: TextStyle(fontSize: 14)),
            SizedBox(height: 4),
            Text(contactDetails["email"] ?? "Not Provided",
                style: TextStyle(fontSize: 14)),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSection(String title, List<dynamic> items) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              item.toString(),
              style: TextStyle(fontSize: 14),
            ),
          ),
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
          return pw.Stack(
            children: [
              // Left & Right Green Borders
              pw.Positioned.fill(
                child: pw.Row(
                  children: [
                    pw.Container(width: 5, color: PdfColors.green), // Left Line
                    pw.Expanded(child: pw.Container()),
                    pw.Container(
                        width: 5, color: PdfColors.green), // Right Line
                  ],
                ),
              ),
              // Content
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 16),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildPdfHeaderSection(userData["contactDetails"] ?? {}),
                    _buildPdfSection(
                        "EXPERIENCE", userData["experience"] ?? []),
                    _buildPdfSection("EDUCATION", userData["education"] ?? []),
                    _buildPdfSection("SKILLS", userData["skills"] ?? []),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfHeaderSection(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: 26,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(contactDetails["address"] ?? "No Address",
                style: pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 4),
            pw.Text(contactDetails["phone"] ?? "Not Provided",
                style: pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 4),
            pw.Text(contactDetails["email"] ?? "Not Provided",
                style: pw.TextStyle(fontSize: 12)),
          ],
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<dynamic> items) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              item.toString(),
              style: pw.TextStyle(fontSize: 14),
            ),
          ),
        pw.SizedBox(height: 16),
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

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template2({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resume Template 2"),
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
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(userId["contactDetails"] ?? {}),
                _buildExperienceSection(userId["experience"] ?? []),
                _buildEducationSection(userId["education"] ?? []),
                _buildSkillsSection(userId["skills"] ?? []),
                _buildProjectsSection(userId["projects"] ?? []),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatField(dynamic field) {
    if (field is List) {
      return field.join(", ");
    }
    return field?.toString() ?? "Not Provided";
  }

  Widget _buildExperienceSection(List<dynamic> experience) {
    return experience.isEmpty
        ? SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("EXPERIENCE",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900])),
              Divider(thickness: 2, color: Colors.black),
              SizedBox(height: 8),
              ...experience.map((exp) => Text(formatField(exp))).toList(),
              SizedBox(height: 16),
            ],
          );
  }

  Widget _buildEducationSection(List<dynamic> education) {
    return education.isEmpty
        ? SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("EDUCATION",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900])),
              Divider(thickness: 2, color: Colors.black),
              SizedBox(height: 8),
              ...education.map((edu) => Text(formatField(edu))).toList(),
              SizedBox(height: 16),
            ],
          );
  }

  Widget _buildProjectsSection(List<dynamic> projects) {
    return projects.isEmpty
        ? SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("PROJECTS",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900])),
              Divider(thickness: 2, color: Colors.black),
              SizedBox(height: 8),
              ...projects.map((proj) => Text(formatField(proj))).toList(),
              SizedBox(height: 16),
            ],
          );
  }

  Widget _buildHeaderSection(Map<String, dynamic> contactDetails) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Container(height: 5, color: Colors.green[900])),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                formatField(contactDetails["name"]),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
            ),
            Expanded(child: Container(height: 5, color: Colors.green[900])),
          ],
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(formatField(contactDetails["address"]),
                style: TextStyle(fontSize: 14)),
            SizedBox(height: 4),
            Text(formatField(contactDetails["phone"]),
                style: TextStyle(fontSize: 14)),
            SizedBox(height: 4),
            Text(formatField(contactDetails["email"]),
                style: TextStyle(fontSize: 14)),
          ],
        ),
        SizedBox(height: 10),
        Container(height: 5, color: Colors.green[900]),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSkillsSection(List<dynamic> skills) {
    return skills.isEmpty
        ? SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("SKILLS",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900])),
              Divider(thickness: 2, color: Colors.black),
              SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 5,
                children: skills
                    .map((skill) => Chip(label: Text(skill.toString())))
                    .toList(),
              ),
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
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildPdfHeaderSection(userData["contactDetails"] ?? {}),
              _buildPdfExperienceSection(userData["experience"] ?? []),
              _buildPdfEducationSection(userData["education"] ?? []),
              _buildPdfSkillsSection(userData["skills"] ?? []),
              _buildPdfProjectsSection(userData["projects"] ?? []),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfHeaderSection(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(formatField(contactDetails["name"]),
            style: pw.TextStyle(
                fontSize: 26,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.green900)),
        pw.SizedBox(height: 8),
        pw.Text(formatField(contactDetails["address"]),
            style: pw.TextStyle(fontSize: 12)),
        pw.SizedBox(height: 4),
        pw.Text(formatField(contactDetails["phone"]),
            style: pw.TextStyle(fontSize: 12)),
        pw.SizedBox(height: 4),
        pw.Text(formatField(contactDetails["email"]),
            style: pw.TextStyle(fontSize: 12)),
        pw.SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfExperienceSection(List<dynamic> experience) {
    return experience.isEmpty
        ? pw.SizedBox()
        : pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("EXPERIENCE",
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.green900)),
              pw.Divider(thickness: 2, color: PdfColors.black),
              pw.SizedBox(height: 8),
              ...experience.map((exp) => pw.Text(formatField(exp))).toList(),
              pw.SizedBox(height: 16),
            ],
          );
  }

  pw.Widget _buildPdfEducationSection(List<dynamic> education) {
    return education.isEmpty
        ? pw.SizedBox()
        : pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("EDUCATION",
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.green900)),
              pw.Divider(thickness: 2, color: PdfColors.black),
              pw.SizedBox(height: 8),
              ...education.map((edu) => pw.Text(formatField(edu))).toList(),
              pw.SizedBox(height: 16),
            ],
          );
  }

  pw.Widget _buildPdfSkillsSection(List<dynamic> skills) {
    return skills.isEmpty
        ? pw.SizedBox()
        : pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("SKILLS",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 8),
              ...skills.map((skill) => pw.Text(formatField(skill))).toList(),
              pw.SizedBox(height: 16),
            ],
          );
  }

  pw.Widget _buildPdfProjectsSection(List<dynamic> projects) {
    return projects.isEmpty
        ? pw.SizedBox()
        : pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("PROJECTS",
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.green900)),
              pw.Divider(thickness: 2, color: PdfColors.black),
              pw.SizedBox(height: 8),
              ...projects.map((proj) => pw.Text(formatField(proj))).toList(),
              pw.SizedBox(height: 16),
            ],
          );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template2 extends StatefulWidget {
  final String userId;

  Template2({required this.userId});

  @override
  _Template2State createState() => _Template2State();
}

class _Template2State extends State<Template2> {
  Map<String, dynamic> userData = {};
  bool isLoading = true; // For showing loader

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Modern Resume"),
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
      body: userData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  width: 595,
                  height: 842,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Stack(
                    children: [
                      // Left & Right Green Borders
                      Positioned.fill(
                        child: Row(
                          children: [
                            Container(width: 5, color: Colors.green),
                            Expanded(child: Container()),
                            Container(width: 5, color: Colors.green),
                          ],
                        ),
                      ),
                      // Resume Content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeaderSection(
                                userData["contactDetails"] ?? {}),
                            _buildSection(
                                "EXPERIENCE", userData["experience"] ?? []),
                            _buildSection(
                                "EDUCATION", userData["education"] ?? []),
                            _buildSection("SKILLS", userData["skills"] ?? []),
                            _buildSection(
                                "PROJECTS", userData["projects"] ?? []),
                            _buildSection("AWARDS & ACHIEVEMENTS",
                                userData["awards"] ?? []),
                            _buildSection(
                                "CERTIFICATES", userData["certificates"] ?? []),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildHeaderSection(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        Text(contactDetails["address"] ?? "No Address",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 4),
        Text(contactDetails["phone"] ?? "Not Provided",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 4),
        Text(contactDetails["email"] ?? "Not Provided",
            style: TextStyle(fontSize: 14)),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSection(String title, List<dynamic> items) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              item.toString(),
              style: TextStyle(fontSize: 14),
            ),
          ),
        SizedBox(height: 16),
      ],
    );
  }

  Future<pw.Document> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              // Left & Right Green Borders
              pw.Positioned.fill(
                child: pw.Row(
                  children: [
                    pw.Container(width: 5, color: PdfColors.green),
                    pw.Expanded(child: pw.Container()),
                    pw.Container(width: 5, color: PdfColors.green),
                  ],
                ),
              ),
              // Resume Content
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 16),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildPdfHeaderSection(userData["contactDetails"] ?? {}),
                    _buildPdfSection(
                        "EXPERIENCE", userData["experience"] ?? []),
                    _buildPdfSection("EDUCATION", userData["education"] ?? []),
                    _buildPdfSection("SKILLS", userData["skills"] ?? []),
                    _buildPdfSection("PROJECTS", userData["projects"] ?? []),
                    _buildPdfSection(
                        "AWARDS & ACHIEVEMENTS", userData["awards"] ?? []),
                    _buildPdfSection(
                        "CERTIFICATES", userData["certificates"] ?? []),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfHeaderSection(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: 26,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        pw.Text(contactDetails["address"] ?? "No Address",
            style: pw.TextStyle(fontSize: 12)),
        pw.SizedBox(height: 4),
        pw.Text(contactDetails["phone"] ?? "Not Provided",
            style: pw.TextStyle(fontSize: 12)),
        pw.SizedBox(height: 4),
        pw.Text(contactDetails["email"] ?? "Not Provided",
            style: pw.TextStyle(fontSize: 12)),
        pw.SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<dynamic> items) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              item.toString(),
              style: pw.TextStyle(fontSize: 14),
            ),
          ),
        pw.SizedBox(height: 16),
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

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template2({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Modern Resume"),
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
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
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
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(userId["contactDetails"] ?? {}),
                    _buildSection("PROFESSIONAL EXPERIENCE",
                        _formatExperience(userId["experience"] ?? [])),
                    _buildSection("KEY SKILLS", userId["skills"] ?? [],
                        isBulleted: true),
                    _buildSection("EDUCATION",
                        _formatEducation(userId["education"] ?? [])),
                    _buildSection(
                        "CERTIFICATIONS", userId["certifications"] ?? []),
                  ],
                ),
              ),
            ),
          ),
        ],
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
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
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
              fontSize: 18,
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
                  Text("• ",
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

  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildPdfHeader(userData["contactDetails"] ?? {}),
              _buildPdfSection("PROFESSIONAL EXPERIENCE",
                  _formatExperience(userData["experience"] ?? [])),
              _buildPdfSection("KEY SKILLS", userData["skills"] ?? [],
                  isBulleted: true),
              _buildPdfSection(
                  "EDUCATION", _formatEducation(userData["education"] ?? [])),
              _buildPdfSection(
                  "CERTIFICATIONS", userData["certifications"] ?? []),
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
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: 30,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      return "${exp["Job Title"] ?? "Not Provided"} | ${exp["Company"] ?? "Not Provided"}\n"
          "${exp["Start Date"] ?? "Not Provided"} - ${exp["End Date"] ?? "Present"}";
    }).toList();
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      return "${edu["Qualification"] ?? "Not Provided"} | ${edu["Institution"] ?? "Not Provided"}\n"
          "${edu["Completion Date"] ?? "Not Provided"}";
    }).toList();
  }
}
*/
/*Mila red temp
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template2({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Modern Resume"),
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
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
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
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(userId["contactDetails"] ?? {}),
                    _buildSection("PROFESSIONAL EXPERIENCE",
                        _formatExperience(userId["experience"] ?? [])),
                    _buildSection("KEY SKILLS", userId["skills"] ?? [],
                        isBulleted: true),
                    _buildSection("EDUCATION",
                        _formatEducation(userId["education"] ?? [])),
                    _buildSection(
                        "CERTIFICATIONS", userId["certifications"] ?? []),
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
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildPdfHeader(userData["contactDetails"] ?? {}),
              _buildPdfSection("PROFESSIONAL EXPERIENCE",
                  _formatExperience(userData["experience"] ?? [])),
              _buildPdfSection("KEY SKILLS", userData["skills"] ?? [],
                  isBulleted: true),
              _buildPdfSection(
                  "EDUCATION", _formatEducation(userData["education"] ?? [])),
              _buildPdfSection(
                  "CERTIFICATIONS", userData["certifications"] ?? []),
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
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: 30,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.redAccent),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      return "${exp["Job Title"] ?? "Not Provided"} | ${exp["Company"] ?? "Not Provided"}\n"
          "${exp["Start Date"] ?? "Not Provided"} - ${exp["End Date"] ?? "Present"}";
    }).toList();
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      return "${edu["Qualification"] ?? "Not Provided"} | ${edu["Institution"] ?? "Not Provided"}\n"
          "${edu["Completion Date"] ?? "Not Provided"}";
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
              color: Colors.redAccent),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
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
              fontSize: 18,
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
                  Text("• ",
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
              fontSize: 18,
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
                  pw.Text("• ",
                      style: pw.TextStyle(
                          fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Expanded(
                  child: pw.Text(
                    item,
                    style: pw.TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        pw.SizedBox(height: 16),
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

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template2({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modern Resume"),
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
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(userId["contactDetails"] ?? {}),
                _buildSection("EXPERIENCE", userId["experience"] ?? []),
                _buildSection("EDUCATION", userId["education"] ?? []),
                _buildSkillsSection(userId["skills"] ?? []),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactDetails["name"] ?? "No Name",
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        SizedBox(height: 8),
        Text(contactDetails["phone"] ?? "Not Provided"),
        Text(contactDetails["email"] ?? "Not Provided"),
        Text(contactDetails["address"] ?? "No Address"),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSection(String title, List<dynamic> items) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["title"] ?? "",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  item["date"] ?? "",
                  style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                ),
                Text(item["description"] ?? "", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSkillsSection(List<dynamic> skills) {
    if (skills.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SKILLS",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        Divider(thickness: 2, color: Colors.black),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: skills.map((skill) => Chip(label: Text(skill))).toList(),
        ),
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
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildPdfHeaderSection(userData["contactDetails"] ?? {}),
              _buildPdfSection("EXPERIENCE", userData["experience"] ?? []),
              _buildPdfSection("EDUCATION", userData["education"] ?? []),
              _buildPdfSkillsSection(userData["skills"] ?? []),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfHeaderSection(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: 26,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 8),
        pw.Text(contactDetails["phone"] ?? "Not Provided"),
        pw.Text(contactDetails["email"] ?? "Not Provided"),
        pw.Text(contactDetails["address"] ?? "No Address"),
        pw.SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<dynamic> items) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900),
        ),
        pw.Divider(thickness: 2, color: PdfColors.black),
        for (var item in items)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(item["title"] ?? "",
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.Text(item["date"] ?? "",
                  style: pw.TextStyle(
                      fontSize: 12, fontStyle: pw.FontStyle.italic)),
              pw.Text(item["description"] ?? "",
                  style: pw.TextStyle(fontSize: 12)),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildPdfSkillsSection(List<dynamic> skills) {
    return pw.Wrap(
      spacing: 10,
      runSpacing: 8,
      children: skills
          .map(
              (skill) => pw.Text("• $skill", style: pw.TextStyle(fontSize: 12)))
          .toList(),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template2({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Modern Resume"),
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
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
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
                    _buildSection("PROFESSIONAL EXPERIENCE",
                        _formatExperience(userId["experience"] ?? [])),
                    _buildSection("KEY SKILLS", userId["skills"] ?? [],
                        isBulleted: true),
                    _buildSection("EDUCATION",
                        _formatEducation(userId["education"] ?? [])),
                    _buildSection(
                        "CERTIFICATIONS", userId["certifications"] ?? []),
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
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildPdfHeader(userData["contactDetails"] ?? {}),
              _buildPdfSection("PROFESSIONAL EXPERIENCE",
                  _formatExperience(userData["experience"] ?? [])),
              _buildPdfSection("KEY SKILLS", userData["skills"] ?? [],
                  isBulleted: true),
              _buildPdfSection(
                  "EDUCATION", _formatEducation(userData["education"] ?? [])),
              _buildPdfSection(
                  "CERTIFICATIONS", userData["certifications"] ?? []),
            ],
          );
        },
      ),
    );
    return pdf;
  }

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      return "${exp["Job Title"] ?? "Not Provided"} | ${exp["Company"] ?? "Not Provided"}\n"
          "${exp["Start Date"] ?? "Not Provided"} - ${exp["End Date"] ?? "Present"}";
    }).toList();
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      return "${edu["Qualification"] ?? "Not Provided"} | ${edu["Institution"] ?? "Not Provided"}\n"
          "${edu["Completion Date"] ?? "Not Provided"}";
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
              color: Colors.redAccent),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
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
              fontSize: 18,
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
                  Text("• ",
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
              fontSize: 18,
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
                  pw.Text("• ",
                      style: pw.TextStyle(
                          fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Expanded(
                  child: pw.Text(
                    item,
                    style: pw.TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        pw.SizedBox(height: 16),
      ],
    );
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
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userData;

  Template2({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userData["templateName"] ?? "Modern Resume"),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = await _generatePdf(userData);
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
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(userData["contactDetails"] ?? {}),
                _buildSection("Experience",
                    _formatExperience(userData["experience"] ?? [])),
                _buildSection(
                    "Education", _formatEducation(userData["education"] ?? [])),
                _buildSkills(userData["skills"] ?? []),
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
          return pw.Padding(
            padding: pw.EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildPdfHeader(userData["contactDetails"] ?? {}),
                _buildPdfSection("Experience",
                    _formatExperience(userData["experience"] ?? [])),
                _buildPdfSection(
                    "Education", _formatEducation(userData["education"] ?? [])),
                _buildPdfSkills(userData["skills"] ?? []),
              ],
            ),
          );
        },
      ),
    );
    return pdf;
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
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 16),
      ],
    );
  }

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
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              item,
              style: TextStyle(fontSize: 14),
            ),
          ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSkills(List<String> skills) {
    if (skills.isEmpty) return SizedBox();
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
          children: skills.map((skill) => Chip(label: Text(skill))).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      return "${exp["Job Title"] ?? "Not Provided"} | ${exp["Company"] ?? "Not Provided"}\n"
          "${exp["Start Date"] ?? "Not Provided"} - ${exp["End Date"] ?? "Present"}";
    }).toList();
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      return "${edu["Qualification"] ?? "Not Provided"} | ${edu["Institution"] ?? "Not Provided"}\n"
          "${edu["Completion Date"] ?? "Not Provided"}";
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
              color: PdfColors.green900),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          contactDetails["jobTitle"] ?? "Job Title",
          style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.black),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
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
        pw.Text(title,
            style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.green900)),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Text(item, style: pw.TextStyle(fontSize: 14)),
        pw.SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfSkills(List<String> skills) {
    return pw.Wrap(
      spacing: 20,
      runSpacing: 8,
      children: skills.map((skill) => pw.Text(skill)).toList(),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template2({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Modern Resume"),
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
                _buildSection("Skills", _formatList(userId["skills"] ?? []),
                    isGrid: true),
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
                _buildPdfSection(
                    "Skills", _formatList(userData["skills"] ?? []),
                    isGrid: true),
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

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      return "${exp["Job Title"] ?? "Not Provided"} | ${exp["Company"] ?? "Not Provided"}\n"
          "${exp["Start Date"] ?? "Not Provided"} - ${exp["End Date"] ?? "Present"}";
    }).toList();
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      return "${edu["Qualification"] ?? "Not Provided"} | ${edu["Institution"] ?? "Not Provided"}\n"
          "${edu["Completion Date"] ?? "Not Provided"}";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) {
    return projects.map((proj) {
      return "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\n"
          "Technologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}";
    }).toList();
  }

  List<String> _formatList(List<dynamic> list) {
    return list.map((item) => item.toString()).toList();
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
              color: Colors.green[800]),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSection(String title, List<String> items,
      {bool isGrid = false}) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 2, color: Colors.black),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[800]),
        ),
        SizedBox(height: 8),
        isGrid
            ? Wrap(
                spacing: 20,
                runSpacing: 10,
                children: items.map((item) => Chip(label: Text(item))).toList(),
              )
            : Column(
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

  pw.Widget _buildPdfSection(String title, List<String> items,
      {bool isGrid = false}) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 8),
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green),
        ),
        pw.SizedBox(height: 8),
        isGrid
            ? pw.Wrap(
                spacing: 20,
                runSpacing: 10,
                children: items
                    .map((item) => pw.Container(
                          padding: pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColors.green),
                            borderRadius: pw.BorderRadius.circular(5),
                          ),
                          child: pw.Text(item),
                        ))
                    .toList(),
              )
            : pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: items
                    .map((item) => pw.Padding(
                          padding: const pw.EdgeInsets.only(bottom: 6.0),
                          child:
                              pw.Text(item, style: pw.TextStyle(fontSize: 14)),
                        ))
                    .toList(),
              ),
        pw.SizedBox(height: 16),
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

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template2({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Modern Resume"),
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
                _buildSection("Skills", _formatList(userId["skills"] ?? [])),
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
                _buildPdfSection(
                    "Skills", _formatList(userData["skills"] ?? [])),
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

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      return "${exp["Job Title"] ?? "Not Provided"} | ${exp["Company"] ?? "Not Provided"}\n"
          "${exp["Start Date"] ?? "Not Provided"} - ${exp["End Date"] ?? "Present"}";
    }).toList();
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      return "${edu["Qualification"] ?? "Not Provided"} | ${edu["Institution"] ?? "Not Provided"}\n"
          "${edu["Completion Date"] ?? "Not Provided"}";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) {
    return projects.map((proj) {
      return "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\n"
          "Technologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}";
    }).toList();
  }

  List<String> _formatList(List<dynamic> list) {
    return list.map((item) => item.toString()).toList();
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
              color: Colors.green[800]),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 16),
      ],
    );
  }

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
              color: Colors.green[800]),
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

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: 30,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green800),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
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
              color: PdfColors.green800),
        ),
        pw.SizedBox(height: 8),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: items
              .map((item) => pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 6.0),
                    child: pw.Text(item, style: pw.TextStyle(fontSize: 14)),
                  ))
              .toList(),
        ),
        pw.SizedBox(height: 16),
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

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template2({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Modern Resume"),
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
                _buildSkillsSection(
                    userId["skills"] ?? []), // ✅ Fixed Skills Display
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
                _buildPdfSkillsSection(
                    userData["skills"] ?? []), // ✅ Fixed Skills Display in PDF
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

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      return "${exp["Job Title"] ?? "Not Provided"} | ${exp["Company"] ?? "Not Provided"}\n"
          "${exp["Start Date"] ?? "Not Provided"} - ${exp["End Date"] ?? "Present"}";
    }).toList();
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      return "${edu["Qualification"] ?? "Not Provided"} | ${edu["Institution"] ?? "Not Provided"}\n"
          "${edu["Completion Date"] ?? "Not Provided"}";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) {
    return projects.map((proj) {
      return "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\n"
          "Technologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}";
    }).toList();
  }

  List<String> _formatList(List<dynamic> list) {
    return list.map((item) => item.toString()).toList();
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
              color: Colors.green[800]),
        ),
        SizedBox(height: 5),
        Text(
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 16),
      ],
    );
  }

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
              color: Colors.green[800]),
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

  // ✅ Fixed Skills UI Section
  Widget _buildSkillsSection(List<String> skills) {
    if (skills.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          "Skills",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[800]),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          children: skills.map((skill) => Chip(label: Text(skill))).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  // ✅ Fixed Skills PDF Section
  pw.Widget _buildPdfSkillsSection(List<String> skills) {
    if (skills.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 8),
        pw.Text(
          "Skills",
          style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green),
        ),
        pw.SizedBox(height: 8),
        pw.Wrap(
          spacing: 10,
          runSpacing: 10,
          children: skills
              .map((skill) => pw.Container(
                    padding: pw.EdgeInsets.all(5),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.green, width: 1),
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

  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: 30,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green800),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
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
              color: PdfColors.green),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(item, style: pw.TextStyle(fontSize: 14)),
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }
}
*/
/* correct one without skills

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template2({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Modern Resume"),
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
                _buildSkillsSection(
                    userId["skills"] ?? []), // ✅ Skills Fix Applied
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
                _buildPdfSkillsSection(
                    userData["skills"] ?? []), // ✅ Fixed PDF Skills Display
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
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: 30,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green800),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          "${contactDetails["phone"] ?? "Not Provided"} • ${contactDetails["email"] ?? "Not Provided"} • ${contactDetails["address"] ?? "Not Provided"}",
          style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  List<String> _formatExperience(List<dynamic> experience) {
    return experience.map((exp) {
      return "${exp["Job Title"] ?? "Not Provided"} | ${exp["Company"] ?? "Not Provided"}\n"
          "${exp["Start Date"] ?? "Not Provided"} - ${exp["End Date"] ?? "Present"}";
    }).toList();
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      return "${edu["Qualification"] ?? "Not Provided"} | ${edu["Institution"] ?? "Not Provided"}\n"
          "${edu["Completion Date"] ?? "Not Provided"}";
    }).toList();
  }

  List<String> _formatProjects(List<dynamic> projects) {
    return projects.map((proj) {
      return "${proj["title"] ?? "Not Provided"} | ${proj["role"] ?? "Not Provided"}\n"
          "Technologies: ${proj["technologies"]?.join(", ") ?? "Not Provided"}";
    }).toList();
  }

  List<String> _formatList(List<dynamic> list) {
    return list.map((item) => item.toString()).toList();
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

  // ✅ Fixed Skills UI Section
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

  // ✅ Fixed Skills PDF Section
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
                      border: pw.Border.all(color: PdfColors.green900, width: 1),
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
            child: pw.Text(item, style: pw.TextStyle(fontSize: 14)),
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }

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
}*/
/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userData; // Data passed directly

  Template2({required this.userData});

  @override
  Widget build(BuildContext context) {
    // Debug: Print the userData to verify its structure
    print("User Data: $userData");

    return Scaffold(
      appBar: AppBar(
        title: Text("Modern Resume"),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = await _generatePdf(userData);
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
                // Personal Information Section
                if (userData["personal_info"] != null)
                  _buildSection(
                    userData["personal_info"]["title"] ??
                        "Personal Information",
                    [
                      "Name: ${userData["personal_info"]["fields"][0] ?? "Not Provided"}",
                      "Address: ${userData["personal_info"]["fields"][1] ?? "Not Provided"}",
                      "Phone no: ${userData["personal_info"]["fields"][2] ?? "Not Provided"}",
                      "Email ID: ${userData["personal_info"]["fields"][3] ?? "Not Provided"}",
                      "GitHub Profile: ${userData["personal_info"]["fields"][4] ?? "Not Provided"}",
                      "LinkedIn Profile: ${userData["personal_info"]["fields"][5] ?? "Not Provided"}",
                      "Languages: ${userData["personal_info"]["fields"][6] ?? "Not Provided"}",
                    ],
                  ),

                // Education Section
                if (userData["education"] != null)
                  _buildSection(
                    userData["education"]["title"] ?? "Education",
                    [
                      "Qualification: ${userData["education"]["fields"][0] ?? "Not Provided"}",
                      "Institution name: ${userData["education"]["fields"][1] ?? "Not Provided"}",
                      "Course join date: ${userData["education"]["fields"][2] ?? "Not Provided"}",
                      "Course completion date: ${userData["education"]["fields"][3] ?? "Not Provided"}",
                    ],
                  ),

                // Experience Section
                if (userData["experience"] != null)
                  _buildSection(
                    userData["experience"]["title"] ?? "Experience",
                    [
                      "Job Title: ${userData["experience"]["fields"][0] ?? "Not Provided"}",
                      "Company name: ${userData["experience"]["fields"][1] ?? "Not Provided"}",
                      "Start Date: ${userData["experience"]["fields"][2] ?? "Not Provided"}",
                      "End Date: ${userData["experience"]["fields"][3] ?? "Not Provided"}",
                    ],
                  ),

                // Skills Section
                if (userData["skills"] != null)
                  _buildSection(
                    userData["skills"]["title"] ?? "Skills",
                    [
                      "Soft skills: ${userData["skills"]["fields"][0] ?? "Not Provided"}",
                      "Technical skills: ${userData["skills"]["fields"][1] ?? "Not Provided"}",
                    ],
                  ),

                // Projects Section
                if (userData["projects"] != null)
                  _buildSection(
                    userData["projects"]["title"] ?? "Projects",
                    [
                      "Title: ${userData["projects"]["fields"][0] ?? "Not Provided"}",
                      "Role: ${userData["projects"]["fields"][1] ?? "Not Provided"}",
                      "Technologies/Tools: ${userData["projects"]["fields"][2] ?? "Not Provided"}",
                    ],
                  ),

                // Awards/Achievements Section
                if (userData["awards_achievements"] != null &&
                    userData["awards_achievements"]["fields"][0] != null)
                  _buildSection(
                    userData["awards_achievements"]["title"] ??
                        "Awards/Achievements",
                    [
                      userData["awards_achievements"]["fields"][0],
                    ],
                  ),

                // Certificates Section
                if (userData["certificates"] != null &&
                    userData["certificates"]["fields"][0] != null)
                  _buildSection(
                    userData["certificates"]["title"] ?? "Certificates",
                    [
                      userData["certificates"]["fields"][0],
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🎨 Helper method to build sections dynamically
  Widget _buildSection(String title, List<String> items) {
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
              // Personal Information Section
              if (userData["personal_info"] != null)
                _buildPdfSection(
                  userData["personal_info"]["title"] ?? "Personal Information",
                  [
                    "Name: ${userData["personal_info"]["fields"][0] ?? "Not Provided"}",
                    "Address: ${userData["personal_info"]["fields"][1] ?? "Not Provided"}",
                    "Phone no: ${userData["personal_info"]["fields"][2] ?? "Not Provided"}",
                    "Email ID: ${userData["personal_info"]["fields"][3] ?? "Not Provided"}",
                    "GitHub Profile: ${userData["personal_info"]["fields"][4] ?? "Not Provided"}",
                    "LinkedIn Profile: ${userData["personal_info"]["fields"][5] ?? "Not Provided"}",
                    "Languages: ${userData["personal_info"]["fields"][6] ?? "Not Provided"}",
                  ],
                ),

              // Education Section
              if (userData["education"] != null)
                _buildPdfSection(
                  userData["education"]["title"] ?? "Education",
                  [
                    "Qualification: ${userData["education"]["fields"][0] ?? "Not Provided"}",
                    "Institution name: ${userData["education"]["fields"][1] ?? "Not Provided"}",
                    "Course join date: ${userData["education"]["fields"][2] ?? "Not Provided"}",
                    "Course completion date: ${userData["education"]["fields"][3] ?? "Not Provided"}",
                  ],
                ),

              // Experience Section
              if (userData["experience"] != null)
                _buildPdfSection(
                  userData["experience"]["title"] ?? "Experience",
                  [
                    "Job Title: ${userData["experience"]["fields"][0] ?? "Not Provided"}",
                    "Company name: ${userData["experience"]["fields"][1] ?? "Not Provided"}",
                    "Start Date: ${userData["experience"]["fields"][2] ?? "Not Provided"}",
                    "End Date: ${userData["experience"]["fields"][3] ?? "Not Provided"}",
                  ],
                ),

              // Skills Section
              if (userData["skills"] != null)
                _buildPdfSection(
                  userData["skills"]["title"] ?? "Skills",
                  [
                    "Soft skills: ${userData["skills"]["fields"][0] ?? "Not Provided"}",
                    "Technical skills: ${userData["skills"]["fields"][1] ?? "Not Provided"}",
                  ],
                ),

              // Projects Section
              if (userData["projects"] != null)
                _buildPdfSection(
                  userData["projects"]["title"] ?? "Projects",
                  [
                    "Title: ${userData["projects"]["fields"][0] ?? "Not Provided"}",
                    "Role: ${userData["projects"]["fields"][1] ?? "Not Provided"}",
                    "Technologies/Tools: ${userData["projects"]["fields"][2] ?? "Not Provided"}",
                  ],
                ),

              // Awards/Achievements Section
              if (userData["awards_achievements"] != null &&
                  userData["awards_achievements"]["fields"][0] != null)
                _buildPdfSection(
                  userData["awards_achievements"]["title"] ??
                      "Awards/Achievements",
                  [
                    userData["awards_achievements"]["fields"][0],
                  ],
                ),

              // Certificates Section
              if (userData["certificates"] != null &&
                  userData["certificates"]["fields"][0] != null)
                _buildPdfSection(
                  userData["certificates"]["title"] ?? "Certificates",
                  [
                    userData["certificates"]["fields"][0],
                  ],
                ),
            ],
          );
        },
      ),
    );

    return pdf;
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
}*/
/*import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userData;

  Template2({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userData["templateName"] ?? "Professional Resume"),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = await _generatePdf(userData);
              await Printing.layoutPdf(
                onLayout: (format) => pdf.save(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(userData["contactDetails"] ?? {}),
            _buildSection("PROFILE", [userData["summary"] ?? ""]),
            _buildExperienceSection(userData["experience"] ?? []),
            _buildSection(
                "EDUCATION", _formatEducation(userData["education"] ?? [])),
            _buildSection("SKILLS", _formatSkills(userData["skills"] ?? [])),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> contact) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(contact["name"] ?? "Your Name",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(contact["title"] ?? "Your Title",
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
        SizedBox(height: 8),
        Text(
            "${contact["address"] ?? ""} | ${contact["phone"] ?? ""} | ${contact["email"] ?? ""}",
            style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        Divider(thickness: 2),
      ],
    );
  }

  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Divider(thickness: 1),
        for (var item in items)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text(item, style: TextStyle(fontSize: 14)),
          ),
      ],
    );
  }

  Widget _buildExperienceSection(List<dynamic> experiences) {
    if (experiences.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text("EMPLOYMENT HISTORY",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Divider(thickness: 1),
        for (var exp in experiences)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("\u25C9 ${exp["Job Title"] ?? ""}, ${exp["Company"] ?? ""}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                  "${exp["Start Date"] ?? ""} - ${exp["End Date"] ?? "Present"} | ${exp["Location"] ?? ""}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              for (var desc in exp["Description"] ?? [])
                Text("• $desc", style: TextStyle(fontSize: 14)),
              SizedBox(height: 8),
            ],
          ),
      ],
    );
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      return "${edu["Qualification"] ?? ""}, ${edu["Institution"] ?? ""} (${edu["Start Date"] ?? ""} - ${edu["Completion Date"] ?? ""})";
    }).toList();
  }

  List<String> _formatSkills(List<dynamic> skills) {
    return skills.map((skill) => "$skill").toList();
  }

  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildPdfHeader(userData["contactDetails"] ?? {}),
              _buildPdfSection("PROFILE", [userData["summary"] ?? ""]),
              _buildPdfExperience(userData["experience"] ?? []),
              _buildPdfSection(
                  "EDUCATION", _formatEducation(userData["education"] ?? [])),
              _buildPdfSection(
                  "SKILLS", _formatSkills(userData["skills"] ?? [])),
            ],
          );
        },
      ),
    );
    return pdf;
  }

  pw.Widget _buildPdfSection(String title, String content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title,
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.Text(content, textAlign: pw.TextAlign.justify),
        pw.Divider(thickness: 2),
      ],
    );
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contact) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(contact["name"] ?? "Your Name",
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
        pw.Text(contact["title"] ?? "Your Title",
            style: pw.TextStyle(fontSize: 18, fontStyle: pw.FontStyle.italic)),
        pw.Text(
            "${contact["address"] ?? ""} | ${contact["phone"] ?? ""} | ${contact["email"] ?? ""}",
            style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
        pw.Divider(thickness: 2),
      ],
    );
  }

  pw.Widget _buildPdfExperience(List<dynamic> experiences) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: experiences.map((exp) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("\u25C9 ${exp["Job Title"] ?? ""}, ${exp["Company"] ?? ""}",
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.Text(
                "${exp["Start Date"] ?? ""} - ${exp["End Date"] ?? "Present"} | ${exp["Location"] ?? ""}",
                style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
            for (var desc in exp["Description"] ?? [])
              pw.Text("• $desc", style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 8),
          ],
        );
      }).toList(),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userData;

  Template2({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userData["templateName"] ?? "Professional Resume"),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = await _generatePdf(userData);
              await Printing.layoutPdf(
                onLayout: (format) => pdf.save(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(userData["contactDetails"] ?? {}),
            _buildSection("PROFILE", [userData["summary"] ?? ""]),
            _buildExperienceSection(userData["experience"] ?? []),
            _buildSection(
                "EDUCATION", _formatEducation(userData["education"] ?? [])),
            _buildSection("SKILLS", _formatSkills(userData["skills"] ?? [])),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> contact) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(contact["name"] ?? "Your Name",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(contact["title"] ?? "Your Title",
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
        SizedBox(height: 8),
        Text(
            "${contact["address"] ?? ""} | ${contact["phone"] ?? ""} | ${contact["email"] ?? ""}",
            style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        Divider(thickness: 2),
      ],
    );
  }

  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Divider(thickness: 1),
        for (var item in items)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text(item, style: TextStyle(fontSize: 14)),
          ),
      ],
    );
  }

  Widget _buildExperienceSection(List<dynamic> experiences) {
    if (experiences.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text("EMPLOYMENT HISTORY",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Divider(thickness: 1),
        for (var exp in experiences)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("\u25C9 ${exp["Job Title"] ?? ""}, ${exp["Company"] ?? ""}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                  "${exp["Start Date"] ?? ""} - ${exp["End Date"] ?? "Present"} | ${exp["Location"] ?? ""}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              for (var desc in exp["Description"] ?? [])
                Text("• $desc", style: TextStyle(fontSize: 14)),
              SizedBox(height: 8),
            ],
          ),
      ],
    );
  }

  List<String> _formatEducation(List<dynamic> education) {
    return education.map((edu) {
      return "${edu["Qualification"] ?? ""}, ${edu["Institution"] ?? ""} (${edu["Start Date"] ?? ""} - ${edu["Completion Date"] ?? ""})";
    }).toList();
  }

  List<String> _formatSkills(List<dynamic> skills) {
    return skills.map((skill) => "$skill").toList();
  }

  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildPdfHeader(userData["contactDetails"] ?? {}),
              _buildPdfSection("PROFILE", [userData["summary"] ?? ""]),
              _buildPdfExperience(userData["experience"] ?? []),
              _buildPdfSection(
                  "EDUCATION", _formatEducation(userData["education"] ?? [])),
              _buildPdfSection(
                  "SKILLS", _formatSkills(userData["skills"] ?? [])),
            ],
          );
        },
      ),
    );
    return pdf;
  }

  pw.Widget _buildPdfSection(String title, String content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title,
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.Text(content, textAlign: pw.TextAlign.justify),
        pw.Divider(thickness: 2),
      ],
    );
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> contact) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(contact["name"] ?? "Your Name",
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
        pw.Text(contact["title"] ?? "Your Title",
            style: pw.TextStyle(fontSize: 18, fontStyle: pw.FontStyle.italic)),
        pw.Text(
            "${contact["address"] ?? ""} | ${contact["phone"] ?? ""} | ${contact["email"] ?? ""}",
            style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
        pw.Divider(thickness: 2),
      ],
    );
  }

  pw.Widget _buildPdfExperience(List<dynamic> experiences) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: experiences.map((exp) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("\u25C9 ${exp["Job Title"] ?? ""}, ${exp["Company"] ?? ""}",
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.Text(
                "${exp["Start Date"] ?? ""} - ${exp["End Date"] ?? "Present"} | ${exp["Location"] ?? ""}",
                style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
            for (var desc in exp["Description"] ?? [])
              pw.Text("• $desc", style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 8),
          ],
        );
      }).toList(),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template2 extends StatelessWidget {
  final Map<String, dynamic> userData;

  Template2({required this.userData});

  @override
  Widget build(BuildContext context) {
    // Debugging: Print keys to verify available data
    print("🔥 Debug: Available User Data Keys - ${userData.keys.toList()}");
    print("🔥 Debug: Technical Skills - ${userData["technicalSkills"]}");
    print("🔥 Debug: Soft Skills - ${userData["softSkills"]}");
    print("🔥 Debug: Certifications - ${userData["certificates"]}");

    return Scaffold(
      appBar: AppBar(
        title: Text(userData["templateName"] ?? "Modern Resume"),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = await _generatePdf(userData);
              await Printing.layoutPdf(
                onLayout: (format) => pdf.save(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(userData["contactDetails"] ?? {}),
            _buildExperienceSection(userData["experience"] ?? []),
            _buildEducationSection(userData["education"] ?? []),
            _buildSkillsSection(userData["technicalSkills"] ?? [],
                userData["softSkills"] ?? []),
            _buildSection("AWARDS", userData["awards"] ?? []),
            _buildSection("CERTIFICATIONS", userData["certificates"] ?? []),
            _buildSection(
                "LANGUAGES", userData["contactDetails"]?["languages"] ?? []),
          ],
        ),
      ),
    );
  }

  // 🔹 Header Section
  Widget _buildHeaderSection(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          contactDetails["name"] ?? "Your Name",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          "${contactDetails["address"] ?? ""}\n${contactDetails["phone"] ?? ""} | ${contactDetails["email"] ?? ""}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
        Divider(thickness: 2),
      ],
    );
  }

  // 🔹 General Section Builder
  // 🔹 General Section Builder (Fix: Handle both String & List<String>)
  Widget _buildSection(String title, dynamic items) {
    if (items == null || (items is List && items.isEmpty)) return SizedBox();

    // Convert a single String into a List<String>
    List<String> formattedItems =
        (items is String) ? [items] : List<String>.from(items);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Divider(thickness: 1),
        for (var item in formattedItems)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text(item, style: TextStyle(fontSize: 14)),
          ),
      ],
    );
  }

  // 🔹 Skills Section (FIXED)
  // 🔹 Skills Section (Fix: Ensure technicalSkills & softSkills are Lists)
  Widget _buildSkillsSection(dynamic technicalSkills, dynamic softSkills) {
    List<String> formattedSkills = [];

    // Ensure both are Lists, otherwise convert
    List<String> techSkillsList = (technicalSkills is String)
        ? [technicalSkills]
        : List<String>.from(technicalSkills ?? []);
    List<String> softSkillsList = (softSkills is String)
        ? [softSkills]
        : List<String>.from(softSkills ?? []);

    if (techSkillsList.isNotEmpty) {
      formattedSkills.add("Technical Skills:");
      formattedSkills.addAll(techSkillsList.map((skill) => "• $skill"));
    }

    if (softSkillsList.isNotEmpty) {
      formattedSkills.add("Soft Skills:");
      formattedSkills.addAll(softSkillsList.map((skill) => "• $skill"));
    }

    if (formattedSkills.isEmpty) {
      print("⚠️ No skills found!");
      return SizedBox();
    }

    return _buildSection("SKILLS", formattedSkills);
  }

  // 🔹 PDF Generation
  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildPdfHeader(userData["contactDetails"] ?? {}),
              _buildPdfExperienceSection(userData["experience"] ?? []),
              _buildPdfEducationSection(userData["education"] ?? []),
              _buildPdfSkillsSection(userData["technicalSkills"] ?? [],
                  userData["softSkills"] ?? []),
              _buildPdfSection("AWARDS", userData["awards"] ?? []),
              _buildPdfSection(
                  "CERTIFICATIONS", userData["certificates"] ?? []),
              _buildPdfSection(
                  "LANGUAGES", userData["contactDetails"]?["languages"] ?? []),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfExperienceSection(List<dynamic> experiences) {
    if (experiences.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 16),
        pw.Text("EMPLOYMENT HISTORY",
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.Divider(thickness: 1),
        for (var exp in experiences)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                  "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}",
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Text(
                "${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"} | ${exp['Location'] ?? ""}",
                style:
                    pw.TextStyle(fontSize: 14, fontStyle: pw.FontStyle.italic),
              ),
              for (var desc in (exp['Description'] as List<dynamic>? ?? []))
                pw.Bullet(text: desc.toString()),
              pw.SizedBox(height: 8),
            ],
          ),
      ],
    );
  }

  // 🔹 PDF Education Section
  pw.Widget _buildPdfEducationSection(List<dynamic> educationList) {
    if (educationList.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 16),
        pw.Text("EDUCATION",
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.Divider(thickness: 1),
        for (var edu in educationList)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("${edu['Institution'] ?? "Institution Name"}",
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Text("${edu['Qualification'] ?? "Degree"}"),
              pw.Text(
                "${edu['Start Date'] ?? ""} - ${edu['Completion Date'] ?? ""} | ${edu['Location'] ?? ""}",
                style:
                    pw.TextStyle(fontSize: 14, fontStyle: pw.FontStyle.italic),
              ),
              pw.SizedBox(height: 8),
            ],
          ),
      ],
    );
  }
}

Widget _buildExperienceSection(List<dynamic> experiences) {
  if (experiences.isEmpty) return SizedBox();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      Text("EMPLOYMENT HISTORY",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      Divider(thickness: 1),
      for (var exp in experiences)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"} | ${exp['Location'] ?? ""}",
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            for (var desc in (exp['Description'] as List<dynamic>? ?? []))
              Text("• ${desc.toString()}"),
            SizedBox(height: 8),
          ],
        ),
    ],
  );
}

// 🔹 Education Section
Widget _buildEducationSection(List<dynamic> educationList) {
  if (educationList.isEmpty) return SizedBox();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      Text("EDUCATION",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      Divider(thickness: 1),
      for (var edu in educationList)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${edu['Institution'] ?? "Institution Name"}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("${edu['Qualification'] ?? "Degree"}"),
            Text(
              "${edu['Start Date'] ?? ""} - ${edu['Completion Date'] ?? ""} | ${edu['Location'] ?? ""}",
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8),
          ],
        ),
    ],
  );
}

// 🔹 PDF Skills Section (FIXED)
pw.Widget _buildPdfSkillsSection(
    List<dynamic> technicalSkills, List<dynamic> softSkills) {
  List<String> formattedSkills = [];

  if (technicalSkills.isNotEmpty) {
    formattedSkills.add("Technical Skills:");
    formattedSkills.addAll(technicalSkills.map((skill) => "• $skill"));
  }

  if (softSkills.isNotEmpty) {
    formattedSkills.add("Soft Skills:");
    formattedSkills.addAll(softSkills.map((skill) => "• $skill"));
  }

  if (formattedSkills.isEmpty) return pw.SizedBox();

  return _buildPdfSection("SKILLS", formattedSkills);
}

// 🔹 PDF Section Builder
pw.Widget _buildPdfSection(String title, dynamic items) {
  if (items == null || (items is List && items.isEmpty)) return pw.SizedBox();

  // Convert single String to List<String>
  List<String> formattedItems =
      (items is String) ? [items] : List<String>.from(items);

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.SizedBox(height: 16),
      pw.Text(title,
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
      pw.Divider(thickness: 1),
      for (var item in formattedItems)
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 4.0),
          child: pw.Text(item, style: pw.TextStyle(fontSize: 14)),
        ),
    ],
  );
}

// 🔹 PDF Header
pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    children: [
      pw.Text(contactDetails["name"] ?? "Your Name",
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
      pw.Text(
          "${contactDetails["address"] ?? ""}\n${contactDetails["phone"] ?? " "} | ${contactDetails["email"] ?? ""}",
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(fontSize: 14)),
      pw.Divider(thickness: 2),
    ],
  );
}
