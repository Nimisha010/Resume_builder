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

  // Check if there are unsaved changes in the form
  bool _hasUnsavedChanges() {
    return _qualificationController.text.isNotEmpty ||
        _institutionController.text.isNotEmpty ||
        _joinDateController.text.isNotEmpty ||
        _completionDateController.text.isNotEmpty;
  }

  // Show confirmation dialog when there are unsaved changes
  Future<bool> _showUnsavedChangesDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Unsaved Changes'),
            content: const Text(
                'You have unsaved changes. Do you want to save them before continuing?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Discard'),
              ),
              TextButton(
                onPressed: () {
                  _saveEducation();
                  Navigator.pop(context, true);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ) ??
        false;
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
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildField('Qualification', _qualificationController),
                  _buildField('Institution name', _institutionController),
                  _buildDateField('Course join date', _joinDateController),
                  _buildDateField(
                      'Course completion date', _completionDateController),
                  const SizedBox(height: 20),
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () => _editEducation(index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => _deleteEducation(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_hasUnsavedChanges()) {
                        bool shouldContinue = await _showUnsavedChangesDialog();
                        if (!shouldContinue) return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExperiencePage(),
                        ),
                      );
                    },
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
