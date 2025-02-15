/*import 'package:flutter/material.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  bool _isEditing = false;
  List<String> softSkills = [];
  List<String> technicalSkills = [];

  final TextEditingController _softSkillController = TextEditingController();
  final TextEditingController _technicalSkillController =
      TextEditingController();

  void _addSoftSkill() {
    if (_softSkillController.text.isNotEmpty) {
      setState(() {
        softSkills.add(_softSkillController.text);
        _softSkillController.clear();
      });
    }
  }

  void _addTechnicalSkill() {
    if (_technicalSkillController.text.isNotEmpty) {
      setState(() {
        technicalSkills.add(_technicalSkillController.text);
        _technicalSkillController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skills')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isEditing) ...[
              _buildField('Soft Skill', _softSkillController, _addSoftSkill),
              const SizedBox(height: 5),
              _buildField('Technical Skill', _technicalSkillController,
                  _addTechnicalSkill),
              const SizedBox(height: 10),
            ],
            const Text('Soft Skills:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            softSkills.isEmpty
                ? const Text('No soft skills added.',
                    style: TextStyle(fontSize: 16))
                : Column(
                    children: softSkills.map((skill) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(title: Text(skill)),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 10),
            const Text('Technical Skills:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            technicalSkills.isEmpty
                ? const Text('No technical skills added.',
                    style: TextStyle(fontSize: 16))
                : Column(
                    children: technicalSkills.map((skill) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(title: Text(skill)),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  child: Text(_isEditing ? 'Save' : 'Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the next page (e.g., Projects, Summary, etc.)
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
      String label, TextEditingController controller, VoidCallback onPressed) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text('Add'),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'projects_page.dart'; // Import ProjectsPage

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  bool _isEditing = false;
  List<String> softSkills = [];
  List<String> technicalSkills = [];

  final TextEditingController _softSkillController = TextEditingController();
  final TextEditingController _technicalSkillController =
      TextEditingController();

  void _addSoftSkill() {
    if (_softSkillController.text.isNotEmpty) {
      setState(() {
        softSkills.add(_softSkillController.text);
        _softSkillController.clear();
      });
    }
  }

  void _addTechnicalSkill() {
    if (_technicalSkillController.text.isNotEmpty) {
      setState(() {
        technicalSkills.add(_technicalSkillController.text);
        _technicalSkillController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skills')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isEditing) ...[
              _buildField('Soft Skill', _softSkillController, _addSoftSkill),
              const SizedBox(height: 5),
              _buildField('Technical Skill', _technicalSkillController,
                  _addTechnicalSkill),
              const SizedBox(height: 10),
            ],
            const Text('Soft Skills:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            softSkills.isEmpty
                ? const Text('No soft skills added.',
                    style: TextStyle(fontSize: 16))
                : Column(
                    children: softSkills.map((skill) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(title: Text(skill)),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 10),
            const Text('Technical Skills:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            technicalSkills.isEmpty
                ? const Text('No technical skills added.',
                    style: TextStyle(fontSize: 16))
                : Column(
                    children: technicalSkills.map((skill) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(title: Text(skill)),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  child: Text(_isEditing ? 'Save' : 'Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProjectsPage()),
                    );
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
      String label, TextEditingController controller, VoidCallback onPressed) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text('Add'),
        ),
      ],
    );
  }
}*/

