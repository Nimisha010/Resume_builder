/*import 'package:flutter/material.dart';
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
*/

/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Template1 extends StatefulWidget {
  final Map<String, dynamic> userId;
  final bool includeAISuggestions;

  const Template1({
    Key? key,
    required this.userId,
    this.includeAISuggestions = false,
  }) : super(key: key);

  @override
  _Template1State createState() => _Template1State();
}

class _Template1State extends State<Template1> {
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

    if (widget.includeAISuggestions && contentItem['is_ai_generated'] == true) {
      return contentItem['content']?.toString() ?? '';
    }
    return contentItem['original_content']?.toString() ??
        contentItem['content']?.toString() ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userId["templateName"] ?? "Classic Resume"),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
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
          ? const Center(child: CircularProgressIndicator())
          : Center(
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
                      _buildHeaderSection(
                          widget.userId["contactDetails"] ?? {}),
                      if (_summary.isNotEmpty)
                        _buildSection("SUMMARY", [_summary]),
                      _buildSection("EXPERIENCE", [
                        for (var exp in widget.userId["experience"] ?? [])
                          "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}\n"
                              "  ${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"}\n"
                              "  ${_getContent(exp['Description'] ?? exp['content'] ?? "No description provided.")}\n",
                      ]),
                      _buildSection("EDUCATION", [
                        for (var edu in widget.userId["education"] ?? [])
                          "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}\n"
                              "  ${edu['Completion Date'] ?? "Not Provided"}\n"
                              "  ${_getContent(edu['Description'] ?? edu['content'] ?? "")}\n",
                      ]),
                      _buildSection("SKILLS", [
                        "Technical Skills: ${(widget.userId["technicalSkills"] ?? []).map((skill) => _getContent(skill)).join(", ")}",
                        if ((widget.userId["softSkills"] ?? []).isNotEmpty)
                          "Soft Skills: ${(widget.userId["softSkills"] ?? []).join(", ")}",
                      ]),
                      _buildSection("PROJECTS", [
                        for (var proj in widget.userId["projects"] ?? [])
                          "${proj['title'] ?? "Not Provided"} | ${proj['role'] ?? "Not Provided"}\n"
                              "  Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n"
                              "  ${_getContent(proj['description'] ?? proj['content'] ?? "")}\n",
                      ]),
                      _buildSection("AWARDS & CERTIFICATES", [
                        for (var award in widget.userId["awards"] ?? [])
                          _getContent(award),
                        for (var cert in widget.userId["certificates"] ?? [])
                          _getContent(cert),
                      ]),
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
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          "${contactDetails["address"] ?? "No Address"} | "
          "${contactDetails["phone"] ?? "Not Provided"} | "
          "${contactDetails["email"] ?? "Not Provided"}",
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty || items.every((item) => item.trim().isEmpty)) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 2, color: Colors.black),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        for (var item in items.where((item) => item.trim().isNotEmpty))
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              item,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        const SizedBox(height: 10),
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
              if (_summary.isNotEmpty) ...[
                _buildPdfDivider(),
                _buildPdfSection("SUMMARY", [_summary]),
              ],
              if ((userData["experience"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(),
                _buildPdfSection("EXPERIENCE", [
                  for (var exp in userData["experience"] ?? [])
                    "${exp['Job Title'] ?? "Not Provided"} | ${exp['Company'] ?? "Not Provided"}\n"
                        "  ${exp['Start Date'] ?? "Not Provided"} - ${exp['End Date'] ?? "Present"}\n"
                        "  ${_getContent(exp['Description'] ?? exp['content'] ?? "No description provided.")}\n",
                ]),
              ],
              if ((userData["education"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(),
                _buildPdfSection("EDUCATION", [
                  for (var edu in userData["education"] ?? [])
                    "${edu['Qualification'] ?? "Not Provided"} | ${edu['Institution'] ?? "Not Provided"}\n"
                        "  ${edu['Completion Date'] ?? "Not Provided"}\n"
                        "  ${_getContent(edu['Description'] ?? edu['content'] ?? "")}\n",
                ]),
              ],
              if ((userData["technicalSkills"] ?? []).isNotEmpty ||
                  (userData["softSkills"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(),
                _buildPdfSection("SKILLS", [
                  if ((userData["technicalSkills"] ?? []).isNotEmpty)
                    "Technical Skills: ${(userData["technicalSkills"] ?? []).map((skill) => _getContent(skill)).join(", ")}",
                  if ((userData["softSkills"] ?? []).isNotEmpty)
                    "Soft Skills: ${(userData["softSkills"] ?? []).join(", ")}",
                ]),
              ],
              if ((userData["projects"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(),
                _buildPdfSection("PROJECTS", [
                  for (var proj in userData["projects"] ?? [])
                    "${proj['title'] ?? "Not Provided"} | ${proj['role'] ?? "Not Provided"}\n"
                        "  Technologies: ${proj['technologies']?.join(", ") ?? "Not Provided"}\n"
                        "  ${_getContent(proj['description'] ?? proj['content'] ?? "")}\n",
                ]),
              ],
              if ((userData["awards"] ?? []).isNotEmpty ||
                  (userData["certificates"] ?? []).isNotEmpty) ...[
                _buildPdfDivider(),
                _buildPdfSection("AWARDS & CERTIFICATES", [
                  for (var award in userData["awards"] ?? [])
                    _getContent(award),
                  for (var cert in userData["certificates"] ?? [])
                    _getContent(cert),
                ]),
              ],
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
          style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 10),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, List<String> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        for (var item in items.where((item) => item.trim().isNotEmpty))
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              item,
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
        pw.SizedBox(height: 10),
      ],
    );
  }

  pw.Widget _buildPdfDivider() {
    return pw.Divider(
      thickness: 2,
      color: PdfColors.black,
    );
  }
}
*/

// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Template1 extends StatefulWidget {
//   final String templateName;
//   final Map<String, dynamic> userId;
//   final bool includeAISuggestions;

//   const Template1({
//     Key? key,
//     required this.templateName,
//     required this.userId,
//     this.includeAISuggestions = false,
//   }) : super(key: key);

//   @override
//   _Template1State createState() => _Template1State();
// }

// class _Template1State extends State<Template1> {
//   String _summary = '';
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchSummary();
//   }

//   Future<void> _fetchSummary() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }

//     final firestore = FirebaseFirestore.instance;
//     final doc = await firestore.collection('users').doc(user.uid).get();

//     if (doc.exists) {
//       final data = doc.data()!;
//       setState(() {
//         _summary = data['selected_summary'] ?? 'No summary available';
//         _isLoading = false;
//       });
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   String _getContent(dynamic item) {
//     if (item is String) return item;

//     final Map<String, dynamic> contentItem = (item is Map
//         ? Map<String, dynamic>.from(item)
//         : {'content': item.toString()});

//     if (contentItem['is_ai_generated'] == true) {
//       return widget.includeAISuggestions
//           ? contentItem['content']?.toString() ?? ''
//           : '';
//     }
//     return widget.includeAISuggestions
//         ? ''
//         : contentItem['content']?.toString() ?? '';
//   }

//   List<dynamic> _filterSectionItems(List<dynamic> items,
//       {bool isExperience = false, bool isProjects = false}) {
//     if (items == null) return [];
//     if (isProjects) return items;

//     if (isExperience) return items;

//     return items.where((item) {
//       if (item is Map) {
//         return widget.includeAISuggestions
//             ? item['is_ai_generated'] == true
//             : item['is_ai_generated'] != true;
//       }
//       return true;
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.templateName),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.picture_as_pdf),
//             onPressed: () async {
//               final pdf = await _generatePdf();
//               await Printing.layoutPdf(
//                 onLayout: (format) => pdf.save(),
//               );
//             },
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Center(
//               child: Container(
//                 width: 595,
//                 height: 842,
//                 padding: const EdgeInsets.all(40),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(color: Colors.black, width: 1),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildHeaderSection(),
//                       _buildSummarySection(),
//                       _buildExperienceSection(),
//                       _buildEducationSection(),
//                       _buildSkillsSection(),
//                       _buildProjectsSection(),
//                       _buildCertificatesSection(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget _buildHeaderSection() {
//     final contact = widget.userId["contactDetails"] ?? {};
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           contact["name"] ?? 'No Name',
//           style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           "${contact["address"] ?? 'No Address'} | "
//           "${contact["phone"] ?? 'Not Provided'} | "
//           "${contact["email"] ?? 'Not Provided'}",
//           style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildSummarySection() {
//     if (_summary.isEmpty) return const SizedBox();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Divider(thickness: 2, color: Colors.black),
//         const SizedBox(height: 8),
//         const Text(
//           "SUMMARY",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           _summary,
//           style: const TextStyle(fontSize: 14),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }

//   Widget _buildExperienceSection() {
//     final experiences = _filterSectionItems(widget.userId["experience"] ?? [],
//         isExperience: true);

//     if (experiences.isEmpty) return const SizedBox();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Divider(thickness: 2, color: Colors.black),
//         const SizedBox(height: 8),
//         const Text(
//           "EXPERIENCE",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         for (var exp in experiences)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 6.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Handle AI-generated content differently
//                 if (exp['is_ai_generated'] == true &&
//                     widget.includeAISuggestions)
//                   Text(
//                     _getContent(exp),
//                     style: const TextStyle(fontSize: 14),
//                   )
//                 else if (exp['Job Title'] != null || exp['Company'] != null)
//                   Text(
//                     "${exp['Job Title'] ?? ''}${exp['Job Title'] != null && exp['Company'] != null ? ' | ' : ''}${exp['Company'] ?? ''}",
//                     style: const TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.bold),
//                   ),
//                 // Only show dates for non-AI content
//                 if (exp['Start Date'] != null &&
//                     exp['End Date'] != null &&
//                     (exp['is_ai_generated'] != true ||
//                         !widget.includeAISuggestions))
//                   Text(
//                     "  ${exp['Start Date']} - ${exp['End Date']}",
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 // Only show additional content for non-AI entries
//                 if (_getContent(exp).isNotEmpty &&
//                     !(exp['is_ai_generated'] == true &&
//                         widget.includeAISuggestions))
//                   Text(
//                     "  ${_getContent(exp)}",
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 const SizedBox(height: 8),
//               ],
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildEducationSection() {
//     final educationList = _filterSectionItems(widget.userId["education"] ?? []);

//     if (educationList.isEmpty) return const SizedBox();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Divider(thickness: 2, color: Colors.black),
//         const SizedBox(height: 8),
//         const Text(
//           "EDUCATION",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         for (var edu in educationList)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 6.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Handle AI-generated content differently
//                 if (edu['is_ai_generated'] == true &&
//                     widget.includeAISuggestions)
//                   Text(
//                     _getContent(edu),
//                     style: const TextStyle(fontSize: 14),
//                   )
//                 else if (edu['Qualification'] != null ||
//                     edu['Institution'] != null)
//                   Text(
//                     "${edu['Qualification'] ?? ''}${edu['Qualification'] != null && edu['Institution'] != null ? ' | ' : ''}${edu['Institution'] ?? ''}",
//                     style: const TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.bold),
//                   ),
//                 // Only show dates for non-AI content
//                 if (edu['Completion Date'] != null &&
//                     (edu['is_ai_generated'] != true ||
//                         !widget.includeAISuggestions))
//                   Text(
//                     "  ${edu['Completion Date']}",
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 // Only show additional content for non-AI entries
//                 if (_getContent(edu).isNotEmpty &&
//                     !(edu['is_ai_generated'] == true &&
//                         widget.includeAISuggestions))
//                   Text(
//                     "  ${_getContent(edu)}",
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 const SizedBox(height: 8),
//               ],
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildSkillsSection() {
//     final techSkills =
//         _filterSectionItems(widget.userId["technicalSkills"] ?? []);
//     final softSkills = widget.userId["softSkills"] ?? [];

//     if (techSkills.isEmpty && softSkills.isEmpty) return const SizedBox();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Divider(thickness: 2, color: Colors.black),
//         const SizedBox(height: 8),
//         const Text(
//           "SKILLS",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         if (techSkills.isNotEmpty)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 6.0),
//             child: Text(
//               "Technical Skills: ${techSkills.map((skill) => _getContent(skill)).join(", ")}",
//               style: const TextStyle(fontSize: 14),
//             ),
//           ),
//         if (softSkills.isNotEmpty)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 6.0),
//             child: Text(
//               "Soft Skills: ${softSkills.join(", ")}",
//               style: const TextStyle(fontSize: 14),
//             ),
//           ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }

//   Widget _buildProjectsSection() {
//     // Use isProjects: true to always show all projects
//     final projects =
//         _filterSectionItems(widget.userId["projects"] ?? [], isProjects: true);

//     if (projects.isEmpty) return const SizedBox();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Divider(thickness: 2, color: Colors.black),
//         const SizedBox(height: 8),
//         const Text(
//           "PROJECTS",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         for (var proj in projects)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 6.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "${proj['title'] ?? 'Not Provided'} | ${proj['role'] ?? 'Not Provided'}",
//                   style: const TextStyle(
//                       fontSize: 14, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "  Technologies: ${proj['technologies']?.join(", ") ?? 'Not Provided'}",
//                   style: const TextStyle(fontSize: 14),
//                 ),
//                 if (_getContent(proj).isNotEmpty)
//                   Text(
//                     "  ${_getContent(proj)}",
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 const SizedBox(height: 8),
//               ],
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildCertificatesSection() {
//     final awards = _filterSectionItems(widget.userId["awards"] ?? []);
//     final certificates =
//         _filterSectionItems(widget.userId["certificates"] ?? []);

//     if (awards.isEmpty && certificates.isEmpty) return const SizedBox();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Divider(thickness: 2, color: Colors.black),
//         const SizedBox(height: 8),
//         const Text(
//           "AWARDS & CERTIFICATES",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         for (var award in awards)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 6.0),
//             child: Text(
//               _getContent(award),
//               style: const TextStyle(fontSize: 14),
//             ),
//           ),
//         for (var cert in certificates)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 6.0),
//             child: Text(
//               _getContent(cert),
//               style: const TextStyle(fontSize: 14),
//             ),
//           ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }

//   Future<pw.Document> _generatePdf() async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               _buildPdfHeaderSection(),
//               _buildPdfSummarySection(),
//               _buildPdfExperienceSection(),
//               _buildPdfEducationSection(),
//               _buildPdfSkillsSection(),
//               _buildPdfProjectsSection(),
//               _buildPdfCertificatesSection(),
//             ],
//           );
//         },
//       ),
//     );

//     return pdf;
//   }

//   pw.Widget _buildPdfHeaderSection() {
//     final contact = widget.userId["contactDetails"] ?? {};
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text(
//           contact["name"] ?? 'No Name',
//           style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.SizedBox(height: 8),
//         pw.Text(
//           "${contact["address"] ?? 'No Address'} | "
//           "${contact["phone"] ?? 'Not Provided'} | "
//           "${contact["email"] ?? 'Not Provided'}",
//           style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
//         ),
//         pw.SizedBox(height: 10),
//       ],
//     );
//   }

//   pw.Widget _buildPdfSummarySection() {
//     if (_summary.isEmpty) return pw.SizedBox();

//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         _buildPdfDivider(),
//         pw.Text(
//           "SUMMARY",
//           style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.SizedBox(height: 8),
//         pw.Text(
//           _summary,
//           style: const pw.TextStyle(fontSize: 10),
//         ),
//         pw.SizedBox(height: 10),
//       ],
//     );
//   }

//   pw.Widget _buildPdfExperienceSection() {
//     final experiences = _filterSectionItems(widget.userId["experience"] ?? [],
//         isExperience: true);

//     if (experiences.isEmpty) return pw.SizedBox();

//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         _buildPdfDivider(),
//         pw.Text(
//           "EXPERIENCE",
//           style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.SizedBox(height: 8),
//         for (var exp in experiences)
//           pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               // Handle AI-generated content differently
//               if (exp['is_ai_generated'] == true && widget.includeAISuggestions)
//                 pw.Text(
//                   _getContent(exp),
//                   style: const pw.TextStyle(fontSize: 10),
//                 )
//               else if (exp['Job Title'] != null || exp['Company'] != null)
//                 pw.Text(
//                   "${exp['Job Title'] ?? ''}${exp['Job Title'] != null && exp['Company'] != null ? ' | ' : ''}${exp['Company'] ?? ''}",
//                   style: pw.TextStyle(
//                       fontSize: 10, fontWeight: pw.FontWeight.bold),
//                 ),
//               // Only show dates for non-AI content
//               if (exp['Start Date'] != null &&
//                   exp['End Date'] != null &&
//                   (exp['is_ai_generated'] != true ||
//                       !widget.includeAISuggestions))
//                 pw.Text(
//                   "  ${exp['Start Date']} - ${exp['End Date']}",
//                   style: const pw.TextStyle(fontSize: 10),
//                 ),
//               // Only show additional content for non-AI entries
//               if (_getContent(exp).isNotEmpty &&
//                   !(exp['is_ai_generated'] == true &&
//                       widget.includeAISuggestions))
//                 pw.Text(
//                   "  ${_getContent(exp)}",
//                   style: const pw.TextStyle(fontSize: 10),
//                 ),
//               pw.SizedBox(height: 8),
//             ],
//           ),
//       ],
//     );
//   }

//   pw.Widget _buildPdfEducationSection() {
//     final educationList = _filterSectionItems(widget.userId["education"] ?? []);

//     if (educationList.isEmpty) return pw.SizedBox();

//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         _buildPdfDivider(),
//         pw.Text(
//           "EDUCATION",
//           style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.SizedBox(height: 8),
//         for (var edu in educationList)
//           pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               // Handle AI-generated content differently
//               if (edu['is_ai_generated'] == true && widget.includeAISuggestions)
//                 pw.Text(
//                   _getContent(edu),
//                   style: const pw.TextStyle(fontSize: 10),
//                 )
//               else if (edu['Qualification'] != null ||
//                   edu['Institution'] != null)
//                 pw.Text(
//                   "${edu['Qualification'] ?? ''}${edu['Qualification'] != null && edu['Institution'] != null ? ' | ' : ''}${edu['Institution'] ?? ''}",
//                   style: pw.TextStyle(
//                       fontSize: 10, fontWeight: pw.FontWeight.bold),
//                 ),
//               // Only show dates for non-AI content
//               if (edu['Completion Date'] != null &&
//                   (edu['is_ai_generated'] != true ||
//                       !widget.includeAISuggestions))
//                 pw.Text(
//                   "  ${edu['Completion Date']}",
//                   style: const pw.TextStyle(fontSize: 10),
//                 ),
//               // Only show additional content for non-AI entries
//               if (_getContent(edu).isNotEmpty &&
//                   !(edu['is_ai_generated'] == true &&
//                       widget.includeAISuggestions))
//                 pw.Text(
//                   "  ${_getContent(edu)}",
//                   style: const pw.TextStyle(fontSize: 10),
//                 ),
//               pw.SizedBox(height: 8),
//             ],
//           ),
//       ],
//     );
//   }

//   pw.Widget _buildPdfSkillsSection() {
//     final techSkills =
//         _filterSectionItems(widget.userId["technicalSkills"] ?? []);
//     final softSkills = widget.userId["softSkills"] ?? [];

//     if (techSkills.isEmpty && softSkills.isEmpty) return pw.SizedBox();

//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         _buildPdfDivider(),
//         pw.Text(
//           "SKILLS",
//           style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.SizedBox(height: 8),
//         if (techSkills.isNotEmpty)
//           pw.Padding(
//             padding: const pw.EdgeInsets.only(bottom: 6.0),
//             child: pw.Text(
//               "Technical Skills: ${techSkills.map((skill) => _getContent(skill)).join(", ")}",
//               style: const pw.TextStyle(fontSize: 10),
//             ),
//           ),
//         if (softSkills.isNotEmpty)
//           pw.Padding(
//             padding: const pw.EdgeInsets.only(bottom: 6.0),
//             child: pw.Text(
//               "Soft Skills: ${softSkills.join(", ")}",
//               style: const pw.TextStyle(fontSize: 10),
//             ),
//           ),
//         pw.SizedBox(height: 10),
//       ],
//     );
//   }

//   pw.Widget _buildPdfProjectsSection() {
//     // Use isProjects: true to always show all projects
//     final projects =
//         _filterSectionItems(widget.userId["projects"] ?? [], isProjects: true);

//     if (projects.isEmpty) return pw.SizedBox();

//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         _buildPdfDivider(),
//         pw.Text(
//           "PROJECTS",
//           style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.SizedBox(height: 8),
//         for (var proj in projects)
//           pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text(
//                 "${proj['title'] ?? 'Not Provided'} | ${proj['role'] ?? 'Not Provided'}",
//                 style:
//                     pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.Text(
//                 "  Technologies: ${proj['technologies']?.join(", ") ?? 'Not Provided'}",
//                 style: const pw.TextStyle(fontSize: 10),
//               ),
//               if (_getContent(proj).isNotEmpty)
//                 pw.Text(
//                   "  ${_getContent(proj)}",
//                   style: const pw.TextStyle(fontSize: 10),
//                 ),
//               pw.SizedBox(height: 8),
//             ],
//           ),
//       ],
//     );
//   }

//   pw.Widget _buildPdfCertificatesSection() {
//     final awards = _filterSectionItems(widget.userId["awards"] ?? []);
//     final certificates =
//         _filterSectionItems(widget.userId["certificates"] ?? []);

//     if (awards.isEmpty && certificates.isEmpty) return pw.SizedBox();

//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         _buildPdfDivider(),
//         pw.Text(
//           "AWARDS & CERTIFICATES",
//           style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.SizedBox(height: 8),
//         for (var award in awards)
//           pw.Padding(
//             padding: const pw.EdgeInsets.only(bottom: 6.0),
//             child: pw.Text(
//               _getContent(award),
//               style: const pw.TextStyle(fontSize: 10),
//             ),
//           ),
//         for (var cert in certificates)
//           pw.Padding(
//             padding: const pw.EdgeInsets.only(bottom: 6.0),
//             child: pw.Text(
//               _getContent(cert),
//               style: const pw.TextStyle(fontSize: 10),
//             ),
//           ),
//         pw.SizedBox(height: 10),
//       ],
//     );
//   }

//   pw.Widget _buildPdfDivider() {
//     return pw.Divider(
//       thickness: 2,
//       color: PdfColors.black,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Template1 extends StatefulWidget {
  final String templateName;
  final Map<String, dynamic> userId;
  final bool includeAISuggestions;

  const Template1({
    Key? key,
    required this.templateName,
    required this.userId,
    this.includeAISuggestions = false,
  }) : super(key: key);

  @override
  _Template1State createState() => _Template1State();
}

class _Template1State extends State<Template1> {
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
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                ),
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
    );
  }

  Widget _buildHeaderSection() {
    final contact = widget.userId["contactDetails"] ?? {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contact["name"] ?? 'No Name',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          "${contact["address"] ?? 'No Address'} | "
          "${contact["phone"] ?? 'Not Provided'} | "
          "${contact["email"] ?? 'Not Provided'}",
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSummarySection() {
    if (_summary.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 2, color: Colors.black),
        const SizedBox(height: 8),
        const Text(
          "SUMMARY",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          _summary,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildExperienceSection() {
    final experiences = _filterSectionItems(widget.userId["experience"] ?? []);

    if (experiences.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 2, color: Colors.black),
        const SizedBox(height: 8),
        const Text(
          "EXPERIENCE",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
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
                    style: const TextStyle(fontSize: 14),
                  )
                else if (exp['Job Title'] != null || exp['Company'] != null)
                  Text(
                    "${exp['Job Title'] ?? ''}${exp['Job Title'] != null && exp['Company'] != null ? ' | ' : ''}${exp['Company'] ?? ''}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                if (exp['Start Date'] != null &&
                    exp['End Date'] != null &&
                    (exp['is_ai_generated'] != true ||
                        !widget.includeAISuggestions))
                  Text(
                    "  ${exp['Start Date']} - ${exp['End Date']}",
                    style: const TextStyle(fontSize: 14),
                  ),
                if (_getContent(exp).isNotEmpty &&
                    !(exp['is_ai_generated'] == true &&
                        widget.includeAISuggestions))
                  Text(
                    "  ${_getContent(exp)}",
                    style: const TextStyle(fontSize: 14),
                  ),
                const SizedBox(height: 8),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildEducationSection() {
    final educationList = _filterSectionItems(widget.userId["education"] ?? []);

    if (educationList.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 2, color: Colors.black),
        const SizedBox(height: 8),
        const Text(
          "EDUCATION",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
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
                    style: const TextStyle(fontSize: 14),
                  )
                else if (edu['Qualification'] != null ||
                    edu['Institution'] != null)
                  Text(
                    "${edu['Qualification'] ?? ''}${edu['Qualification'] != null && edu['Institution'] != null ? ' | ' : ''}${edu['Institution'] ?? ''}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                if (edu['Completion Date'] != null &&
                    (edu['is_ai_generated'] != true ||
                        !widget.includeAISuggestions))
                  Text(
                    "  ${edu['Completion Date']}",
                    style: const TextStyle(fontSize: 14),
                  ),
                if (_getContent(edu).isNotEmpty &&
                    !(edu['is_ai_generated'] == true &&
                        widget.includeAISuggestions))
                  Text(
                    "  ${_getContent(edu)}",
                    style: const TextStyle(fontSize: 14),
                  ),
                const SizedBox(height: 8),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSkillsSection() {
    final techSkills =
        _filterSectionItems(widget.userId["technicalSkills"] ?? []);
    final softSkills = widget.userId["softSkills"] ?? [];

    if (techSkills.isEmpty && softSkills.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 2, color: Colors.black),
        const SizedBox(height: 8),
        const Text(
          "SKILLS",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (techSkills.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              "Technical Skills: ${techSkills.map((skill) => _getContent(skill)).join(", ")}",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        if (softSkills.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              "Soft Skills: ${softSkills.join(", ")}",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildProjectsSection() {
    final projects = _filterSectionItems(widget.userId["projects"] ?? []);

    if (projects.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 2, color: Colors.black),
        const SizedBox(height: 8),
        const Text(
          "PROJECTS",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
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
                    style: const TextStyle(fontSize: 14),
                  )
                else if (proj['title'] != null || proj['role'] != null)
                  Text(
                    "${proj['title'] ?? ''}${proj['title'] != null && proj['role'] != null ? ' | ' : ''}${proj['role'] ?? ''}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                if (proj['technologies'] != null &&
                    (proj['is_ai_generated'] != true ||
                        !widget.includeAISuggestions))
                  Text(
                    "  Technologies: ${proj['technologies']?.join(", ") ?? 'Not Provided'}",
                    style: const TextStyle(fontSize: 14),
                  ),
                if (_getContent(proj).isNotEmpty &&
                    !(proj['is_ai_generated'] == true &&
                        widget.includeAISuggestions))
                  Text(
                    "  ${_getContent(proj)}",
                    style: const TextStyle(fontSize: 14),
                  ),
                const SizedBox(height: 8),
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

    if (awards.isEmpty && certificates.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 2, color: Colors.black),
        const SizedBox(height: 8),
        const Text(
          "AWARDS & CERTIFICATES",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        for (var award in awards)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              _getContent(award),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        for (var cert in certificates)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              _getContent(cert),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }

  Future<pw.Document> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
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
        pw.Text(
          contact["name"] ?? 'No Name',
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          "${contact["address"] ?? 'No Address'} | "
          "${contact["phone"] ?? 'Not Provided'} | "
          "${contact["email"] ?? 'Not Provided'}",
          style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 10),
      ],
    );
  }

  pw.Widget _buildPdfSummarySection() {
    if (_summary.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildPdfDivider(),
        pw.Text(
          "SUMMARY",
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          _summary,
          style: const pw.TextStyle(fontSize: 10),
        ),
        pw.SizedBox(height: 10),
      ],
    );
  }

  pw.Widget _buildPdfExperienceSection() {
    final experiences = _filterSectionItems(widget.userId["experience"] ?? []);

    if (experiences.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildPdfDivider(),
        pw.Text(
          "EXPERIENCE",
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
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
                  "${exp['Job Title'] ?? ''}${exp['Job Title'] != null && exp['Company'] != null ? ' | ' : ''}${exp['Company'] ?? ''}",
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold),
                ),
              if (exp['Start Date'] != null &&
                  exp['End Date'] != null &&
                  (exp['is_ai_generated'] != true ||
                      !widget.includeAISuggestions))
                pw.Text(
                  "  ${exp['Start Date']} - ${exp['End Date']}",
                  style: const pw.TextStyle(fontSize: 10),
                ),
              if (_getContent(exp).isNotEmpty &&
                  !(exp['is_ai_generated'] == true &&
                      widget.includeAISuggestions))
                pw.Text(
                  "  ${_getContent(exp)}",
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
        _buildPdfDivider(),
        pw.Text(
          "EDUCATION",
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
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
                  "${edu['Qualification'] ?? ''}${edu['Qualification'] != null && edu['Institution'] != null ? ' | ' : ''}${edu['Institution'] ?? ''}",
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold),
                ),
              if (edu['Completion Date'] != null &&
                  (edu['is_ai_generated'] != true ||
                      !widget.includeAISuggestions))
                pw.Text(
                  "  ${edu['Completion Date']}",
                  style: const pw.TextStyle(fontSize: 10),
                ),
              if (_getContent(edu).isNotEmpty &&
                  !(edu['is_ai_generated'] == true &&
                      widget.includeAISuggestions))
                pw.Text(
                  "  ${_getContent(edu)}",
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
    final softSkills = widget.userId["softSkills"] ?? [];

    if (techSkills.isEmpty && softSkills.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildPdfDivider(),
        pw.Text(
          "SKILLS",
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        if (techSkills.isNotEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              "Technical Skills: ${techSkills.map((skill) => _getContent(skill)).join(", ")}",
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
        if (softSkills.isNotEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6.0),
            child: pw.Text(
              "Soft Skills: ${softSkills.join(", ")}",
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
        pw.SizedBox(height: 10),
      ],
    );
  }

  pw.Widget _buildPdfProjectsSection() {
    final projects = _filterSectionItems(widget.userId["projects"] ?? []);

    if (projects.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildPdfDivider(),
        pw.Text(
          "PROJECTS",
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
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
                  "${proj['title'] ?? ''}${proj['title'] != null && proj['role'] != null ? ' | ' : ''}${proj['role'] ?? ''}",
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold),
                ),
              if (proj['technologies'] != null &&
                  (proj['is_ai_generated'] != true ||
                      !widget.includeAISuggestions))
                pw.Text(
                  "  Technologies: ${proj['technologies']?.join(", ") ?? 'Not Provided'}",
                  style: const pw.TextStyle(fontSize: 10),
                ),
              if (_getContent(proj).isNotEmpty &&
                  !(proj['is_ai_generated'] == true &&
                      widget.includeAISuggestions))
                pw.Text(
                  "  ${_getContent(proj)}",
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
        _buildPdfDivider(),
        pw.Text(
          "AWARDS & CERTIFICATES",
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
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
        pw.SizedBox(height: 10),
      ],
    );
  }

  pw.Widget _buildPdfDivider() {
    return pw.Divider(
      thickness: 2,
      color: PdfColors.black,
    );
  }
}
