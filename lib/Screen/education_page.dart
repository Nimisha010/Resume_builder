/*
import 'package:flutter/material.dart';
import 'experience_page.dart'; // Import ExperiencePage

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  bool _isEditing = false;
  int? _selectedIndex; // Track selected education entry for editing
  List<Map<String, String>> educationList = [];

  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _joinDateController = TextEditingController();
  final TextEditingController _completionDateController =
      TextEditingController();

  /// **Method to add or update education**
  void _saveEducation() {
    if (_qualificationController.text.isNotEmpty &&
        _institutionController.text.isNotEmpty &&
        _joinDateController.text.isNotEmpty &&
        _completionDateController.text.isNotEmpty) {
      setState(() {
        if (_selectedIndex == null) {
          // **Adding a new education entry**
          educationList.add({
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          });
        } else {
          // **Updating an existing entry**
          educationList[_selectedIndex!] = {
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          };
        }
        _clearFields(); // Reset input fields
        _selectedIndex = null; // Reset selection
      });
    }
  }

  /// **Method to edit an existing education entry**
  void _editEducation(int index) {
    setState(() {
      _selectedIndex = index;
      _qualificationController.text = educationList[index]['Qualification']!;
      _institutionController.text = educationList[index]['Institution']!;
      _joinDateController.text = educationList[index]['Join Date']!;
      _completionDateController.text = educationList[index]['Completion Date']!;
      _isEditing = true;
    });
  }

  /// **Method to clear input fields**
  void _clearFields() {
    _qualificationController.clear();
    _institutionController.clear();
    _joinDateController.clear();
    _completionDateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD1D1D1), Color(0xFF4B6965)], // Gray to Green
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'EDUCATION',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF184D47), // Teal color
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildField('Qualification', _qualificationController),
                _buildField('Institution name', _institutionController),
                _buildField('Course join date', _joinDateController),
                _buildField(
                    'Course completion date', _completionDateController),
                const SizedBox(height: 10),

                /// **Add / Update button**
                GestureDetector(
                  onTap: _saveEducation,
                  child: Row(
                    children: [
                      Icon(
                        _selectedIndex == null ? Icons.add : Icons.save,
                        color: const Color(0xFF184D47),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _selectedIndex == null ? 'Add' : 'Update',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF184D47),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                /// **Display Added Education Entries**
                if (educationList.isNotEmpty) ...[
                  const Text(
                    'Added Education:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: educationList.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, String> education = entry.value;
                      return GestureDetector(
                        onTap: () => _editEducation(index), // **Tap to edit**
                        child: Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(
                              '${education['Qualification']} at ${education['Institution']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              'Join: ${education['Join Date']}  |  Completion: ${education['Completion Date']}',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 20),

                /// **Edit and Continue Buttons**
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
                            builder: (context) => ExperiencePage()),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: controller,
              enabled: _isEditing,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 120,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF184D47), // Dark Green
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 2,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'experience_page.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isEditing = false;
  int? _selectedIndex;
  List<Map<String, String>> educationList = [];

  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _joinDateController = TextEditingController();
  final TextEditingController _completionDateController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEducationData();
  }

  /// **Fetch user's education details**
  Future<void> _fetchEducationData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('education')) {
        setState(() {
          educationList = List<Map<String, String>>.from(
            (data['education'] as List).map((e) => Map<String, String>.from(e)),
          );
        });
      }
    }
  }

  /// **Save education data**
  Future<void> _saveEducation() async {
    if (_qualificationController.text.isNotEmpty &&
        _institutionController.text.isNotEmpty &&
        _joinDateController.text.isNotEmpty &&
        _completionDateController.text.isNotEmpty) {
      setState(() {
        if (_selectedIndex == null) {
          educationList.add({
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          });
        } else {
          educationList[_selectedIndex!] = {
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          };
        }
        _clearFields();
        _selectedIndex = null;
      });

      await _updateEducationData();
    }
  }

  /// **Update education data in Firestore**
  Future<void> _updateEducationData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'education': educationList,
    }, SetOptions(merge: true)); // Merge to avoid overwriting other fields
  }

  /// **Edit an existing education entry**
  void _editEducation(int index) {
    setState(() {
      _selectedIndex = index;
      _qualificationController.text = educationList[index]['Qualification']!;
      _institutionController.text = educationList[index]['Institution']!;
      _joinDateController.text = educationList[index]['Join Date']!;
      _completionDateController.text = educationList[index]['Completion Date']!;
      _isEditing = true;
    });
  }

  /// **Clear input fields**
  void _clearFields() {
    _qualificationController.clear();
    _institutionController.clear();
    _joinDateController.clear();
    _completionDateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD1D1D1), Color(0xFF4B6965)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'EDUCATION',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF184D47),
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildField('Qualification', _qualificationController),
                _buildField('Institution name', _institutionController),
                _buildField('Course join date', _joinDateController),
                _buildField(
                    'Course completion date', _completionDateController),
                const SizedBox(height: 10),

                /// **Add / Update button**
                GestureDetector(
                  onTap: _saveEducation,
                  child: Row(
                    children: [
                      Icon(
                        _selectedIndex == null ? Icons.add : Icons.save,
                        color: const Color(0xFF184D47),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _selectedIndex == null ? 'Add' : 'Update',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF184D47),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                /// **Display Added Education Entries**
                if (educationList.isNotEmpty) ...[
                  const Text(
                    'Added Education:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: educationList.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, String> education = entry.value;
                      return GestureDetector(
                        onTap: () => _editEducation(index),
                        child: Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(
                              '${education['Qualification']} at ${education['Institution']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              'Join: ${education['Join Date']}  |  Completion: ${education['Completion Date']}',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 20),

                /// **Edit and Continue Buttons**
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
                            builder: (context) => ExperiencePage()),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            enabled: _isEditing,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }

  /// **Added missing `_buildButton` method**
  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 120,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xFF184D47)),
        child: Text(text,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'experience_page.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isEditing = false;
  int? _selectedIndex;
  List<Map<String, String>> educationList = [];

  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _joinDateController = TextEditingController();
  final TextEditingController _completionDateController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEducationData();
  }

  /// **Fetch user's education details**
  Future<void> _fetchEducationData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('education')) {
        setState(() {
          educationList = List<Map<String, String>>.from(
            (data['education'] as List).map((e) => Map<String, String>.from(e)),
          );
        });
      }
    }
  }

  /// **Save education data**
  Future<void> _saveEducation() async {
    if (_qualificationController.text.isNotEmpty &&
        _institutionController.text.isNotEmpty &&
        _joinDateController.text.isNotEmpty &&
        _completionDateController.text.isNotEmpty) {
      setState(() {
        if (_selectedIndex == null) {
          educationList.add({
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          });
        } else {
          educationList[_selectedIndex!] = {
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          };
        }
        _clearFields();
        _selectedIndex = null;
      });

      await _updateEducationData();
    }
  }

  /// **Update education data in Firestore**
  Future<void> _updateEducationData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'education': educationList,
    }, SetOptions(merge: true)); // Merge to avoid overwriting other fields
  }

  /// **Edit an existing education entry**
  void _editEducation(int index) {
    setState(() {
      _selectedIndex = index;
      _qualificationController.text = educationList[index]['Qualification']!;
      _institutionController.text = educationList[index]['Institution']!;
      _joinDateController.text = educationList[index]['Join Date']!;
      _completionDateController.text = educationList[index]['Completion Date']!;
      _isEditing = true;
    });
  }

  /// **Clear input fields**
  void _clearFields() {
    _qualificationController.clear();
    _institutionController.clear();
    _joinDateController.clear();
    _completionDateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD1D1D1), Color(0xFF4B6965)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              // Add a minimum height to ensure the gradient covers the entire screen
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'EDUCATION',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF184D47),
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildField('Qualification', _qualificationController),
                      _buildField('Institution name', _institutionController),
                      _buildField('Course join date', _joinDateController),
                      _buildField(
                          'Course completion date', _completionDateController),
                      const SizedBox(height: 10),

                      /// **Add / Update button**
                      GestureDetector(
                        onTap: _saveEducation,
                        child: Row(
                          children: [
                            Icon(
                              _selectedIndex == null ? Icons.add : Icons.save,
                              color: const Color(0xFF184D47),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              _selectedIndex == null ? 'Add' : 'Update',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF184D47),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// **Display Added Education Entries**
                      if (educationList.isNotEmpty) ...[
                        const Text(
                          'Added Education:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: educationList.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, String> education = entry.value;
                            return GestureDetector(
                              onTap: () => _editEducation(index),
                              child: Card(
                                color: Colors.white,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  title: Text(
                                    '${education['Qualification']} at ${education['Institution']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Join: ${education['Join Date']}  |  Completion: ${education['Completion Date']}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                      const SizedBox(height: 20),

                      /// **Edit and Continue Buttons**
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
                                  builder: (context) => ExperiencePage()),
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
        ),
      ),
    );
  }

  /// **Added `_buildField` method**
  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            enabled: _isEditing,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **Added `_buildButton` method**
  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 120,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF184D47),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
*/