/*

import 'package:flutter/material.dart';
import 'projects_page.dart'; // Import ProjectsPage

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  List<String> softSkills = [];
  List<String> technicalSkills = [];

  final TextEditingController _softSkillController = TextEditingController();
  final TextEditingController _technicalSkillController =
      TextEditingController();

  void _addSoftSkill() {
    if (_softSkillController.text.isNotEmpty) {
      setState(() {
        softSkills.add(_softSkillController.text);
        _softSkillController.clear();
      });
    }
  }

  void _addTechnicalSkill() {
    if (_technicalSkillController.text.isNotEmpty) {
      setState(() {
        technicalSkills.add(_technicalSkillController.text);
        _technicalSkillController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFF97C4B8)], // Gradient Background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'SKILLS',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Soft Skills Section
            const Text('Soft skills',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            _buildTextField(_softSkillController),
            _buildAddButton(_addSoftSkill),
            const SizedBox(height: 15),

            // Technical Skills Section
            const Text('Technical skills',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            _buildTextField(_technicalSkillController),
            _buildAddButton(_addTechnicalSkill),

            const SizedBox(height: 20),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('Edit', () {
                  setState(() {});
                }),
                _buildButton('Continue', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProjectsPage()),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Input Field Widget
  Widget _buildTextField(TextEditingController controller) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
      ),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // "+ Add" Button Widget
  Widget _buildAddButton(VoidCallback onPressed) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add, color: Color(0xFF184D47)),
      label: const Text('+ Add',
          style:
              TextStyle(color: Color(0xFF184D47), fontWeight: FontWeight.bold)),
    );
  }

  // Bottom Buttons Widget
  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF184D47),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
} // add and listing not working

*/
/*
import 'package:flutter/material.dart';
import 'projects_page.dart'; // Import ProjectsPage

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  bool _isEditing = false;
  List<String> softSkills = []; // Default soft skills
  List<String> technicalSkills = []; // Default technical skills

  final TextEditingController _softSkillController = TextEditingController();
  final TextEditingController _technicalSkillController =
      TextEditingController();

  void _addSoftSkill() {
    if (_softSkillController.text.isNotEmpty) {
      setState(() {
        softSkills.add(_softSkillController.text);
        _softSkillController.clear();
      });
    }
  }

  void _addTechnicalSkill() {
    if (_technicalSkillController.text.isNotEmpty) {
      setState(() {
        technicalSkills.add(_technicalSkillController.text);
        _technicalSkillController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFF97C4B8)], // Gradient Background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'SKILLS',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Soft Skills Section
            const Text('Soft skills',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            if (_isEditing) _buildTextField(_softSkillController),
            if (_isEditing) _buildAddButton(_addSoftSkill),
            _buildSkillList(softSkills),

            const SizedBox(height: 15),

            // Technical Skills Section
            const Text('Technical skills',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            if (_isEditing) _buildTextField(_technicalSkillController),
            if (_isEditing) _buildAddButton(_addTechnicalSkill),
            _buildSkillList(technicalSkills),

            const SizedBox(height: 20),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(_isEditing ? 'Save' : 'Edit', () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                }),
                _buildButton('Continue', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProjectsPage()),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Input Field Widget
  Widget _buildTextField(TextEditingController controller) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
      ),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // "+ Add" Button Widget
  Widget _buildAddButton(VoidCallback onPressed) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add, color: Color(0xFF184D47)),
      label: const Text('+ Add',
          style:
              TextStyle(color: Color(0xFF184D47), fontWeight: FontWeight.bold)),
    );
  }

  // Skill List Display
  Widget _buildSkillList(List<String> skills) {
    return skills.isEmpty
        ? const Text('No skills added.', style: TextStyle(fontSize: 16))
        : Column(
            children: skills.map((skill) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text(skill),
                  trailing: _isEditing
                      ? IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              skills.remove(skill);
                            });
                          },
                        )
                      : null,
                ),
              );
            }).toList(),
          );
  }

  // Bottom Buttons Widget
  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF184D47),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'projects_page.dart'; // Import ProjectsPage

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isEditing = false;
  List<String> softSkills = []; // Default soft skills
  List<String> technicalSkills = []; // Default technical skills

  final TextEditingController _softSkillController = TextEditingController();
  final TextEditingController _technicalSkillController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchSkillsData(); // Fetch skills data when the page loads
  }

  /// Fetch user's skills data from Firestore
  Future<void> _fetchSkillsData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        softSkills = List<String>.from(data['softSkills'] ?? []);
        technicalSkills = List<String>.from(data['technicalSkills'] ?? []);
      });
    }
  }

  /// Save skills data to Firestore
  Future<void> _saveSkillsData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'softSkills': softSkills,
      'technicalSkills': technicalSkills,
    }, SetOptions(merge: true)); // Merge to avoid overwriting other fields
  }

  void _addSoftSkill() {
    if (_softSkillController.text.isNotEmpty) {
      setState(() {
        softSkills.add(_softSkillController.text);
        _softSkillController.clear();
      });
      _saveSkillsData(); // Save to Firestore
    }
  }

  void _addTechnicalSkill() {
    if (_technicalSkillController.text.isNotEmpty) {
      setState(() {
        technicalSkills.add(_technicalSkillController.text);
        _technicalSkillController.clear();
      });
      _saveSkillsData(); // Save to Firestore
    }
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
                      'SKILLS',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Soft Skills Section
                  const Text('Soft skills',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  if (_isEditing) _buildTextField(_softSkillController),
                  if (_isEditing) _buildAddButton(_addSoftSkill),
                  _buildSkillList(softSkills),

                  const SizedBox(height: 15),

                  // Technical Skills Section
                  const Text('Technical skills',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  if (_isEditing) _buildTextField(_technicalSkillController),
                  if (_isEditing) _buildAddButton(_addTechnicalSkill),
                  _buildSkillList(technicalSkills),

                  const SizedBox(height: 20),

                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton(_isEditing ? 'Save' : 'Edit', () {
                        setState(() {
                          _isEditing = !_isEditing;
                        });
                      }),
                      _buildButton('Continue', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectsPage()),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Input Field Widget
  Widget _buildTextField(TextEditingController controller) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
      ),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // "+ Add" Button Widget
  Widget _buildAddButton(VoidCallback onPressed) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add, color: Color(0xFF184D47)),
      label: const Text('Add',
          style:
              TextStyle(color: Color(0xFF184D47), fontWeight: FontWeight.bold)),
    );
  }

  // Skill List Display
  Widget _buildSkillList(List<String> skills) {
    return skills.isEmpty
        ? const Text('No skills added.', style: TextStyle(fontSize: 16))
        : Column(
            children: skills.map((skill) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text(skill),
                  trailing: _isEditing
                      ? IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              skills.remove(skill);
                              _saveSkillsData(); // Save to Firestore after deletion
                            });
                          },
                        )
                      : null,
                ),
              );
            }).toList(),
          );
  }

  // Bottom Buttons Widget
  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF184D47),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
