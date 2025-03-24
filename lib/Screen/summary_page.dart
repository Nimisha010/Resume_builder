/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'resume_selection.dart'; // Import ResumeSelectionScreen

class GenerateSummaryPage extends StatefulWidget {
  const GenerateSummaryPage({Key? key}) : super(key: key);

  @override
  _GenerateSummaryPageState createState() => _GenerateSummaryPageState();
}

class _GenerateSummaryPageState extends State<GenerateSummaryPage> {
  String _generatedSummary = '';
  bool _isLoading = false;
  final TextEditingController _summaryController = TextEditingController();

  Future<void> _generateAndSaveSummary() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch user details from Firestore
      final userDetails = await _fetchUserDetails();
      if (userDetails == null) {
        throw Exception('User details not found');
      }

      // Debugging: Log the fetched user details
      print('✅ User Details: $userDetails');

      // Generate summary using Gemini AI
      final summary = await generateSummary(
        education: userDetails['education'],
        experience: userDetails['experience'],
        skills: userDetails['skills'], // skills is a list
      );

      setState(() {
        _generatedSummary = summary;
        _summaryController.text =
            summary; // Set the generated summary in the TextField
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Map<String, dynamic>?> _fetchUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('users').doc(user.uid).get();

    if (doc.exists) {
      final data = doc.data()!;

      // Debugging: Log the fetched data
      print('✅ User Data Fetched: $data');

      // Extract education as a string
      final educationList = data["education"] as List<dynamic>? ?? [];
      final education = educationList.isNotEmpty
          ? educationList.map((e) => e['Qualification'] as String).join(', ')
          : 'No education provided';

      // Extract experience as a string
      final experienceList = data["experience"] as List<dynamic>? ?? [];
      final experience = experienceList.isNotEmpty
          ? experienceList
              .map((e) => '${e['Job Title']} at ${e['Company']}')
              .join(', ')
          : 'No experience provided';

      // Combine softSkills and technicalSkills into a single list
      final softSkills = data["softSkills"] as List<dynamic>? ?? [];
      final technicalSkills = data["technicalSkills"] as List<dynamic>? ?? [];
      final skills = [...softSkills, ...technicalSkills];

      // Debugging: Log the extracted fields
      print('📚 Education: $education');
      print('💼 Experience: $experience');
      print('🛠️ Skills: $skills');

      // Return the formatted data
      return {
        'education': education,
        'experience': experience,
        'skills': skills,
      };
    } else {
      return null;
    }
  }

  Future<String> generateSummary({
    required String education,
    String? experience,
    required List<dynamic> skills, // skills is a list
  }) async {
    final url = Uri.parse('http://192.168.1.7:5000/generate-summary');
    final headers = {'Content-Type': 'application/json'};

    // Convert the skills list to a comma-separated string
    final skillsString = skills.join(', ');

    final body = jsonEncode({
      'education': education,
      'experience': experience,
      'skills': skillsString, // Send skills as a string
    });

    // Debugging: Print the request body
    print('📤 Request Body: $body');

    final response = await http.post(url, headers: headers, body: body);

    // Debugging: Print the response
    print('📥 Response: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['summary'];
    } else {
      throw Exception('Failed to generate summary: ${response.body}');
    }
  }

  Future<void> _saveSummaryToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(user.uid).update({
      'summary': _summaryController.text, // Save the edited summary
      'summary_timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Summary saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _generateAndSaveSummary,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Generate Summary'),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _summaryController,
              maxLines: 10,
              decoration: InputDecoration(
                labelText: 'Edit Summary',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _saveSummaryToFirestore,
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResumeSelectionScreen(),
                      ),
                    );
                  },
                  child: Text('Continue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'resume_selection.dart'; // Import ResumeSelectionScreen

class GenerateSummaryPage extends StatefulWidget {
  const GenerateSummaryPage({Key? key}) : super(key: key);

  @override
  _GenerateSummaryPageState createState() => _GenerateSummaryPageState();
}

class _GenerateSummaryPageState extends State<GenerateSummaryPage> {
  String _generatedSummary = '';
  bool _isLoading = false;
  final TextEditingController _summaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchSummary(); // Fetch the summary when the page loads
  }

  /// Fetch the summary from Firestore
  Future<void> _fetchSummary() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('users').doc(user.uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        _generatedSummary = data['summary'] ?? '';
        _summaryController.text = _generatedSummary;
      });
    }
  }

  Future<void> _generateAndSaveSummary() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch user details from Firestore
      final userDetails = await _fetchUserDetails();
      if (userDetails == null) {
        throw Exception('User details not found');
      }

      // Debugging: Log the fetched user details
      print('✅ User Details: $userDetails');

      // Generate summary using Gemini AI
      final summary = await generateSummary(
        education: userDetails['education'],
        experience: userDetails['experience'],
        skills: userDetails['skills'], // skills is a list
      );

      setState(() {
        _generatedSummary = summary;
        _summaryController.text =
            summary; // Set the generated summary in the TextField
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Map<String, dynamic>?> _fetchUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('users').doc(user.uid).get();

    if (doc.exists) {
      final data = doc.data()!;

      // Debugging: Log the fetched data
      print('✅ User Data Fetched: $data');

      // Extract education as a string
      final educationList = data["education"] as List<dynamic>? ?? [];
      final education = educationList.isNotEmpty
          ? educationList.map((e) => e['Qualification'] as String).join(', ')
          : 'No education provided';

      // Extract experience as a string
      final experienceList = data["experience"] as List<dynamic>? ?? [];
      final experience = experienceList.isNotEmpty
          ? experienceList
              .map((e) => '${e['Job Title']} at ${e['Company']}')
              .join(', ')
          : 'No experience provided';

      // Combine softSkills and technicalSkills into a single list
      final softSkills = data["softSkills"] as List<dynamic>? ?? [];
      final technicalSkills = data["technicalSkills"] as List<dynamic>? ?? [];
      final skills = [...softSkills, ...technicalSkills];

      // Debugging: Log the extracted fields
      print('📚 Education: $education');
      print('💼 Experience: $experience');
      print('🛠️ Skills: $skills');

      // Return the formatted data
      return {
        'education': education,
        'experience': experience,
        'skills': skills,
      };
    } else {
      return null;
    }
  }

  Future<String> generateSummary({
    required String education,
    String? experience,
    required List<dynamic> skills, // skills is a list
  }) async {
    final url = Uri.parse('http://192.168.79.98:5000/generate-summary');
    final headers = {'Content-Type': 'application/json'};

    // Convert the skills list to a comma-separated string
    final skillsString = skills.join(', ');

    final body = jsonEncode({
      'education': education,
      'experience': experience,
      'skills': skillsString, // Send skills as a string
    });

    // Debugging: Print the request body
    print('📤 Request Body: $body');

    final response = await http.post(url, headers: headers, body: body);

    // Debugging: Print the response
    print('📥 Response: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['summary'];
    } else {
      throw Exception('Failed to generate summary: ${response.body}');
    }
  }

  Future<void> _saveSummaryToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(user.uid).update({
      'summary': _summaryController.text, // Save the edited summary
      'summary_timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Summary saved successfully!')),
    );
  }

  Future<void> _deleteSummary() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(user.uid).update({
      'summary': FieldValue.delete(), // Delete the summary
    });

    setState(() {
      _generatedSummary = '';
      _summaryController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Summary deleted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFF97C4B8)], // Gradient Background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'SUMMARY',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Summary TextField
                  TextField(
                    controller: _summaryController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: 'Edit Summary',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: _deleteSummary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Generate Summary Button
                  _buildButton(
                    _isLoading ? 'Generating...' : 'Generate Summary',
                    () {
                      if (!_isLoading) {
                        _generateAndSaveSummary();
                      }
                    },
                  ),
                  const SizedBox(height: 10),

                  // Save Button
                  _buildButton('Save', _saveSummaryToFirestore),
                  const SizedBox(height: 10),

                  // Continue Button
                  _buildButton('Continue', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResumeSelectionScreen(),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Bottom Buttons Widget
  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity, // Make the button full width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF184D47),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
