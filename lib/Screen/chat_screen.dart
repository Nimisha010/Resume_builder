/*

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  List<String> suggestions = [];
  bool isLoading = false;
  final List<String> _predefinedQuestions = [
    "Help me write a professional summary",
    "Suggest bullet points for my work experience",
    "Improve my project description",
    "Make my skills section more impactful",
    "Help me describe my education background"
  ];

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    if (FirebaseAuth.instance.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please sign in to save suggestions')),
        );
      });
    }
  }

  Future<void> sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      isLoading = true;
      suggestions.clear();
    });

    try {
      final response = await http
          .post(
            Uri.parse('http://192.168.1.7:5000/chat'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'user_id': user.uid,
              'message': "Provide 2-3 concise sentences about: $message",
            }),
          )
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);
      final rawResponse = data['reply']?.toString() ?? 'No response';

      setState(() {
        suggestions = rawResponse
            .split(RegExp(r'(?<=[.!?])\s+'))
            .where((s) => s.trim().isNotEmpty)
            .take(3)
            .toList();
        isLoading = false;
        _messageController.clear();
      });
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    }
  }

  Future<void> _showSectionDialog(String suggestion) async {
    final section = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Save to Section"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildSectionTile("Experience", Icons.work_outline),
              _buildSectionTile("Education", Icons.school_outlined),
              _buildSectionTile("Projects", Icons.code_outlined),
              _buildSectionTile("Skills", Icons.build_outlined),
              _buildSectionTile("Certificates", Icons.verified_outlined),
              _buildSectionTile("Summary", Icons.description_outlined),
            ],
          ),
        ),
      ),
    );

    if (section != null) {
      await _saveToSection(suggestion, section.toLowerCase());
    }
  }

  Widget _buildSectionTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => Navigator.pop(context, title),
    );
  }

  Future<void> _saveToSection(String content, String section) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final docRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      switch (section) {
        case 'experience':
          await docRef.update({
            'experience': FieldValue.arrayUnion([
              {
                'content': content,
                'is_ai_generated': true,
              }
            ])
          });
          break;

        case 'education':
          await docRef.update({
            'education': FieldValue.arrayUnion([
              {
                'content': content,
                'is_ai_generated': true,
              }
            ])
          });
          break;

        case 'projects':
          await docRef.update({
            'projects': FieldValue.arrayUnion([
              {
                'content': content,
                'is_ai_generated': true,
              }
            ])
          });
          break;

        case 'skills':
          await docRef.update({
            'technicalSkills': FieldValue.arrayUnion([
              {
                'skill': content,
                'is_ai_generated': true,
              }
            ])
          });
          break;

        case 'certificates':
          await docRef.update({
            'certificates': FieldValue.arrayUnion([
              {
                'name': content,
                'is_ai_generated': true,
              }
            ])
          });
          break;

        case 'summary':
          // For summary, we'll just store the latest AI suggestion
          await docRef.update({
            'selected_summary': content,
            'is_ai_summary': true,
          });
          break;

        default:
          throw Exception('Invalid section');
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved to $section section!')),
        );
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Firestore error: ${e.message}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Builder Assistant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() => suggestions.clear()),
          )
        ],
      ),
      body: Column(
        children: [
          // Predefined questions
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              children: _predefinedQuestions.map((question) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    label: Text(question),
                    onPressed: () {
                      _messageController.text = question;
                      sendMessage();
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // Suggestions
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(suggestions[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.save, color: Colors.green),
                      onPressed: () => _showSectionDialog(suggestions[index]),
                    ),
                  ),
                );
              },
            ),
          ),

          // Input
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Ask for resume suggestions...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onSubmitted: (_) => sendMessage(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
*/

