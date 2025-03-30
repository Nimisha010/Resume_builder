// Summary Section
/* _buildSection("SUMMARY", [
                  "Analytical, Highly motivated and adaptable professional with a strong track record of problem-solving, teamwork, and delivering quality results. Skilled in managing tasks efficiently, learning new technologies quickly, and contributing to innovative solutions.",
                ]),
*/
/* correct code classic resume

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template1 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template1({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Classic Resume"),
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
              /*_buildPdfSection("SUMMARY", [
                "Analytical, organized and detail-oriented accountant with GAAP expertise and experience in the full spectrum of public accounting. Collaborative team player with ownership mentality and a track record of delivering the highest quality strategic solutions to resolve challenges and propel business growth.",
              ]),
*/
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
/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template1 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template1({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Classic Resume"),
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
    );
  }

  // 🎨 Generate PDF with Dynamic Font Size
  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();

    int contentLength = userData.toString().length; // Estimate content size
    double fontSize =
        contentLength > 1200 ? 10 : (contentLength > 800 ? 12 : 14);
    double titleFontSize = fontSize + 4;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildPdfHeaderSection(
                  userData["contactDetails"] ?? {}, titleFontSize),
              _buildPdfSection(
                  "EXPERIENCE", userData["experience"] ?? [], fontSize),
              _buildPdfSection(
                  "EDUCATION", userData["education"] ?? [], fontSize),
              _buildPdfSection(
                  "SKILLS",
                  [
                    "Technical: ${(userData["technicalSkills"] ?? []).join(", ")}",
                    "Soft: ${(userData["softSkills"] ?? []).join(", ")}",
                  ],
                  fontSize),
              _buildPdfSection(
                  "PROJECTS", userData["projects"] ?? [], fontSize),
              _buildPdfSection(
                  "AWARDS & CERTIFICATES", userData["awards"] ?? [], fontSize),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  // 🎨 PDF Header Section
  pw.Widget _buildPdfHeaderSection(
      Map<String, dynamic> contactDetails, double titleFontSize) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          contactDetails["name"] ?? "No Name",
          style: pw.TextStyle(
              fontSize: titleFontSize, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          "${contactDetails["address"] ?? "No Address"} | "
          "${contactDetails["phone"] ?? "Not Provided"} | "
          "${contactDetails["email"] ?? "Not Provided"}",
          style: pw.TextStyle(
              fontSize: titleFontSize - 4, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  // 🎨 PDF Section Builder with Dynamic Font Size
  pw.Widget _buildPdfSection(
      String title, List<dynamic> items, double fontSize) {
    if (items.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(thickness: 2, color: PdfColors.black),
        pw.SizedBox(height: 8),
        pw.Text(
          title,
          style: pw.TextStyle(
              fontSize: fontSize + 2, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              item.toString(),
              style: pw.TextStyle(fontSize: fontSize),
            ),
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }
}
*/

/*agnes
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template1 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template1({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Classic Resume"),
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
              _buildPdfDivider(),
              _buildPdfSection("EXPERIENCE", userData["experience"] ?? []),
              _buildPdfDivider(),
              _buildPdfSection("EDUCATION", userData["education"] ?? []),
              _buildPdfDivider(),
              _buildPdfSection("SKILLS", [
                "Technical Skills: ${(userData["technicalSkills"] ?? []).join(", ")}",
                "Soft Skills: ${(userData["softSkills"] ?? []).join(", ")}",
              ]),
              _buildPdfDivider(),
              _buildPdfSection("PROJECTS", userData["projects"] ?? []),
              _buildPdfDivider(),
              _buildPdfSection("AWARDS & CERTIFICATES", [
                ...?userData["awards"]?.map((award) => "• $award"),
                ...?userData["certificates"]?.map((cert) => "• $cert"),
              ]),
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

  pw.Widget _buildPdfSection(String title, List<dynamic> items) {
    if (items.isEmpty) return pw.SizedBox();
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
            child: pw.Text("• $item", style: pw.TextStyle(fontSize: 12)),
          ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildPdfDivider() {
    return pw.Divider(thickness: 2, color: PdfColors.black);
  }
}
*/

/* correct one

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template1 extends StatelessWidget {
  final Map<String, dynamic> userId;

  Template1({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId["templateName"] ?? "Classic Resume"),
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

                // Experience Section
                _buildSection("EXPERIENCE", [
                  for (var exp in userId["experience"] ?? [])
                    "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}\n"
                        "  ${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"}\n"
                        "  ${exp['Description'] ?? "No description provided."}\n",
                ]),

                // Education Section
                _buildSection("EDUCATION", [
                  for (var edu in userId["education"] ?? [])
                    "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}\n"
                        "  ${edu['Completion Date'] ?? "Not Provided"}\n",
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
                        "  Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n",
                ]),

                // Awards & Certificates Section
                _buildSection("AWARDS & CERTIFICATES", [
                  for (var award in userId["awards"] ?? []) "$award",
                  for (var cert in userId["certificates"] ?? []) "$cert",
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

              // Experience Section
              if ((userData["experience"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(), // Add a line separator
                _buildPdfSection("EXPERIENCE", [
                  for (var exp in userData["experience"] ?? [])
                    "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}\n"
                        "  ${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"}\n"
                        "  ${exp['Description'] ?? "No description provided."}\n",
                ]),
              ],

              // Education Section
              if ((userData["education"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(), // Add a line separator
                _buildPdfSection("EDUCATION", [
                  for (var edu in userData["education"] ?? [])
                    "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}\n"
                        "  ${edu['Completion Date'] ?? "Not Provided"}\n",
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
                        "  Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n",
                ]),
              ],

              // Awards & Certificates Section
              if ((userData["awards"] ?? []).isNotEmpty ||
                  (userData["certificates"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(), // Add a line separator
                _buildPdfSection("AWARDS & CERTIFICATES", [
                  for (var award in userData["awards"] ?? []) "$award",
                  for (var cert in userData["certificates"] ?? []) "$cert",
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
          style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
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
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              item,
              style: pw.TextStyle(fontSize: 10), // Smaller font size for PDF
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

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Template1 extends StatefulWidget {
  final Map<String, dynamic> userId;

  Template1({required this.userId});

  @override
  _Template1State createState() => _Template1State();
}

class _Template1State extends State<Template1> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userId["templateName"] ?? "Classic Resume"),
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
                width: 595, // A4 width in pixels (595px ≈ 210mm)
                height: 842, // A4 height in pixels (842px ≈ 297mm)
                padding:
                    const EdgeInsets.all(40), // Add padding to simulate margins
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black,
                      width: 1), // Add border for A4 simulation
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      _buildHeaderSection(
                          widget.userId["contactDetails"] ?? {}),

                      // Summary Section
                      if (_summary.isNotEmpty)
                        _buildSection("SUMMARY", [_summary]),

                      // Experience Section
                      _buildSection("EXPERIENCE", [
                        for (var exp in widget.userId["experience"] ?? [])
                          "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}\n"
                              "  ${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"}\n"
                              "  ${exp['Description'] ?? "No description provided."}\n",
                      ]),

                      // Education Section
                      _buildSection("EDUCATION", [
                        for (var edu in widget.userId["education"] ?? [])
                          "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}\n"
                              "  ${edu['Completion Date'] ?? "Not Provided"}\n",
                      ]),

                      // Skills Section
                      _buildSection("SKILLS", [
                        "Technical Skills: ${(widget.userId["technicalSkills"] ?? []).join(", ")}",
                        "Soft Skills: ${(widget.userId["softSkills"] ?? []).join(", ")}",
                      ]),

                      // Projects Section
                      _buildSection("PROJECTS", [
                        for (var proj in widget.userId["projects"] ?? [])
                          "${proj['title'] ?? "Not Provided"} | ${proj['role'] ?? "Not Provided"}\n"
                              "  Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n",
                      ]),

                      // Awards & Certificates Section
                      _buildSection("AWARDS & CERTIFICATES", [
                        for (var award in widget.userId["awards"] ?? [])
                          "$award",
                        for (var cert in widget.userId["certificates"] ?? [])
                          "$cert",
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
        SizedBox(height: 10), // Add extra space after each section
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
              if (_summary.isNotEmpty) ...[
                _buildPdfDivider(), // Add a line separator
                _buildPdfSection("SUMMARY", [_summary]),
              ],

              // Experience Section
              if ((userData["experience"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(), // Add a line separator
                _buildPdfSection("EXPERIENCE", [
                  for (var exp in userData["experience"] ?? [])
                    "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}\n"
                        "  ${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"}\n"
                        "  ${exp['Description'] ?? "No description provided."}\n",
                ]),
              ],

              // Education Section
              if ((userData["education"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(), // Add a line separator
                _buildPdfSection("EDUCATION", [
                  for (var edu in userData["education"] ?? [])
                    "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}\n"
                        "  ${edu['Completion Date'] ?? "Not Provided"}\n",
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
                        "  Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n",
                ]),
              ],

              // Awards & Certificates Section
              if ((userData["awards"] ?? []).isNotEmpty ||
                  (userData["certificates"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(), // Add a line separator
                _buildPdfSection("AWARDS & CERTIFICATES", [
                  for (var award in userData["awards"] ?? []) "$award",
                  for (var cert in userData["certificates"] ?? []) "$cert",
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
          style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 10),
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
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        for (var item in items)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              item,
              style: pw.TextStyle(fontSize: 10), // Smaller font size for PDF
            ),
          ),
        pw.SizedBox(height: 10), // Add extra space after each section
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
