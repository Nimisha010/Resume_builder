/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template6 extends StatelessWidget {
  final String userId;

  Template6({required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        if (userData == null) {
          return Center(child: Text("No Data Available"));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("Professional Resume"),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(userData),
                  _buildSection("Summary", userData["summary"] ?? ""),
                  _buildSection(
                      "Contact Details", userData["contactDetails"] ?? {}),
                  _buildExperienceSection(userData["experience"] ?? []),
                  _buildSection("Education", userData["education"] ?? []),
                  _buildSection("Projects", userData["projects"] ?? []),
                  _buildSection("Awards", userData["awards"] ?? []),
                  _buildSection("Certificates", userData["certificates"] ?? []),
                  _buildSection(
                      "Technical Skills", userData["technicalSkills"] ?? []),
                  _buildSection("Soft Skills", userData["softSkills"] ?? []),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(Map<String, dynamic> userData) {
    final contactDetails = userData["contactDetails"] ?? {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                contactDetails["name"] ?? "Your Name",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
          ],
        ),
        SizedBox(height: 5),
        Text(contactDetails["email"] ?? ""),
        Text(contactDetails["phone"] ?? ""),
        Text(contactDetails["address"] ?? ""),
        Divider(thickness: 2),
      ],
    );
  }

  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();
    final contactDetails = userData["contactDetails"] ?? {};
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildPdfHeader(userData), // Updated PDF header
                pw.SizedBox(height: 5),
                _buildPdfSection("Summary", userData["summary"] ?? ""),
                _buildPdfSection("Contact Details", contactDetails),
                _buildPdfExperienceSection(userData["experience"] ?? []),
                _buildPdfSection("Education", userData["education"] ?? []),
                _buildPdfSection("Projects", userData["projects"] ?? []),
                _buildPdfSection("Awards", userData["awards"] ?? []),
                _buildPdfSection(
                    "Certificates", userData["certificates"] ?? []),
                _buildPdfSection(
                    "Technical Skills", userData["technicalSkills"] ?? []),
                _buildPdfSection("Soft Skills", userData["softSkills"] ?? []),
              ],
            ),
          );
        },
      ),
    );
    return pdf;
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> userData) {
    final contactDetails = userData["contactDetails"] ?? {};
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Row(
          children: [
            pw.Expanded(
                child: pw.Divider(color: PdfColors.grey300, thickness: 1)),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 8.0),
              child: pw.Text(
                userData["Name"] ?? "Your Name",
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Expanded(
                child: pw.Divider(color: PdfColors.grey300, thickness: 1)),
          ],
        ),
        pw.SizedBox(height: 5),
        pw.Text(contactDetails["email"] ?? ""),
        pw.Text(contactDetails["phone"] ?? ""),
        pw.Text(contactDetails["address"] ?? ""),
        pw.Divider(thickness: 2),
      ],
    );
  }

  Widget _buildSection(String title, dynamic content) {
    if (content is List) {
      content = content.join("\n"); // Convert list to string
    } else if (content is Map<String, dynamic>) {
      content = content.entries
          .map((e) => "${e.key}: ${e.value}")
          .join("\n"); // Convert map to formatted string
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Divider(color: Colors.grey.shade400, thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: Divider(color: Colors.grey.shade400, thickness: 1)),
            ],
          ),
          SizedBox(height: 5),
          Text(content ?? "", style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(List<dynamic> experiences) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: experiences.map((exp) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(exp["Job Title"] ?? "",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(exp["Company"] ?? ""),
              Text("${exp["Start Date"]} - ${exp["End Date"]}"),
              SizedBox(height: 5),
            ],
          ),
        );
      }).toList(),
    );
  }

  pw.Widget _buildPdfSection(String title, dynamic content) {
    if (content is List) {
      content = content.join("\n");
    } else if (content is Map<String, dynamic>) {
      content = content.entries.map((e) => "${e.key}: ${e.value}").join("\n");
    }

    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Expanded(
                  child: pw.Divider(color: PdfColors.grey300, thickness: 1)),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 8.0),
                child: pw.Text(
                  title,
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Expanded(
                  child: pw.Divider(color: PdfColors.grey300, thickness: 1)),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Text(content ?? "", style: pw.TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  pw.Widget _buildPdfExperienceSection(List<dynamic> experiences) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: experiences.map((exp) {
        return pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 8.0),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(exp["Job Title"] ?? "",
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Text(exp["Company"] ?? ""),
              pw.Text("${exp["Start Date"]} - ${exp["End Date"]}"),
              pw.SizedBox(height: 5),
            ],
          ),
        );
      }).toList(),
    );
  }
}
*/
/* correct one

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template6 extends StatelessWidget {
  final String userId;

  Template6({required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>?;

        if (userData == null) {
          return Center(child: Text("No Data Available"));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("Professional Resume"),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(userData),
                  _buildContactSection(userData["contactDetails"] ?? {}),
                  _buildExperienceSection(userData["experience"] ?? []),
                  _buildSection("Education", userData["education"] ?? []),
                  _buildSection("Projects", userData["projects"] ?? []),
                  _buildSection("Awards", userData["awards"] ?? []),
                  _buildSection("Certificates", userData["certificates"] ?? []),
                  _buildSection(
                      "Technical Skills", userData["technicalSkills"] ?? []),
                  _buildSection("Soft Skills", userData["softSkills"] ?? []),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Corrected Header with Name fetching
  Widget _buildHeader(Map<String, dynamic> userData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                userData["contactDetails"]?["name"] ?? "Your Name",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
          ],
        ),
        Divider(thickness: 2),
      ],
    );
  }

  // Contact Details - Show only if available
  Widget _buildContactSection(Map<String, dynamic> contactDetails) {
    List<Widget> contactWidgets = [];

    if (contactDetails["email"] != null && contactDetails["email"].isNotEmpty) {
      contactWidgets.add(Text("Email: ${contactDetails["email"]}"));
    }
    if (contactDetails["phone"] != null && contactDetails["phone"].isNotEmpty) {
      contactWidgets.add(Text("Phone: ${contactDetails["phone"]}"));
    }
    if (contactDetails["address"] != null &&
        contactDetails["address"].isNotEmpty) {
      contactWidgets.add(Text("Address: ${contactDetails["address"]}"));
    }

    return contactWidgets.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Contact Details"),
              ...contactWidgets,
              SizedBox(height: 10),
            ],
          )
        : SizedBox.shrink();
  }

  // Experience Section - Adds Heading Explicitly
  Widget _buildExperienceSection(List<dynamic> experiences) {
    if (experiences.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Experience"),
        ...experiences.map((exp) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exp["Job Title"] ?? "",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(exp["Company"] ?? ""),
                  Text("${exp["Start Date"]} - ${exp["End Date"]}"),
                ],
              ),
            )),
      ],
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
            padding: pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildPdfHeader(userData),
                pw.SizedBox(height: 10),
                _buildPdfContactSection(userData["contactDetails"] ?? {}),
                _buildPdfExperienceSection(userData["experience"] ?? []),
                _buildPdfSection("Education", userData["education"] ?? []),
                _buildPdfSection("Projects", userData["projects"] ?? []),
                _buildPdfSection("Awards", userData["awards"] ?? []),
                _buildPdfSection(
                    "Certificates", userData["certificates"] ?? []),
                _buildPdfSection(
                    "Technical Skills", userData["technicalSkills"] ?? []),
                _buildPdfSection("Soft Skills", userData["softSkills"] ?? []),
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }

  // PDF Header with Corrected Name
  pw.Widget _buildPdfHeader(Map<String, dynamic> userData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          userData["contactDetails"]?["name"] ?? "Your Name",
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.Divider(thickness: 2),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
        ],
      ),
    );
  }

  // Section Title for PDF
  pw.Widget _buildPdfSectionTitle(String title) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(top: 10, bottom: 5),
      child: pw.Row(
        children: [
          pw.Expanded(
              child: pw.Divider(color: PdfColors.grey300, thickness: 1)),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(horizontal: 8.0),
            child: pw.Text(
              title,
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(
              child: pw.Divider(color: PdfColors.grey300, thickness: 1)),
        ],
      ),
    );
  }

  // PDF Contact Section - Hides Empty Fields
  pw.Widget _buildPdfContactSection(Map<String, dynamic> contactDetails) {
    List<pw.Widget> contactWidgets = [];

    if (contactDetails["email"] != null && contactDetails["email"].isNotEmpty) {
      contactWidgets.add(pw.Text("Email: ${contactDetails["email"]}"));
    }
    if (contactDetails["phone"] != null && contactDetails["phone"].isNotEmpty) {
      contactWidgets.add(pw.Text("Phone: ${contactDetails["phone"]}"));
    }
    if (contactDetails["address"] != null &&
        contactDetails["address"].isNotEmpty) {
      contactWidgets.add(pw.Text("Address: ${contactDetails["address"]}"));
    }

    return contactWidgets.isNotEmpty
        ? pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildPdfSectionTitle("Contact Details"),
              ...contactWidgets,
              pw.SizedBox(height: 10),
            ],
          )
        : pw.SizedBox();
  }

  Widget _buildSection(String title, dynamic content) {
    if (content is List) {
      content = content.join("\n"); // Convert list to string
    } else if (content is Map<String, dynamic>) {
      content = content.entries
          .map((e) => "${e.key}: ${e.value}")
          .join("\n"); // Convert map to formatted string
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Divider(color: Colors.grey.shade400, thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: Divider(color: Colors.grey.shade400, thickness: 1)),
            ],
          ),
          SizedBox(height: 5),
          Text(content ?? "", style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  pw.Widget _buildPdfSection(String title, dynamic content) {
    if (content is List) {
      content = content.join("\n");
    } else if (content is Map<String, dynamic>) {
      content = content.entries.map((e) => "${e.key}: ${e.value}").join("\n");
    }

    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Expanded(
                  child: pw.Divider(color: PdfColors.grey300, thickness: 1)),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 8.0),
                child: pw.Text(
                  title,
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Expanded(
                  child: pw.Divider(color: PdfColors.grey300, thickness: 1)),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Text(content ?? "", style: pw.TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  // PDF Experience Section
  pw.Widget _buildPdfExperienceSection(List<dynamic> experiences) {
    if (experiences.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildPdfSectionTitle("Experience"),
        ...experiences.map((exp) => pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 8.0),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(exp["Job Title"] ?? "",
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  pw.Text(exp["Company"] ?? ""),
                  pw.Text("${exp["Start Date"]} - ${exp["End Date"]}"),
                ],
              ),
            )),
      ],
    );
  }
}
*/
/* correct one*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Template6 extends StatelessWidget {
  final String userId;

  Template6({required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>?;

        if (userData == null) {
          return Center(child: Text("No Data Available"));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("Professional Resume"),
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
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(userData),
                  _buildContactSection(userData["contactDetails"] ?? {}),
                  _buildExperienceSection(userData["experience"] ?? []),
                  _buildSection("Education", userData["education"] ?? []),
                  _buildSection("Projects", userData["projects"] ?? []),
                  _buildSection("Awards", userData["awards"] ?? []),
                  _buildSection("Certificates", userData["certificates"] ?? []),
                  _buildSection(
                      "Technical Skills", userData["technicalSkills"] ?? []),
                  _buildSection("Soft Skills", userData["softSkills"] ?? []),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(Map<String, dynamic> userData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                userData["contactDetails"]?["name"] ?? "Your Name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
          ],
        ),
        Divider(thickness: 2),
      ],
    );
  }

  Widget _buildContactSection(Map<String, dynamic> contactDetails) {
    List<Widget> contactWidgets = [];

    if (contactDetails["email"] != null && contactDetails["email"].isNotEmpty) {
      contactWidgets.add(Text("Email: ${contactDetails["email"]}"));
    }
    if (contactDetails["phone"] != null && contactDetails["phone"].isNotEmpty) {
      contactWidgets.add(Text("Phone: ${contactDetails["phone"]}"));
    }
    if (contactDetails["address"] != null &&
        contactDetails["address"].isNotEmpty) {
      contactWidgets.add(Text("Address: ${contactDetails["address"]}"));
    }

    return contactWidgets.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Contact Details"),
              ...contactWidgets,
              SizedBox(height: 6),
            ],
          )
        : SizedBox.shrink();
  }

  Widget _buildExperienceSection(List<dynamic> experiences) {
    if (experiences.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Experience"),
        ...experiences.map((exp) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exp["Job Title"] ?? "",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(exp["Company"] ?? ""),
                  Text("${exp["Start Date"]} - ${exp["End Date"]}"),
                  if (exp["Description"] != null)
                    Text(exp["Description"] ?? "",
                        style: TextStyle(fontSize: 10)),
                ],
              ),
            )),
      ],
    );
  }

  Future<pw.Document> _generatePdf(Map<String, dynamic> userData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: pw.EdgeInsets.all(12), // Reduced padding
            child: pw.Column(
              crossAxisAlignment:
                  pw.CrossAxisAlignment.start, // Left-align all content
              children: [
                _buildPdfHeader(userData),
                pw.SizedBox(height: 8),
                _buildPdfContactSection(userData["contactDetails"] ?? {}),
                _buildPdfExperienceSection(userData["experience"] ?? []),
                _buildPdfSection("Education", userData["education"] ?? []),
                _buildPdfSection("Projects", userData["projects"] ?? []),
                _buildPdfSection("Awards", userData["awards"] ?? []),
                _buildPdfSection(
                    "Certificates", userData["certificates"] ?? []),
                _buildPdfSection(
                    "Technical Skills", userData["technicalSkills"] ?? []),
                _buildPdfSection("Soft Skills", userData["softSkills"] ?? []),
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfHeader(Map<String, dynamic> userData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center, // Center-align header
      children: [
        pw.Text(
          userData["contactDetails"]?["name"] ?? "Your Name",
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.Divider(thickness: 2),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
        ],
      ),
    );
  }

  pw.Widget _buildPdfSectionTitle(String title) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(top: 5, bottom: 5),
      child: pw.Row(
        children: [
          pw.Expanded(
              child: pw.Divider(color: PdfColors.grey300, thickness: 1)),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(horizontal: 6.0),
            child: pw.Text(
              title,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(
              child: pw.Divider(color: PdfColors.grey300, thickness: 1)),
        ],
      ),
    );
  }

  pw.Widget _buildPdfContactSection(Map<String, dynamic> contactDetails) {
    List<pw.Widget> contactWidgets = [];

    if (contactDetails["email"] != null && contactDetails["email"].isNotEmpty) {
      contactWidgets.add(pw.Text("Email: ${contactDetails["email"]}"));
    }
    if (contactDetails["phone"] != null && contactDetails["phone"].isNotEmpty) {
      contactWidgets.add(pw.Text("Phone: ${contactDetails["phone"]}"));
    }
    if (contactDetails["address"] != null &&
        contactDetails["address"].isNotEmpty) {
      contactWidgets.add(pw.Text("Address: ${contactDetails["address"]}"));
    }

    return contactWidgets.isNotEmpty
        ? pw.Column(
            crossAxisAlignment:
                pw.CrossAxisAlignment.start, // Left-align content
            children: [
              _buildPdfSectionTitle("Contact Details"),
              ...contactWidgets,
              pw.SizedBox(height: 8),
            ],
          )
        : pw.SizedBox();
  }

  Widget _buildSection(String title, dynamic content) {
    if (content is List) {
      content = content.join("\n");
    } else if (content is Map<String, dynamic>) {
      content = content.entries.map((e) => "${e.key}: ${e.value}").join("\n");
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Divider(color: Colors.grey.shade400, thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: Divider(color: Colors.grey.shade400, thickness: 1)),
            ],
          ),
          SizedBox(height: 5),
          Text(content ?? "", style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  pw.Widget _buildPdfSection(String title, dynamic content) {
    if (content is List) {
      content = content.join("\n");
    } else if (content is Map<String, dynamic>) {
      content = content.entries.map((e) => "${e.key}: ${e.value}").join("\n");
    }

    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start, // Left-align content
        children: [
          // Center-align the heading
          pw.Row(
            mainAxisAlignment:
                pw.MainAxisAlignment.center, // Center-align heading
            children: [
              pw.Text(
                title,
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Text(content ?? "", style: pw.TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  pw.Widget _buildPdfExperienceSection(List<dynamic> experiences) {
    if (experiences.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start, // Left-align content
      children: [
        // Center-align the heading
        pw.Row(
          mainAxisAlignment:
              pw.MainAxisAlignment.center, // Center-align heading
          children: [
            pw.Text(
              "Experience",
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
        ...experiences.map((exp) => pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 6.0),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(exp["Job Title"] ?? "",
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  pw.Text(exp["Company"] ?? ""),
                  pw.Text("${exp["Start Date"]} - ${exp["End Date"]}"),
                  if (exp["Description"] != null)
                    pw.Text(exp["Description"] ?? "",
                        style: pw.TextStyle(fontSize: 10)),
                ],
              ),
            )),
      ],
    );
  }
}