/* correct one

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'resume_selection.dart';
import 'dart:convert';

enum MessageType {
  userMessage,
  aiResponse,
  resumeSuggestion,
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  bool isLoading = false;
  final List<String> _predefinedQuestions = [
    "Help me write a professional summary",
    "Suggest bullet points for my work experience",
    "Improve my project description",
    "Make my skills section more impactful",
    "Help me describe my education background"
  ];

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    if (FirebaseAuth.instance.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please sign in to save suggestions')),
        );
      });
    }
  }

  Future<void> sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    // Add user message to chat
    setState(() {
      messages.add({
        'text': message,
        'type': MessageType.userMessage,
      });
      isLoading = true;
      _messageController.clear();
    });

    try {
      final response = await http
          .post(
            Uri.parse('http://192.168.1.7:5000/chat'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'user_id': user.uid,
              'message': message,
            }),
          )
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);
      final rawResponse = data['reply']?.toString() ?? 'No response';

      setState(() {
        // Check if this is a resume suggestion or regular chat
        bool isResumeSuggestion = message.toLowerCase().contains('resume') ||
            message.toLowerCase().contains('summary') ||
            message.toLowerCase().contains('experience') ||
            message.toLowerCase().contains('education') ||
            message.toLowerCase().contains('skill');

        if (isResumeSuggestion) {
          // Parse as resume suggestions
          final suggestionList = rawResponse
              .split(RegExp(r'(?<=[.!?])\s+'))
              .where((s) => s.trim().isNotEmpty)
              .take(3)
              .toList();

          for (var suggestion in suggestionList) {
            messages.add({
              'text': suggestion,
              'type': MessageType.resumeSuggestion,
              'editableText': suggestion, // For editing
            });
          }
        } else {
          // Regular chat response
          messages.add({
            'text': rawResponse,
            'type': MessageType.aiResponse,
          });
        }

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        messages.add({
          'text': "Error: ${e.toString()}",
          'type': MessageType.aiResponse,
        });
      });
    }
  }

  Future<void> _showSectionDialog(String content) async {
    final section = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Save to Section"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildSectionTile("Experience", Icons.work_outline),
              _buildSectionTile("Education", Icons.school_outlined),
              _buildSectionTile("Projects", Icons.code_outlined),
              _buildSectionTile("Skills", Icons.build_outlined),
              _buildSectionTile("Certificates", Icons.verified_outlined),
              _buildSectionTile("Summary", Icons.description_outlined),
            ],
          ),
        ),
      ),
    );

    if (section != null) {
      await _saveToSection(content, section.toLowerCase());
    }
  }

  Widget _buildSectionTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => Navigator.pop(context, title),
    );
  }

  Future<void> _saveToSection(String content, String section) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final docRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final data = {
        'content': content,
        'is_ai_generated': true,
        'last_modified': FieldValue.serverTimestamp(),
      };

      switch (section) {
        case 'experience':
          await docRef.update({
            'experience': FieldValue.arrayUnion([data])
          });
          break;

        case 'education':
          await docRef.update({
            'education': FieldValue.arrayUnion([data])
          });
          break;

        case 'projects':
          await docRef.update({
            'projects': FieldValue.arrayUnion([data])
          });
          break;

        case 'skills':
          await docRef.update({
            'technicalSkills': FieldValue.arrayUnion([
              {
                'skill': content,
                'is_ai_generated': true,
              }
            ])
          });
          break;

        case 'certificates':
          await docRef.update({
            'certificates': FieldValue.arrayUnion([
              {
                'name': content,
                'is_ai_generated': true,
              }
            ])
          });
          break;

        case 'summary':
          await docRef.update({
            'selected_summary': content,
            'is_ai_summary': true,
          });
          break;

        default:
          throw Exception('Invalid section');
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved to $section section!')),
        );
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Firestore error: ${e.message}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  Widget _buildUserMessage(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildAiMessage(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildSuggestionMessage(
    String originalText,
    String editableText,
    Function(String) onTextChanged,
    Function() onSave,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Resume Suggestion:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: editableText),
              maxLines: 3,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8)),
              onChanged: onTextChanged,
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onSave,
                child: Text('Save to Resume'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green, // Changed from primary to backgroundColor
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Builder Assistant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResumeSelectionScreen(),
                ),
              );
            },
            tooltip: 'View Templates',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() => messages.clear()),
          )
        ],
      ),
      body: Column(
        children: [
          // Predefined questions
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              children: _predefinedQuestions.map((question) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    label: Text(question),
                    onPressed: () {
                      _messageController.text = question;
                      sendMessage();
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length && isLoading) {
                  return _buildTypingIndicator();
                }

                final message = messages[index];

                if (message['type'] == MessageType.userMessage) {
                  return _buildUserMessage(message['text']);
                } else if (message['type'] == MessageType.aiResponse) {
                  return _buildAiMessage(message['text']);
                } else {
                  return _buildSuggestionMessage(
                    message['text'],
                    message['editableText'],
                    (newText) {
                      setState(() {
                        messages[index]['editableText'] = newText;
                      });
                    },
                    () => _showSectionDialog(message['editableText']),
                  );
                }
              },
            ),
          ),

          // Input
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Ask for resume suggestions...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onSubmitted: (_) => sendMessage(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => _buildPromptTemplates(),
          );
        },
        child: Icon(Icons.lightbulb_outline),
        tooltip: 'Prompt Templates',
      ),
    );
  }

  Widget _buildPromptTemplates() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Resume Prompt Templates',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildPromptChip(
                  "Write a professional summary for a [job title] with [years] years of experience"),
              _buildPromptChip(
                  "Improve this work experience bullet point: [your current bullet point]"),
              _buildPromptChip("Suggest skills for a [job title] position"),
              _buildPromptChip(
                  "Help me describe my education at [school name]"),
              _buildPromptChip(
                  "Make this project description more impactful: [your current description]"),
              _buildPromptChip(
                  "Suggest action verbs for my work experience section"),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPromptChip(String text) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        Navigator.pop(context);
        _messageController.text = text;
        sendMessage();
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'resume_selection.dart'; // Update with your correct path

enum MessageType {
  userMessage,
  aiResponse,
  resumeSuggestion,
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  bool isLoading = false;
  final List<String> _predefinedQuestions = [
    "Help me write a professional summary",
    "Suggest bullet points for my work experience",
    "Improve my project description",
    "Make my skills section more impactful",
    "Help me describe my education background"
  ];

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    if (FirebaseAuth.instance.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please sign in to save suggestions')),
        );
      });
    }
  }

  Future<void> sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    // Add user message to chat
    setState(() {
      messages.add({
        'text': message,
        'type': MessageType.userMessage,
      });
      isLoading = true;
      _messageController.clear();
    });

    try {
      final response = await http
          .post(
            Uri.parse('http://192.168.1.7:5000/chat'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'user_id': user.uid,
              'message': message,
            }),
          )
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);
      final rawResponse = data['reply']?.toString() ?? 'No response';

      setState(() {
        // Check if this is a resume suggestion or regular chat
        bool isResumeSuggestion = message.toLowerCase().contains('resume') ||
            message.toLowerCase().contains('summary') ||
            message.toLowerCase().contains('experience') ||
            message.toLowerCase().contains('education') ||
            message.toLowerCase().contains('skill');

        if (isResumeSuggestion) {
          // Parse as resume suggestions
          final suggestionList = rawResponse
              .split(RegExp(r'(?<=[.!?])\s+'))
              .where((s) => s.trim().isNotEmpty)
              .take(3)
              .toList();

          for (var suggestion in suggestionList) {
            messages.add({
              'text': suggestion,
              'type': MessageType.resumeSuggestion,
              'editableText': suggestion, // For editing
            });
          }
        } else {
          // Regular chat response
          messages.add({
            'text': rawResponse,
            'type': MessageType.aiResponse,
          });
        }

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        messages.add({
          'text': "Error: ${e.toString()}",
          'type': MessageType.aiResponse,
        });
      });
    }
  }

  Future<void> _showSectionDialog(String content) async {
    final section = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Save to Section"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildSectionTile("Experience", Icons.work_outline),
              _buildSectionTile("Education", Icons.school_outlined),
              _buildSectionTile("Projects", Icons.code_outlined),
              _buildSectionTile("Skills", Icons.build_outlined),
              _buildSectionTile("Certificates", Icons.verified_outlined),
              _buildSectionTile("Summary", Icons.description_outlined),
            ],
          ),
        ),
      ),
    );

    if (section != null) {
      await _saveToSection(content, section.toLowerCase());
    }
  }

  Widget _buildSectionTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => Navigator.pop(context, title),
    );
  }

  Future<void> _saveToSection(String content, String section) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final docRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      // First get the current document to check if the section exists
      final docSnapshot = await docRef.get();
      final sectionData = docSnapshot.data();

      // Prepare the data to be added/updated
      final data = {
        'content': content,
        'is_ai_generated': true,
        //'created_at': FieldValue.serverTimestamp(),
      };

      // For skills and certificates, we handle them differently
      if (section == 'skills') {
        await docRef.update({
          'technicalSkills': FieldValue.arrayUnion([
            {
              'skill': content,
              'is_ai_generated': true,
              'created_at': FieldValue.serverTimestamp(),
            }
          ])
        });
      } else if (section == 'certificates') {
        await docRef.update({
          'certificates': FieldValue.arrayUnion([
            {
              'name': content,
              'is_ai_generated': true,
              'created_at': FieldValue.serverTimestamp(),
            }
          ])
        });
      } else if (section == 'summary') {
        await docRef.update({
          'selected_summary': content,
          'is_ai_summary': true,
        });
      } else {
        // For other sections (experience, education, projects)
        // Check if the section exists in the document
        if (sectionData != null && sectionData.containsKey(section)) {
          // Section exists - add to existing array
          await docRef.update({
            section: FieldValue.arrayUnion([data])
          });
        } else {
          // Section doesn't exist - create new array with this item
          await docRef.set({
            section: [data]
          }, SetOptions(merge: true));
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved to $section section!')),
        );
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Firestore error: ${e.message}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  Widget _buildUserMessage(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildAiMessage(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildSuggestionMessage(
    String originalText,
    String editableText,
    Function(String) onTextChanged,
    Function() onSave,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Resume Suggestion:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: editableText),
              maxLines: 3,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8)),
              onChanged: onTextChanged,
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onSave,
                child: Text('Save to Resume'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptTemplates() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text('Quick Suggestions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              )),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildPromptChip("Professional summary for [job title]"),
              _buildPromptChip("Improve this work experience..."),
              _buildPromptChip("Skills for [job title] position"),
              _buildPromptChip("Describe education at [school]"),
              _buildPromptChip("Make project description stronger"),
              _buildPromptChip("Action verbs for work experience"),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPromptChip(String text) {
    return ActionChip(
      label: Text(text, style: TextStyle(fontSize: 13)),
      backgroundColor: Colors.blue[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: () {
        Navigator.pop(context);
        _messageController.text = text;
        sendMessage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Builder Assistant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() => messages.clear()),
            tooltip: 'Clear chat',
          ),
          TextButton.icon(
            icon: Icon(Icons.description,
                color: const Color.fromARGB(255, 11, 10, 10)),
            label: Text("Templates",
                style: TextStyle(color: const Color.fromARGB(255, 11, 10, 10))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResumeSelectionScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Predefined questions
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              children: _predefinedQuestions.map((question) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    label: Text(question),
                    onPressed: () {
                      _messageController.text = question;
                      sendMessage();
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length && isLoading) {
                  return _buildTypingIndicator();
                }

                final message = messages[index];

                if (message['type'] == MessageType.userMessage) {
                  return _buildUserMessage(message['text']);
                } else if (message['type'] == MessageType.aiResponse) {
                  return _buildAiMessage(message['text']);
                } else {
                  return _buildSuggestionMessage(
                    message['text'],
                    message['editableText'],
                    (newText) {
                      setState(() {
                        messages[index]['editableText'] = newText;
                      });
                    },
                    () => _showSectionDialog(message['editableText']),
                  );
                }
              },
            ),
          ),

          // Input with send and suggestion icons
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Bulb/Suggestion Icon
                IconButton(
                  icon: Icon(Icons.lightbulb_outline),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => _buildPromptTemplates(),
                    );
                  },
                ),
                // Expanded Text Field
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Ask for resume suggestions...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),
                // Send Icon
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
*/

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'resume_selection.dart';

