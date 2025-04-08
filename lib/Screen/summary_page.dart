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

/*correct one
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'resume_selection.dart'; // Import ResumeSelectionScreen
import 'choice_selection.dart';

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
                        builder: (context) => ChoiceScreen(),
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
*/

/*correct one


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'choice_selection.dart';

class GenerateSummaryPage extends StatefulWidget {
  const GenerateSummaryPage({Key? key}) : super(key: key);

  @override
  _GenerateSummaryPageState createState() => _GenerateSummaryPageState();
}

class _GenerateSummaryPageState extends State<GenerateSummaryPage> {
  List<String> _summaries = [];
  int? _selectedIndex;
  bool _isLoading = false;
  final TextEditingController _editController = TextEditingController();
  final TextEditingController _manualSummaryController =
      TextEditingController();
  bool _showManualInput = false;

  @override
  void initState() {
    super.initState();
    _loadSavedSummaries();
    _loadSelectedSummary();
  }

  Future<void> _loadSelectedSummary() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        if (data.containsKey('selected_summary_index')) {
          setState(() {
            _selectedIndex = data['selected_summary_index'];
          });
        }
      }
    } catch (e) {
      debugPrint('Error loading selected summary: $e');
    }
  }

  Future<void> _launchIndexCreationUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the link')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<Map<String, dynamic>?> _fetchUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        final educationList = data['education'] as List<dynamic>? ?? [];
        final education = educationList.isNotEmpty
            ? educationList.map((e) => e['Qualification'] as String).join(', ')
            : 'No education provided';

        final experienceList = data['experience'] as List<dynamic>? ?? [];
        final experience = experienceList.isNotEmpty
            ? experienceList
                .map((e) => '${e['Job Title']} at ${e['Company']}')
                .join(', ')
            : 'No experience provided';

        final softSkills = data['softSkills'] as List<dynamic>? ?? [];
        final technicalSkills = data['technicalSkills'] as List<dynamic>? ?? [];
        final skills = [...softSkills, ...technicalSkills];

        return {
          'education': education,
          'experience': experience,
          'skills': skills,
        };
      }
    } catch (e) {
      debugPrint('Error fetching user details: $e');
    }
    return null;
  }

  Future<void> _loadSavedSummaries() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('summaries')
          .where('user_id', isEqualTo: user.uid)
          .orderBy('created_at', descending: true)
          .limit(1)
          .get(const GetOptions(source: Source.server));

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _summaries = List<String>.from(snapshot.docs.first['summaries']);
        });
      }
    } on FirebaseException catch (e) {
      if (e.code == 'failed-precondition') {
        final errorMessage = e.message ?? '';
        final urlMatch = RegExp(r'https://[^\s]+').firstMatch(errorMessage);

        if (urlMatch != null) {
          final indexUrl = urlMatch.group(0)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Database needs configuration'),
              duration: const Duration(seconds: 10),
              action: SnackBarAction(
                label: 'Create Index',
                onPressed: () => _launchIndexCreationUrl(indexUrl),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Database configuration required: ${e.message}'),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
    }
  }

  Future<void> _saveSummariesToFirestore(List<String> summaries) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await FirebaseFirestore.instance.collection('summaries').add({
        'user_id': user.uid,
        'summaries': summaries,
        'created_at': FieldValue.serverTimestamp(),
        'is_edited': false,
      });
      debugPrint('Summaries saved successfully');
    } catch (e) {
      debugPrint('Error saving summaries: $e');
      throw Exception('Failed to save summaries');
    }
  }

  Future<List<String>> generateSummaries(Map<String, dynamic> userData) async {
    const url = 'http://192.168.79.98:5000/generate-summary';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'education': userData['education'],
          'experience': userData['experience'],
          'skills': List<String>.from(userData['skills']),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return List<String>.from(data['data']['summaries']);
        } else {
          throw Exception(data['message'] ?? 'Generation failed');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<void> _generateNewSummaries() async {
    setState(() => _isLoading = true);
    try {
      final userDetails = await _fetchUserDetails();
      if (userDetails == null) throw Exception('User details not found');

      final summaries = await generateSummaries({
        'education': userDetails['education'] ?? '',
        'experience': userDetails['experience'] ?? '',
        'skills': List<String>.from(userDetails['skills'] ?? []),
      });

      await _saveSummariesToFirestore(summaries);
      setState(() {
        _summaries = summaries;
        // Don't reset selected index when generating new summaries
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveSelectedSummary() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // Check if we're saving the manual input
      if (_showManualInput && _manualSummaryController.text.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'selected_summary': _manualSummaryController.text,
          'selected_summary_index': -1, // Special value for manual input
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Manual summary saved successfully!')),
        );
        return;
      }

      if (_selectedIndex == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please select or enter a summary first')),
        );
        return;
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('summaries')
          .where('user_id', isEqualTo: user.uid)
          .orderBy('created_at', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'selected_summary_id': snapshot.docs.first.id,
          'selected_summary_index': _selectedIndex,
          'selected_summary': _summaries[_selectedIndex!],
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Summary saved successfully!')),
        );
      }
    } on FirebaseException catch (e) {
      if (e.code == 'failed-precondition') {
        final errorMessage = e.message ?? '';
        final urlMatch = RegExp(r'https://[^\s]+').firstMatch(errorMessage);

        if (urlMatch != null) {
          final indexUrl = urlMatch.group(0)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Database needs configuration'),
              duration: const Duration(seconds: 10),
              action: SnackBarAction(
                label: 'Create Index',
                onPressed: () => _launchIndexCreationUrl(indexUrl),
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
    }
  }

  void _editSummary(int index) {
    _editController.text = _summaries[index];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Summary'),
        content: TextField(
          controller: _editController,
          maxLines: 5,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _summaries[index] = _editController.text;
              });
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFD1D1D1), Color(0xFF4B6965)],
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'PROFESSIONAL SUMMARY',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF184D47),
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ),
                      ),

                      // Manual Summary Input Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _showManualInput = !_showManualInput;
                                if (!_showManualInput) {
                                  _manualSummaryController.clear();
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF184D47),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: Text(
                              _showManualInput
                                  ? 'Hide Manual Input'
                                  : 'Write My Own Summary',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          if (_showManualInput) ...[
                            const SizedBox(height: 8.0),
                            TextField(
                              controller: _manualSummaryController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: const OutlineInputBorder(),
                                hintText:
                                    'Enter your professional summary here...',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.check),
                                  color: const Color(0xFF184D47),
                                  onPressed: () {
                                    if (_manualSummaryController
                                        .text.isNotEmpty) {
                                      setState(() {
                                        _selectedIndex = -1;
                                      });
                                      _saveSelectedSummary();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 12.0),

                      // Generate Summaries Button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _generateNewSummaries,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: const Color(0xFF184D47),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'Generate New Summaries',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),

                      const SizedBox(height: 12.0),

                      // Summary Content
                      _summaries.isEmpty && !_showManualInput
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'No summaries generated yet.\nClick the button above to create some!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                          : Column(
                              children: List.generate(
                                _summaries.length,
                                (index) => Card(
                                  margin: const EdgeInsets.only(bottom: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Option ${index + 1}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color(0xFF184D47),
                                          ),
                                        ),
                                        const SizedBox(height: 6.0),
                                        Text(
                                          _summaries[index],
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 6.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit,
                                                  color: Color(0xFF184D47)),
                                              onPressed: () =>
                                                  _editSummary(index),
                                            ),
                                            Radio<int>(
                                              value: index,
                                              groupValue: _selectedIndex,
                                              activeColor:
                                                  const Color(0xFF184D47),
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedIndex = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                      if (_summaries.isNotEmpty || _showManualInput)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                            onPressed: _saveSelectedSummary,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: const Color(0xFF184D47),
                            ),
                            child: const Text(
                              'Save Selected Summary',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                      // This empty SizedBox ensures the content doesn't get hidden behind the fixed button
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Fixed Continue Button at the bottom
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChoiceScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF184D47),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
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
import 'package:url_launcher/url_launcher.dart';
import 'choice_selection.dart';

class GenerateSummaryPage extends StatefulWidget {
  const GenerateSummaryPage({Key? key}) : super(key: key);

  @override
  _GenerateSummaryPageState createState() => _GenerateSummaryPageState();
}

class _GenerateSummaryPageState extends State<GenerateSummaryPage> {
  List<String> _summaries = [];
  int? _selectedIndex;
  bool _isLoading = false;
  final TextEditingController _editController = TextEditingController();
  final TextEditingController _manualSummaryController =
      TextEditingController();
  bool _showManualInput = false;
  bool _hasSavedSummary = false;
  int? _lastSavedIndex;
  bool _isEdited = false;

  @override
  void initState() {
    super.initState();
    _loadSavedSummaries();
    _loadSelectedSummary();
  }

  Future<void> _loadSelectedSummary() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        if (data.containsKey('selected_summary_index')) {
          setState(() {
            _selectedIndex = data['selected_summary_index'];
            _lastSavedIndex = _selectedIndex;
            _hasSavedSummary = true;
          });
        }
      }
    } catch (e) {
      debugPrint('Error loading selected summary: $e');
    }
  }

  Future<void> _launchIndexCreationUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the link')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<Map<String, dynamic>?> _fetchUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        final educationList = data['education'] as List<dynamic>? ?? [];
        final education = educationList.isNotEmpty
            ? educationList.map((e) => e['Qualification'] as String).join(', ')
            : 'No education provided';

        final experienceList = data['experience'] as List<dynamic>? ?? [];
        final experience = experienceList.isNotEmpty
            ? experienceList
                .map((e) => '${e['Job Title']} at ${e['Company']}')
                .join(', ')
            : 'No experience provided';

        final softSkills = data['softSkills'] as List<dynamic>? ?? [];
        final technicalSkills = data['technicalSkills'] as List<dynamic>? ?? [];
        final skills = [...softSkills, ...technicalSkills];

        return {
          'education': education,
          'experience': experience,
          'skills': skills,
        };
      }
    } catch (e) {
      debugPrint('Error fetching user details: $e');
    }
    return null;
  }

  Future<void> _loadSavedSummaries() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('summaries')
          .where('user_id', isEqualTo: user.uid)
          .orderBy('created_at', descending: true)
          .limit(1)
          .get(const GetOptions(source: Source.server));

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _summaries = List<String>.from(snapshot.docs.first['summaries']);
        });
      }
    } on FirebaseException catch (e) {
      if (e.code == 'failed-precondition') {
        final errorMessage = e.message ?? '';
        final urlMatch = RegExp(r'https://[^\s]+').firstMatch(errorMessage);

        if (urlMatch != null) {
          final indexUrl = urlMatch.group(0)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Database needs configuration'),
              duration: const Duration(seconds: 10),
              action: SnackBarAction(
                label: 'Create Index',
                onPressed: () => _launchIndexCreationUrl(indexUrl),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Database configuration required: ${e.message}'),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
    }
  }

  Future<void> _saveSummariesToFirestore(List<String> summaries) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await FirebaseFirestore.instance.collection('summaries').add({
        'user_id': user.uid,
        'summaries': summaries,
        'created_at': FieldValue.serverTimestamp(),
        'is_edited': false,
      });
      debugPrint('Summaries saved successfully');
    } catch (e) {
      debugPrint('Error saving summaries: $e');
      throw Exception('Failed to save summaries');
    }
  }

  Future<List<String>> generateSummaries(Map<String, dynamic> userData) async {
    const url = 'http://192.168.79.98:5000/generate-summary';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'education': userData['education'],
          'experience': userData['experience'],
          'skills': List<String>.from(userData['skills']),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return List<String>.from(data['data']['summaries']);
        } else {
          throw Exception(data['message'] ?? 'Generation failed');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<void> _generateNewSummaries() async {
    setState(() => _isLoading = true);
    try {
      final userDetails = await _fetchUserDetails();
      if (userDetails == null) throw Exception('User details not found');

      final summaries = await generateSummaries({
        'education': userDetails['education'] ?? '',
        'experience': userDetails['experience'] ?? '',
        'skills': List<String>.from(userDetails['skills'] ?? []),
      });

      await _saveSummariesToFirestore(summaries);
      setState(() {
        _summaries = summaries;
        _isEdited = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveSelectedSummary() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      if (_showManualInput && _manualSummaryController.text.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'selected_summary': _manualSummaryController.text,
          'selected_summary_index': -1,
        });

        setState(() {
          _lastSavedIndex = -1;
          _hasSavedSummary = true;
          _isEdited = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Manual summary saved successfully!')),
        );
        return;
      }

      if (_selectedIndex == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please select or enter a summary first')),
        );
        return;
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('summaries')
          .where('user_id', isEqualTo: user.uid)
          .orderBy('created_at', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'selected_summary_id': snapshot.docs.first.id,
          'selected_summary_index': _selectedIndex,
          'selected_summary': _summaries[_selectedIndex!],
        });

        setState(() {
          _lastSavedIndex = _selectedIndex;
          _hasSavedSummary = true;
          _isEdited = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Summary saved successfully!')),
        );
      }
    } on FirebaseException catch (e) {
      if (e.code == 'failed-precondition') {
        final errorMessage = e.message ?? '';
        final urlMatch = RegExp(r'https://[^\s]+').firstMatch(errorMessage);

        if (urlMatch != null) {
          final indexUrl = urlMatch.group(0)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Database needs configuration'),
              duration: const Duration(seconds: 10),
              action: SnackBarAction(
                label: 'Create Index',
                onPressed: () => _launchIndexCreationUrl(indexUrl),
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
    }
  }

  void _editSummary(int index) {
    _editController.text = _summaries[index];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Summary'),
        content: TextField(
          controller: _editController,
          maxLines: 5,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _summaries[index] = _editController.text;
                _isEdited = true;
              });
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showSaveConfirmationDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Unsaved Changes'),
        content: const Text(
            'You have unsaved changes to your summary. Please save before continuing.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFD1D1D1), Color(0xFF4B6965)],
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'PROFESSIONAL SUMMARY',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF184D47),
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ),
                      ),

                      // Manual Summary Input Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _showManualInput = !_showManualInput;
                                if (!_showManualInput) {
                                  _manualSummaryController.clear();
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF184D47),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: Text(
                              _showManualInput
                                  ? 'Hide Manual Input'
                                  : 'Write My Own Summary',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          if (_showManualInput) ...[
                            const SizedBox(height: 8.0),
                            TextField(
                              controller: _manualSummaryController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: const OutlineInputBorder(),
                                hintText:
                                    'Enter your professional summary here...',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.check),
                                  color: const Color(0xFF184D47),
                                  onPressed: () {
                                    if (_manualSummaryController
                                        .text.isNotEmpty) {
                                      setState(() {
                                        _selectedIndex = -1;
                                        _isEdited = true;
                                      });
                                      _saveSelectedSummary();
                                    }
                                  },
                                ),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  _isEdited = true;
                                });
                              },
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 12.0),

                      // Generate Summaries Button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _generateNewSummaries,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: const Color(0xFF184D47),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'Generate New Summaries',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),

                      const SizedBox(height: 12.0),

                      // Summary Content
                      _summaries.isEmpty && !_showManualInput
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'No summaries generated yet.\nClick the button above to create some!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                          : Column(
                              children: List.generate(
                                _summaries.length,
                                (index) => Card(
                                  margin: const EdgeInsets.only(bottom: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Option ${index + 1}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color(0xFF184D47),
                                          ),
                                        ),
                                        const SizedBox(height: 6.0),
                                        Text(
                                          _summaries[index],
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 6.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit,
                                                  color: Color(0xFF184D47)),
                                              onPressed: () =>
                                                  _editSummary(index),
                                            ),
                                            Radio<int>(
                                              value: index,
                                              groupValue: _selectedIndex,
                                              activeColor:
                                                  const Color(0xFF184D47),
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedIndex = value;
                                                  _isEdited = _selectedIndex !=
                                                      _lastSavedIndex;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                      if (_summaries.isNotEmpty || _showManualInput)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                            onPressed: _saveSelectedSummary,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: const Color(0xFF184D47),
                            ),
                            child: const Text(
                              'Save Selected Summary',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Fixed Continue Button at the bottom
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: ElevatedButton(
              onPressed: () {
                if (!_hasSavedSummary ||
                    _isEdited ||
                    (_selectedIndex != _lastSavedIndex &&
                        !(_selectedIndex == null && _lastSavedIndex == -1))) {
                  _showSaveConfirmationDialog();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChoiceScreen(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF184D47),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