/*correct one

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'experience_page.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isEditing = false;
  int? _selectedIndex;
  List<Map<String, String>> educationList = [];

  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _joinDateController = TextEditingController();
  final TextEditingController _completionDateController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEducationData();
  }

  Future<void> _fetchEducationData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('education')) {
        setState(() {
          educationList = List<Map<String, String>>.from(
            (data['education'] as List).map((e) => Map<String, String>.from(e)),
          );
        });
      }
    }
  }

  Future<void> _deleteEducation(int index) async {
    setState(() {
      educationList.removeAt(index);
      _selectedIndex = null;
      _clearFields();
    });
    await _updateEducationData();
  }

  Future<void> _saveEducation() async {
    if (_qualificationController.text.isNotEmpty &&
        _institutionController.text.isNotEmpty &&
        _joinDateController.text.isNotEmpty &&
        _completionDateController.text.isNotEmpty) {
      setState(() {
        if (_selectedIndex == null) {
          educationList.add({
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          });
        } else {
          educationList[_selectedIndex!] = {
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          };
        }
        _clearFields();
        _selectedIndex = null;
      });
      await _updateEducationData();
    }
  }

  Future<void> _updateEducationData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'education': educationList,
    }, SetOptions(merge: true));
  }

  void _editEducation(int index) {
    setState(() {
      _selectedIndex = index;
      _qualificationController.text = educationList[index]['Qualification']!;
      _institutionController.text = educationList[index]['Institution']!;
      _joinDateController.text = educationList[index]['Join Date']!;
      _completionDateController.text = educationList[index]['Completion Date']!;
      _isEditing = true;
    });
  }

  void _clearFields() {
    _qualificationController.clear();
    _institutionController.clear();
    _joinDateController.clear();
    _completionDateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD1D1D1), Color(0xFF4B6965)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'EDUCATION',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF184D47),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildField('Qualification', _qualificationController),
                _buildField('Institution name', _institutionController),
                _buildField('Course join date', _joinDateController),
                _buildField(
                    'Course completion date', _completionDateController),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  child: Text(_isEditing ? 'Save' : 'Edit'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveEducation,
                  child: Text(_selectedIndex == null ? 'Add' : 'Update'),
                ),
                const SizedBox(height: 20),
                if (educationList.isNotEmpty) ...[
                  const Text(
                    'Added Education:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: educationList.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, String> education = entry.value;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(
                              '${education['Qualification']} at ${education['Institution']}'),
                          subtitle: Text(
                              'Join: ${education['Join Date']} | Completion: ${education['Completion Date']}'),
                          onTap: () => _editEducation(index),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteEducation(index),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExperiencePage())),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            enabled: _isEditing,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/

/* correct one

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'experience_page.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isEditing = false;
  int? _selectedIndex;
  List<Map<String, String>> educationList = [];

  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _joinDateController = TextEditingController();
  final TextEditingController _completionDateController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEducationData();
  }

  Future<void> _fetchEducationData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('education')) {
        setState(() {
          educationList = List<Map<String, String>>.from(
            (data['education'] as List).map((e) => Map<String, String>.from(e)),
          );
        });
      }
    }
  }

  Future<void> _deleteEducation(int index) async {
    setState(() {
      educationList.removeAt(index);
      _selectedIndex = null;
      _clearFields();
    });
    await _updateEducationData();
  }

  Future<void> _saveEducation() async {
    if (_qualificationController.text.isNotEmpty &&
        _institutionController.text.isNotEmpty &&
        _joinDateController.text.isNotEmpty &&
        _completionDateController.text.isNotEmpty) {
      setState(() {
        if (_selectedIndex == null) {
          educationList.add({
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          });
        } else {
          educationList[_selectedIndex!] = {
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          };
        }
        _clearFields();
        _selectedIndex = null;
      });
      await _updateEducationData();
    }
  }

  Future<void> _updateEducationData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'education': educationList,
    }, SetOptions(merge: true));
  }

  void _editEducation(int index) {
    setState(() {
      _selectedIndex = index;
      _qualificationController.text = educationList[index]['Qualification']!;
      _institutionController.text = educationList[index]['Institution']!;
      _joinDateController.text = educationList[index]['Join Date']!;
      _completionDateController.text = educationList[index]['Completion Date']!;
      _isEditing = true;
    });
  }

  void _clearFields() {
    _qualificationController.clear();
    _institutionController.clear();
    _joinDateController.clear();
    _completionDateController.clear();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text =
            DateFormat('dd/MM/yyyy').format(picked); // Format the date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD1D1D1), Color(0xFF4B6965)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'EDUCATION',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF184D47),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildField('Qualification', _qualificationController),
                _buildField('Institution name', _institutionController),
                _buildDateField('Course join date', _joinDateController),
                _buildDateField(
                    'Course completion date', _completionDateController),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  child: Text(_isEditing ? 'Save' : 'Edit'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveEducation,
                  child: Text(_selectedIndex == null ? 'Add' : 'Update'),
                ),
                const SizedBox(height: 20),
                if (educationList.isNotEmpty) ...[
                  const Text(
                    'Added Education:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: educationList.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, String> education = entry.value;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(
                              '${education['Qualification']} at ${education['Institution']}'),
                          subtitle: Text(
                              'Join: ${education['Join Date']} | Completion: ${education['Completion Date']}'),
                          onTap: () => _editEducation(index),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteEducation(index),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExperiencePage())),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            enabled: _isEditing,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            enabled: _isEditing,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, controller),
              ),
            ),
            readOnly: true, // Prevent manual text input
          ),
        ],
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'experience_page.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isEditing = false;
  int? _selectedIndex;
  List<Map<String, String>> educationList = [];

  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _joinDateController = TextEditingController();
  final TextEditingController _completionDateController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEducationData();
  }

  Future<void> _fetchEducationData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('education')) {
        setState(() {
          educationList = List<Map<String, String>>.from(
            (data['education'] as List).map((e) => Map<String, String>.from(e)),
          );
        });
      }
    }
  }

  Future<void> _deleteEducation(int index) async {
    setState(() {
      educationList.removeAt(index);
      _selectedIndex = null;
      _clearFields();
    });
    await _updateEducationData();
  }

  Future<void> _saveEducation() async {
    if (_qualificationController.text.isNotEmpty &&
        _institutionController.text.isNotEmpty &&
        _joinDateController.text.isNotEmpty &&
        _completionDateController.text.isNotEmpty) {
      setState(() {
        if (_selectedIndex == null) {
          educationList.add({
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          });
        } else {
          educationList[_selectedIndex!] = {
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          };
        }
        _clearFields();
        _selectedIndex = null;
      });
      await _updateEducationData();
    }
  }

  Future<void> _updateEducationData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'education': educationList,
    }, SetOptions(merge: true));
  }

  void _editEducation(int index) {
    setState(() {
      _selectedIndex = index;
      _qualificationController.text = educationList[index]['Qualification']!;
      _institutionController.text = educationList[index]['Institution']!;
      _joinDateController.text = educationList[index]['Join Date']!;
      _completionDateController.text = educationList[index]['Completion Date']!;
      _isEditing = true;
    });
  }

  void _clearFields() {
    _qualificationController.clear();
    _institutionController.clear();
    _joinDateController.clear();
    _completionDateController.clear();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text =
            DateFormat('dd/MM/yyyy').format(picked); // Format the date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD1D1D1), Color(0xFF4B6965)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'EDUCATION',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF184D47),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildField('Qualification', _qualificationController),
                _buildField('Institution name', _institutionController),
                _buildDateField('Course join date', _joinDateController),
                _buildDateField(
                    'Course completion date', _completionDateController),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  child: Text(_isEditing ? 'Save' : 'Edit'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveEducation,
                  child: Text(_selectedIndex == null ? 'Add' : 'Update'),
                ),
                const SizedBox(height: 20),
                if (educationList.isNotEmpty) ...[
                  const Text(
                    'Added Education:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: educationList.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, String> education = entry.value;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(
                              '${education['Qualification']} at ${education['Institution']}'),
                          subtitle: Text(
                              'Join: ${education['Join Date']} | Completion: ${education['Completion Date']}'),
                          onTap: () => _editEducation(index),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteEducation(index),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExperiencePage())),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            enabled: _isEditing,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            enabled: _isEditing,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, controller),
              ),
            ),
            onTap: () {
              if (!_isEditing) return;
              if (label == 'Course completion date') {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Enter Date'),
                      content: TextFormField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter date or "Present"',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                _selectDate(context, controller);
              }
            },
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'experience_page.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isEditing = false;
  int? _selectedIndex;
  List<Map<String, String>> educationList = [];

  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _joinDateController = TextEditingController();
  final TextEditingController _completionDateController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEducationData();
  }

  Future<void> _fetchEducationData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('education')) {
        setState(() {
          educationList = List<Map<String, String>>.from(
            (data['education'] as List).map((e) => Map<String, String>.from(e)),
          );
        });
      }
    }
  }

  Future<void> _deleteEducation(int index) async {
    setState(() {
      educationList.removeAt(index);
      _selectedIndex = null;
      _clearFields();
    });
    await _updateEducationData();
  }

  Future<void> _saveEducation() async {
    if (_qualificationController.text.isNotEmpty &&
        _institutionController.text.isNotEmpty &&
        _joinDateController.text.isNotEmpty &&
        _completionDateController.text.isNotEmpty) {
      setState(() {
        if (_selectedIndex == null) {
          educationList.add({
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          });
        } else {
          educationList[_selectedIndex!] = {
            'Qualification': _qualificationController.text,
            'Institution': _institutionController.text,
            'Join Date': _joinDateController.text,
            'Completion Date': _completionDateController.text,
          };
        }
        _clearFields();
        _selectedIndex = null;
      });
      await _updateEducationData();
    }
  }

  Future<void> _updateEducationData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'education': educationList,
    }, SetOptions(merge: true));
  }

  void _editEducation(int index) {
    setState(() {
      _selectedIndex = index;
      _qualificationController.text = educationList[index]['Qualification']!;
      _institutionController.text = educationList[index]['Institution']!;
      _joinDateController.text = educationList[index]['Join Date']!;
      _completionDateController.text = educationList[index]['Completion Date']!;
      _isEditing = true;
    });
  }

  void _clearFields() {
    _qualificationController.clear();
    _institutionController.clear();
    _joinDateController.clear();
    _completionDateController.clear();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text =
            DateFormat('dd/MM/yyyy').format(picked); // Format the date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD1D1D1), Color(0xFF4B6965)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'EDUCATION',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF184D47),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildField('Qualification', _qualificationController),
                  _buildField('Institution name', _institutionController),
                  _buildDateField('Course join date', _joinDateController),
                  _buildDateField(
                      'Course completion date', _completionDateController),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    },
                    child: Text(_isEditing ? 'Save' : 'Edit'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _saveEducation,
                    child: Text(_selectedIndex == null ? 'Add' : 'Update'),
                  ),
                  const SizedBox(height: 20),
                  if (educationList.isNotEmpty) ...[
                    const Text(
                      'Added Education:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: educationList.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, String> education = entry.value;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(
                                '${education['Qualification']} at ${education['Institution']}'),
                            subtitle: Text(
                                'Join: ${education['Join Date']} | Completion: ${education['Completion Date']}'),
                            onTap: () => _editEducation(index),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteEducation(index),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExperiencePage())),
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            enabled: _isEditing,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            enabled: _isEditing,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, controller),
              ),
            ),
            onTap: () {
              if (!_isEditing) return;
              if (label == 'Course completion date') {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Enter Date'),
                      content: TextFormField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter date or "Present"',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                _selectDate(context, controller);
              }
            },
          ),
        ],
      ),
    );
  }
}