// enum MessageType {
//   userMessage,
//   aiResponse,
//   resumeSuggestion,
// }

// class ChatbotPage extends StatefulWidget {
//   const ChatbotPage({Key? key}) : super(key: key);

//   @override
//   _ChatbotPageState createState() => _ChatbotPageState();
// }

// class _ChatbotPageState extends State<ChatbotPage> {
//   final TextEditingController _messageController = TextEditingController();
//   List<Map<String, dynamic>> messages = [];
//   bool isLoading = false;
//   final List<String> _predefinedQuestions = [
//     "Help me write a professional summary",
//     "Suggest bullet points for my work experience",
//     "Improve my project description",
//     "Make my skills section more impactful",
//     "Help me describe my education background"
//   ];

//   // UI Builder Methods
//   Widget _buildTypingIndicator() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 8,
//               height: 8,
//               margin: const EdgeInsets.only(right: 4),
//               decoration: BoxDecoration(
//                 color: Colors.grey[400],
//                 shape: BoxShape.circle,
//               ),
//             ),
//             Container(
//               width: 8,
//               height: 8,
//               margin: const EdgeInsets.only(right: 4),
//               decoration: BoxDecoration(
//                 color: Colors.grey[400],
//                 shape: BoxShape.circle,
//               ),
//             ),
//             Container(
//               width: 8,
//               height: 8,
//               decoration: BoxDecoration(
//                 color: Colors.grey[400],
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildUserMessage(String text) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.blue[100],
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(12),
//             bottomLeft: Radius.circular(12),
//             bottomRight: Radius.circular(12),
//           ),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(color: Colors.black),
//         ),
//       ),
//     );
//   }

