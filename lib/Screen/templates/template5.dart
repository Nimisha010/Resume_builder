import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template5 extends StatelessWidget {
  final String userId;

  Template5({required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>?;

        if (userData == null || userData.isEmpty) {
          return Center(child: Text("No Data Available"));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(userData["templateName"] ?? "Column Resume"),
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column (Main Content)
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(userData["contactDetails"] ?? {}),
                        _buildSection("Experience",
                            _formatList(userData["experience"] ?? [])),
                        _buildSection("Projects",
                            _formatList(userData["projects"] ?? [])),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  // Right Column (Contact, Skills, Education)
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildOptionalSection("Contact",
                            _formatContact(userData["contactDetails"] ?? {})),
                        _buildOptionalSection(
                            "Skills", _formatList(userData["skills"] ?? [])),
                        _buildOptionalSection("Education",
                            _formatList(userData["education"] ?? [])),
                        _buildOptionalSection("Awards & Certificates",
                            _formatList(userData["certificates"] ?? [])),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // PDF Generation
  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: pw.EdgeInsets.all(16.0),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Left Column (Main Content)
                pw.Expanded(
                  flex: 2,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildPdfHeader(userData["contactDetails"] ?? {}),
                      _buildOptionalPdfSection("Experience",
                          _formatList(userData["experience"] ?? [])),
                      _buildOptionalPdfSection(
                          "Projects", _formatList(userData["projects"] ?? [])),
                    ],
                  ),
                ),
                pw.SizedBox(width: 20),
                // Right Column (Contact, Skills, Education)
                pw.Expanded(
                  flex: 1,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildOptionalPdfSection("Contact",
                          _formatContact(userData["contactDetails"] ?? {})),
                      _buildOptionalPdfSection(
                          "Skills", _formatList(userData["skills"] ?? [])),
                      _buildOptionalPdfSection("Education",
                          _formatList(userData["education"] ?? [])),
                      _buildOptionalPdfSection("Awards & Certificates",
                          _formatList(userData["certificates"] ?? [])),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    return pdf;
  }

  Widget _buildOptionalSection(String title, List<String> items) {
    if (items.isEmpty) return SizedBox();
    return _buildSection(title, items);
  }

  pw.Widget _buildOptionalPdfSection(String title, List<String> items) {
    if (items.isEmpty) return pw.SizedBox();
    return _buildPdfSection(title, items);
  }

  pw.Widget _buildPdfSection(String title, List<String> items) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title,
              style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.purple900)),
          pw.SizedBox(height: 5),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: items
                .map((item) => pw.Text(item, style: pw.TextStyle(fontSize: 14)))
                .toList(),
          ),
        ],
      ),
    );
  }

  // UI Header Section
  Widget _buildHeader(Map<String, dynamic> contactDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          contactDetails["name"] ?? "Your Name",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple[900]),
        ),
        if ((contactDetails["title"] ?? "").isNotEmpty) ...[
          SizedBox(height: 5),
          Text(contactDetails["title"] ?? ""),
        ],
        SizedBox(height: 10),
        Divider(thickness: 2),
      ],
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[900])),
          SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .map((item) => Text(item, style: TextStyle(fontSize: 14)))
                .toList(),
          ),
        ],
      ),
    );
  }

  // PDF Header Section
  pw.Widget _buildPdfHeader(Map<String, dynamic> contactDetails) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          contactDetails["name"] ?? "Your Name",
          style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.purple900),
        ),
        if ((contactDetails["title"] ?? "").isNotEmpty) ...[
          pw.SizedBox(height: 5),
          pw.Text(contactDetails["title"] ?? ""),
        ],
        pw.SizedBox(height: 10),
        pw.Divider(thickness: 2),
      ],
    );
  }

  // Contact Details Formatter in Correct Order
  List<String> _formatContact(Map<String, dynamic> contactDetails) {
    return [
      if (contactDetails["phone"] != null) "📞 ${contactDetails["phone"]}",
      if (contactDetails["email"] != null) "✉️ ${contactDetails["email"]}",
      if (contactDetails["linkedin"] != null)
        "🔗 LinkedIn: ${contactDetails["linkedin"]}",
      if (contactDetails["github"] != null)
        "💻 GitHub: ${contactDetails["github"]}",
      if (contactDetails["website"] != null)
        "🌍 Website: ${contactDetails["website"]}",
      if (contactDetails["address"] != null) "📍 ${contactDetails["address"]}",
    ];
  }

  // Utility: Convert List<dynamic> to List<String>
  List<String> _formatList(dynamic data) {
    if (data is List) {
      return data
          .where((e) => e != null && e.toString().isNotEmpty)
          .map((e) => e.toString())
          .toList();
    }
    return [];
  }
}