//   Widget _buildAiMessage(String text) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: const BorderRadius.only(
//             topRight: Radius.circular(12),
//             bottomLeft: Radius.circular(12),
//             bottomRight: Radius.circular(12),
//           ),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(color: Colors.black),
//         ),
//       ),
//     );
//   }

//   Widget _buildSuggestionMessage(
//     String originalText,
//     String editableText,
//     Function(String) onTextChanged,
//     Function() onSave,
//   ) {
//     final textController = TextEditingController(text: editableText);

//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Resume Suggestion:',
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             TextField(
//               controller: textController,
//               maxLines: 3,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.all(8),
//               ),
//               onChanged: onTextChanged,
//             ),
//             const SizedBox(height: 8),
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: onSave,
//                 child: const Text('Save to Resume'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPromptTemplates() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 40,
//             height: 4,
//             margin: const EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//           Text('Quick Suggestions',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue[800],
//               )),
//           const SizedBox(height: 16),
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: [
//               _buildPromptChip("Professional summary for [job title]"),
//               _buildPromptChip("Improve this work experience..."),
//               _buildPromptChip("Skills for [job title] position"),
//               _buildPromptChip("Describe education at [school]"),
//               _buildPromptChip("Make project description stronger"),
//               _buildPromptChip("Action verbs for work experience"),
//             ],
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }

//   Widget _buildPromptChip(String text) {
//     return ActionChip(
//       label: Text(text, style: const TextStyle(fontSize: 13)),
//       backgroundColor: Colors.blue[50],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       onPressed: () {
//         Navigator.pop(context);
//         _messageController.text = text;
//         sendMessage();
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _checkAuthStatus();
//   }

//   void _checkAuthStatus() {
//     if (FirebaseAuth.instance.currentUser == null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Please sign in to save suggestions')),
//         );
//       });
//     }
//   }

//   Future<void> sendMessage() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;

//     final message = _messageController.text.trim();
//     if (message.isEmpty) return;

//     setState(() {
//       messages.add({
//         'text': message,
//         'type': MessageType.userMessage,
//       });
//       isLoading = true;
//       _messageController.clear();
//     });

//     try {
//       final response = await http
//           .post(
//             Uri.parse('http://192.168.79.98:5000/chat'),
//             headers: {'Content-Type': 'application/json'},
//             body: jsonEncode({
//               'user_id': user.uid,
//               'message': message,
//             }),
//           )
//           .timeout(const Duration(seconds: 15));

//       final data = jsonDecode(response.body);
//       final rawResponse = data['reply']?.toString() ?? 'No response';

//       setState(() {
//         bool isResumeSuggestion = message.toLowerCase().contains('resume') ||
//             message.toLowerCase().contains('summary') ||
//             message.toLowerCase().contains('experience') ||
//             message.toLowerCase().contains('education') ||
//             message.toLowerCase().contains('skill');

//         if (isResumeSuggestion) {
//           final suggestionList = rawResponse
//               .split(RegExp(r'(?<=[.!?])\s+'))
//               .where((s) => s.trim().isNotEmpty)
//               .take(3)
//               .toList();

//           for (var suggestion in suggestionList) {
//             messages.add({
//               'text': suggestion,
//               'type': MessageType.resumeSuggestion,
//               'editableText': suggestion,
//             });
//           }
//         } else {
//           messages.add({
//             'text': rawResponse,
//             'type': MessageType.aiResponse,
//           });
//         }
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         messages.add({
//           'text': "Error: ${e.toString()}",
//           'type': MessageType.aiResponse,
//         });
//       });
//     }
//   }

//   Future<void> _showSectionDialog(String content) async {
//     final section = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Save to Section"),
//         content: SizedBox(
//           width: double.maxFinite,
//           child: ListView(
//             shrinkWrap: true,
//             children: [
//               _buildSectionTile("Experience", Icons.work_outline),
//               _buildSectionTile("Education", Icons.school_outlined),
//               _buildSectionTile("Projects", Icons.code_outlined),
//               _buildSectionTile("Skills", Icons.build_outlined),
//               _buildSectionTile("Certificates", Icons.verified_outlined),
//               _buildSectionTile("Summary", Icons.description_outlined),
//             ],
//           ),
//         ),
//       ),
//     );

//     if (section != null) {
//       await _saveToSection(content, section.toLowerCase());
//     }
//   }

//   Widget _buildSectionTile(String title, IconData icon) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title),
//       onTap: () => Navigator.pop(context, title),
//     );
//   }

//   Future<void> _saveToSection(String content, String section) async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) throw Exception('User not authenticated');

//       final docRef =
//           FirebaseFirestore.instance.collection('users').doc(user.uid);
//       final docSnapshot = await docRef.get();
//       final sectionData = docSnapshot.data();

//       final data = {
//         'content': content,
//         'is_ai_generated': true,
//         // 'created_at': FieldValue.serverTimestamp(),
//       };

//       if (section == 'education') {
//         final educationData = _parseEducationContent(content);

//         await docRef.update({
//           'education': FieldValue.arrayUnion([
//             {
//               ...educationData,
//               'content': content,
//               'is_ai_generated': true,
//               // 'created_at': FieldValue.serverTimestamp(),
//             }
//           ])
//         });
//       } else if (section == 'skills') {
//         await docRef.update({
//           'technicalSkills': FieldValue.arrayUnion([
//             {
//               'skill': content,
//               'is_ai_generated': true,
//               //  'created_at': FieldValue.serverTimestamp(),
//             }
//           ])
//         });
//       } else if (section == 'certificates') {
//         await docRef.update({
//           'certificates': FieldValue.arrayUnion([
//             {
//               'name': content,
//               'is_ai_generated': true,
//               // 'created_at': FieldValue.serverTimestamp(),
//             }
//           ])
//         });
//       } else if (section == 'summary') {
//         await docRef.update({
//           'selected_summary': content,
//           'is_ai_summary': true,
//         });
//       } else {
//         if (sectionData != null && sectionData.containsKey(section)) {
//           await docRef.update({
//             section: FieldValue.arrayUnion([data])
//           });
//         } else {
//           await docRef.set({
//             section: [data]
//           }, SetOptions(merge: true));
//         }
//       }

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Saved to $section section!')),
//         );
//       }
//     } on FirebaseException catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Firestore error: ${e.message}')),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${e.toString()}')),
//         );
//       }
//     }
//   }

//   Map<String, dynamic> _parseEducationContent(String content) {
//     Map<String, dynamic> educationData = {
//       'Qualification': '',
//       'Institution': '',
//       'Join Date': '',
//       'Completion Date': '',
//     };

//     try {
//       final dateRegex = RegExp(r'([A-Za-z]+ \d{1,2}, \d{4})');
//       final dates = dateRegex.allMatches(content).toList();

//       if (dates.length >= 2) {
//         educationData['Join Date'] = dates[0].group(0);
//         educationData['Completion Date'] = dates[1].group(0);
//       }

//       final institutionRegex = RegExp(r'at ([A-Za-z ]+) \(');
//       final institutionMatch = institutionRegex.firstMatch(content);
//       if (institutionMatch != null) {
//         educationData['Institution'] = institutionMatch.group(1)?.trim() ?? '';
//       }

//       final qualRegex = RegExp(r'([A-Za-z]+ of [A-Za-z]+) in');
//       final qualMatch = qualRegex.firstMatch(content);
//       if (qualMatch != null) {
//         educationData['Qualification'] = qualMatch.group(1)?.trim() ?? '';
//       }
//     } catch (e) {
//       print('Error parsing education content: $e');
//     }

//     return educationData;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Resume Builder Assistant'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () => setState(() => messages.clear()),
//             tooltip: 'Clear chat',
//           ),
//           TextButton.icon(
//             icon: const Icon(Icons.description, color: Colors.black),
//             label:
//                 const Text("Templates", style: TextStyle(color: Colors.black)),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ResumeSelectionScreen(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 60,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.all(12),
//               children: _predefinedQuestions.map((question) {
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 8),
//                   child: ActionChip(
//                     label: Text(question),
//                     onPressed: () {
//                       _messageController.text = question;
//                       sendMessage();
//                     },
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: messages.length + (isLoading ? 1 : 0),
//               itemBuilder: (context, index) {
//                 if (index == messages.length && isLoading) {
//                   return _buildTypingIndicator();
//                 }
//                 final message = messages[index];
//                 if (message['type'] == MessageType.userMessage) {
//                   return _buildUserMessage(message['text']);
//                 } else if (message['type'] == MessageType.aiResponse) {
//                   return _buildAiMessage(message['text']);
//                 } else {
//                   return _buildSuggestionMessage(
//                     message['text'],
//                     message['editableText'],
//                     (newText) {
//                       setState(() {
//                         messages[index]['editableText'] = newText;
//                       });
//                     },
//                     () => _showSectionDialog(message['editableText']),
//                   );
//                 }
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.lightbulb_outline),
//                   onPressed: () {
//                     showModalBottomSheet(
//                       context: context,
//                       builder: (context) => _buildPromptTemplates(),
//                     );
//                   },
//                 ),
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: "Ask for resume suggestions...",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                     ),
//                     onSubmitted: (_) => sendMessage(),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }
// }

/*working correct code


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum MessageType {
  userMessage,
  aiResponse,
  resumeContentSuggestion,
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  bool isLoading = false;

  final List<String> _contentSuggestionQuestions = [
    "Help me write a professional summary",
    "Suggest bullet points for my work experience",
    "Improve my project description",
    "Help me describe my education background"
  ];

  // UI Builder Methods
  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTypingDot(),
          const SizedBox(width: 4),
          _buildTypingDot(),
          const SizedBox(width: 4),
          _buildTypingDot(),
        ],
      ),
    );
  }

  Widget _buildTypingDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildUserMessage(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildAiMessage(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildContentSuggestionMessage(
    String text,
    String editableText,
    Function(String) onTextChanged,
    Function() onSave,
  ) {
    final textController = TextEditingController(text: editableText);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Perfect Resume Suggestion:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                )),
            const SizedBox(height: 8),
            TextField(
              controller: textController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(8),
              ),
              onChanged: onTextChanged,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onSave,
                child: const Text('Save to Resume'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      messages.add({
        'text': message,
        'type': MessageType.userMessage,
      });
      isLoading = true;
      _messageController.clear();
    });

    try {
      // Get user's existing resume data
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final resumeData = doc.data() ?? {};

      final response = await http
          .post(
            Uri.parse('http://192.168.79.98:5000/chat'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'user_id': user.uid,
              'message': message,
              'resume_data': {
                'education': resumeData['education'] ?? [],
                'experience': resumeData['experience'] ?? [],
                'projects': resumeData['projects'] ?? [],
              },
            }),
          )
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);
      final rawResponse = data['reply']?.toString() ?? 'No response';

      setState(() {
        if (_contentSuggestionQuestions.contains(message)) {
          messages.add({
            'text': rawResponse,
            'type': MessageType.resumeContentSuggestion,
            'editableText': rawResponse,
          });
        } else {
          messages.add({
            'text': rawResponse,
            'type': MessageType.aiResponse,
          });
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        messages.add({
          'text': "Error: ${e.toString()}",
          'type': MessageType.aiResponse,
        });
      });
    }
  }

  Future<void> _showSectionDialog(String content) async {
    final section = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Save to Section"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSectionTile("Experience", Icons.work),
            _buildSectionTile("Education", Icons.school),
            _buildSectionTile("Projects", Icons.code),
            _buildSectionTile("Summary", Icons.description),
          ],
        ),
      ),
    );

    if (section != null) {
      await _saveToSection(content, section.toLowerCase());
    }
  }

  Widget _buildSectionTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => Navigator.pop(context, title),
    );
  }

  Future<void> _saveToSection(String content, String section) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final docRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      if (section == 'summary') {
        await docRef.update({
          'summary': content,
          'is_ai_generated': true,
        });
      } else {
        await docRef.update({
          section: FieldValue.arrayUnion([
            {
              'content': content,
              'is_ai_generated': true,
              // 'created_at': FieldValue.serverTimestamp(),
            }
          ])
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved to $section section!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Assistant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() => messages.clear()),
          ),
        ],
      ),
      body: Column(
        children: [
          // Predefined questions
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              children: _contentSuggestionQuestions.map((question) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    label: Text(question),
                    backgroundColor: Colors.blue[50],
                    onPressed: () {
                      _messageController.text = question;
                      sendMessage();
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length && isLoading) {
                  return _buildTypingIndicator();
                }
                final message = messages[index];
                switch (message['type']) {
                  case MessageType.userMessage:
                    return _buildUserMessage(message['text']);
                  case MessageType.aiResponse:
                    return _buildAiMessage(message['text']);
                  case MessageType.resumeContentSuggestion:
                    return _buildContentSuggestionMessage(
                      message['text'],
                      message['editableText'],
                      (newText) =>
                          setState(() => message['editableText'] = newText),
                      () => _showSectionDialog(message['editableText']),
                    );
                  default:
                    return _buildAiMessage(message['text']);
                }
              },
            ),
          ),
          // Input area
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Ask about your resume...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
*/

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'resume_selection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum MessageType {
  userMessage,
  aiResponse,
  resumeContentSuggestion,
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  bool isLoading = false;
  bool showBulbPrompts = true;

  final List<String> _contentSuggestionQuestions = [
    "Help me describe my education background",
    "Suggest bullet points for my work experience",
    "Improve my project description",
    "Help me write a professional summary"
  ];

  final List<String> _resumeAdvicePrompts = [
    "How can I make my resume stand out?",
    "What's the best resume format?",
    "How long should my resume be?",
    "Should I include references on my resume?",
    "What skills should I highlight?",
    "How to tailor my resume for a specific job?",
    "What font size should I use?",
    "Should I include a photo on my resume?",
    "How to handle employment gaps?",
    "What's better: chronological or functional resume?"
  ];

  // UI Builder Methods
  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTypingDot(),
          const SizedBox(width: 4),
          _buildTypingDot(),
          const SizedBox(width: 4),
          _buildTypingDot(),
        ],
      ),
    );
  }

  Widget _buildTypingDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildUserMessage(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildAiMessage(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildContentSuggestionMessage(
    String text,
    String editableText,
    Function(String) onTextChanged,
    Function() onSave,
  ) {
    final textController = TextEditingController(text: editableText);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Perfect Resume Suggestion:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                )),
            const SizedBox(height: 8),
            TextField(
              controller: textController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(8),
              ),
              onChanged: onTextChanged,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onSave,
                child: const Text('Save to Resume'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulbPrompts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: Colors.amber),
              const SizedBox(width: 8),
              const Text(
                'Resume Advice Prompts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    showBulbPrompts = false;
                  });
                },
                iconSize: 20,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _resumeAdvicePrompts.map((prompt) {
              return ActionChip(
                label: Text(prompt),
                backgroundColor: Colors.amber[50],
                onPressed: () {
                  _messageController.text = prompt;
                  sendMessage();
                  setState(() {
                    showBulbPrompts = false;
                  });
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Future<void> sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      messages.add({
        'text': message,
        'type': MessageType.userMessage,
      });
      isLoading = true;
      _messageController.clear();
    });

    try {
      // Get user's existing resume data
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final resumeData = doc.data() ?? {};

      final response = await http
          .post(
            Uri.parse('http://192.168.79.98:5000/chat'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'user_id': user.uid,
              'message': message,
              'resume_data': {
                'education': resumeData['education'] ?? [],
                'experience': resumeData['experience'] ?? [],
                'projects': resumeData['projects'] ?? [],
              },
            }),
          )
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);
      final rawResponse = data['reply']?.toString() ?? 'No response';

      setState(() {
        if (_contentSuggestionQuestions.contains(message)) {
          messages.add({
            'text': rawResponse,
            'type': MessageType.resumeContentSuggestion,
            'editableText': rawResponse,
          });
        } else {
          messages.add({
            'text': rawResponse,
            'type': MessageType.aiResponse,
          });
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        messages.add({
          'text': "Error: ${e.toString()}",
          'type': MessageType.aiResponse,
        });
      });
    }
  }

  Future<void> _showSectionDialog(String content) async {
    final section = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Save to Section"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSectionTile("Experience", Icons.work),
            _buildSectionTile("Education", Icons.school),
            _buildSectionTile("Projects", Icons.code),
            _buildSectionTile("Summary", Icons.description),
          ],
        ),
      ),
    );

    if (section != null) {
      await _saveToSection(content, section.toLowerCase());
    }
  }

  Widget _buildSectionTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => Navigator.pop(context, title),
    );
  }

  Future<void> _saveToSection(String content, String section) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final docRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      if (section == 'summary') {
        await docRef.update({
          'summary': content,
          'is_ai_generated': true,
        });
      } else {
        await docRef.update({
          section: FieldValue.arrayUnion([
            {
              'content': content,
              'is_ai_generated': true,
              // 'created_at': FieldValue.serverTimestamp(),
            }
          ])
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved to $section section!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Assistant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {
              messages.clear();
              showBulbPrompts = true;
            }),
          ),
          IconButton(
            icon: const Row(
              children: [
                Icon(Icons.insert_drive_file),
                SizedBox(width: 4),
                Text('Templates'),
              ],
            ),
            onPressed: () {
              // Navigate to templates page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (ResumeSelectionScreen())));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Predefined questions
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              children: _contentSuggestionQuestions.map((question) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    label: Text(question),
                    backgroundColor: Colors.blue[50],
                    onPressed: () {
                      _messageController.text = question;
                      sendMessage();
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length +
                  (isLoading ? 1 : 0) +
                  (showBulbPrompts ? 1 : 0),
              itemBuilder: (context, index) {
                if (showBulbPrompts && index == 0) {
                  return _buildBulbPrompts();
                }

                final adjustedIndex = showBulbPrompts ? index - 1 : index;

                if (adjustedIndex == messages.length && isLoading) {
                  return _buildTypingIndicator();
                }
                final message = messages[adjustedIndex];
                switch (message['type']) {
                  case MessageType.userMessage:
                    return _buildUserMessage(message['text']);
                  case MessageType.aiResponse:
                    return _buildAiMessage(message['text']);
                  case MessageType.resumeContentSuggestion:
                    return _buildContentSuggestionMessage(
                      message['text'],
                      message['editableText'],
                      (newText) =>
                          setState(() => message['editableText'] = newText),
                      () => _showSectionDialog(message['editableText']),
                    );
                  default:
                    return _buildAiMessage(message['text']);
                }
              },
            ),
          ),
          // Input area
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Ask about your resume...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.lightbulb_outline,
                            color: Colors.amber),
                        onPressed: () {
                          setState(() {
                            showBulbPrompts = !showBulbPrompts;
                          });
                        },
                      ),
                    ),
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
