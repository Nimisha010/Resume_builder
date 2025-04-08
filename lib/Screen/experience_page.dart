/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'skills_page.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isEditing = false;
  int? _selectedIndex;
  List<Map<String, String>> experienceList = [];

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchExperienceData();
  }

  Future<void> _fetchExperienceData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('experience')) {
        setState(() {
          experienceList = List<Map<String, String>>.from(
            (data['experience'] as List)
                .map((e) => Map<String, String>.from(e)),
          );
        });
      }
    }
  }

  void _enableEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        _clearFields();
        _selectedIndex = null;
      }
    });
  }

  void _loadSelectedExperience(int index) {
    setState(() {
      _isEditing = true;
      _selectedIndex = index;
      _jobTitleController.text = experienceList[index]['Job Title'] ?? '';
      _companyController.text = experienceList[index]['Company'] ?? '';
      _startDateController.text = experienceList[index]['Start Date'] ?? '';
      _endDateController.text = experienceList[index]['End Date'] ?? '';
    });
  }

  Future<void> _deleteExperience(int index) async {
    setState(() {
      experienceList.removeAt(index);
      _selectedIndex = null;
      _clearFields();
    });
    await _updateExperienceData();
  }

  Future<void> _saveExperience() async {
    if (_jobTitleController.text.isNotEmpty &&
        _companyController.text.isNotEmpty &&
        _startDateController.text.isNotEmpty &&
        _endDateController.text.isNotEmpty) {
      setState(() {
        if (_selectedIndex == null) {
          experienceList.add({
            'Job Title': _jobTitleController.text,
            'Company': _companyController.text,
            'Start Date': _startDateController.text,
            'End Date': _endDateController.text,
          });
        } else {
          experienceList[_selectedIndex!] = {
            'Job Title': _jobTitleController.text,
            'Company': _companyController.text,
            'Start Date': _startDateController.text,
            'End Date': _endDateController.text,
          };
        }
        _clearFields();
        _selectedIndex = null;
        _isEditing = false;
      });

      await _updateExperienceData();
    }
  }

  Future<void> _updateExperienceData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'experience': experienceList,
    }, SetOptions(merge: true));
  }

  void _clearFields() {
    _jobTitleController.clear();
    _companyController.clear();
    _startDateController.clear();
    _endDateController.clear();
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
              if (label == 'End Date') {
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
                      'EXPERIENCE',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF184D47),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildField('Job Title', _jobTitleController),
                  _buildField('Company Name', _companyController),
                  _buildDateField('Start Date', _startDateController),
                  _buildDateField('End Date', _endDateController),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _enableEditing,
                    child: Text(_isEditing ? 'Cancel' : 'Edit'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _saveExperience,
                    child: Text(_selectedIndex == null ? 'Add' : 'Update'),
                  ),
                  const SizedBox(height: 20),
                  if (experienceList.isNotEmpty) ...[
                    const Text(
                      'Added Experience:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: experienceList.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, String> experience = entry.value;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(
                                '${experience['Job Title']} at ${experience['Company']}'),
                            subtitle: Text(
                                'Start: ${experience['Start Date']} | End: ${experience['End Date']}'),
                            onTap: () => _loadSelectedExperience(index),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteExperience(index),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SkillsPage())),
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
}
*/

/*
correct one

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'skills_page.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int? _selectedIndex;
  List<Map<String, String>> experienceList = [];

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchExperienceData();
  }

  // Check if there are unsaved changes in the form
  bool _hasUnsavedChanges() {
    return _jobTitleController.text.isNotEmpty ||
        _companyController.text.isNotEmpty ||
        _startDateController.text.isNotEmpty ||
        _endDateController.text.isNotEmpty;
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
                  _saveExperience();
                  Navigator.pop(context, true);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _fetchExperienceData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('experience')) {
        setState(() {
          experienceList = List<Map<String, String>>.from(
            (data['experience'] as List)
                .map((e) => Map<String, String>.from(e)),
          );
        });
      }
    }
  }

  Future<void> _deleteExperience(int index) async {
    setState(() {
      experienceList.removeAt(index);
      _selectedIndex = null;
      _clearFields();
    });
    await _updateExperienceData();
  }

  Future<void> _saveExperience() async {
    if (_jobTitleController.text.isNotEmpty &&
        _companyController.text.isNotEmpty &&
        _startDateController.text.isNotEmpty &&
        _endDateController.text.isNotEmpty) {
      setState(() {
        if (_selectedIndex == null) {
          experienceList.add({
            'Job Title': _jobTitleController.text,
            'Company': _companyController.text,
            'Start Date': _startDateController.text,
            'End Date': _endDateController.text,
          });
        } else {
          experienceList[_selectedIndex!] = {
            'Job Title': _jobTitleController.text,
            'Company': _companyController.text,
            'Start Date': _startDateController.text,
            'End Date': _endDateController.text,
          };
        }
        _clearFields();
        _selectedIndex = null;
      });
      await _updateExperienceData();
    }
  }

  Future<void> _updateExperienceData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'experience': experienceList,
    }, SetOptions(merge: true));
  }

  void _editExperience(int index) {
    setState(() {
      _selectedIndex = index;
      _jobTitleController.text = experienceList[index]['Job Title']!;
      _companyController.text = experienceList[index]['Company']!;
      _startDateController.text = experienceList[index]['Start Date']!;
      _endDateController.text = experienceList[index]['End Date']!;
    });
  }

  void _clearFields() {
    _jobTitleController.clear();
    _companyController.clear();
    _startDateController.clear();
    _endDateController.clear();
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
                      'EXPERIENCE',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF184D47),
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildField('Job Title', _jobTitleController),
                  _buildField('Company Name', _companyController),
                  _buildDateField('Start Date', _startDateController),
                  _buildDateField('End Date', _endDateController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveExperience,
                    child: Text(_selectedIndex == null ? 'Add' : 'Update'),
                  ),
                  const SizedBox(height: 20),
                  if (experienceList.isNotEmpty) ...[
                    const Text(
                      'Added Experience:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: experienceList.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, String> experience = entry.value;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(
                                '${experience['Job Title']} at ${experience['Company']}'),
                            subtitle: Text(
                                'Start: ${experience['Start Date']} | End: ${experience['End Date']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () => _editExperience(index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => _deleteExperience(index),
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
                          builder: (context) => SkillsPage(),
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
              if (label == 'End Date') {
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

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'skills_page.dart';

// class ExperiencePage extends StatefulWidget {
//   const ExperiencePage({super.key});

//   @override
//   _ExperiencePageState createState() => _ExperiencePageState();
// }

// class _ExperiencePageState extends State<ExperiencePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   int? _selectedIndex;
//   List<Map<String, String>> experienceList = [];

//   final TextEditingController _jobTitleController = TextEditingController();
//   final TextEditingController _companyController = TextEditingController();
//   final TextEditingController _startDateController = TextEditingController();
//   final TextEditingController _endDateController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchExperienceData();
//   }

//   bool _hasUnsavedChanges() {
//     return _jobTitleController.text.isNotEmpty ||
//         _companyController.text.isNotEmpty ||
//         _startDateController.text.isNotEmpty ||
//         _endDateController.text.isNotEmpty;
//   }

//   Future<bool> _showUnsavedChangesDialog() async {
//     return await showDialog<bool>(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Unsaved Changes'),
//             content: const Text(
//                 'You have unsaved changes. Do you want to save them before continuing?'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context, false),
//                 child: const Text('Discard'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   _saveExperience();
//                   Navigator.pop(context, true);
//                 },
//                 child: const Text('Save'),
//               ),
//             ],
//           ),
//         ) ??
//         false;
//   }

//   Future<void> _fetchExperienceData() async {
//     User? user = _auth.currentUser;
//     if (user == null) return;

//     DocumentSnapshot snapshot =
//         await _firestore.collection('users').doc(user.uid).get();
//     if (snapshot.exists) {
//       var data = snapshot.data() as Map<String, dynamic>;
//       if (data.containsKey('experience')) {
//         setState(() {
//           // Filter out AI-generated entries and only keep original ones
//           experienceList = List<Map<String, String>>.from(
//             (data['experience'] as List)
//                 .where(
//                     (e) => e['is_ai_generated'] != true) // Exclude AI entries
//                 .map((e) => Map<String, String>.from({
//                       'Job Title': e['Job Title'] ?? 'Not Provided',
//                       'Company': e['Company'] ?? 'Not Provided',
//                       'Start Date': e['Start Date'] ?? 'Not Provided',
//                       'End Date': e['End Date'] ?? 'Not Provided',
//                     })),
//           );
//         });
//       }
//     }
//   }

//   Future<void> _deleteExperience(int index) async {
//     setState(() {
//       experienceList.removeAt(index);
//       _selectedIndex = null;
//       _clearFields();
//     });
//     await _updateExperienceData();
//   }

//   Future<void> _saveExperience() async {
//     if (_jobTitleController.text.isNotEmpty &&
//         _companyController.text.isNotEmpty &&
//         _startDateController.text.isNotEmpty &&
//         _endDateController.text.isNotEmpty) {
//       setState(() {
//         if (_selectedIndex == null) {
//           experienceList.add({
//             'Job Title': _jobTitleController.text,
//             'Company': _companyController.text,
//             'Start Date': _startDateController.text,
//             'End Date': _endDateController.text,
//           });
//         } else {
//           experienceList[_selectedIndex!] = {
//             'Job Title': _jobTitleController.text,
//             'Company': _companyController.text,
//             'Start Date': _startDateController.text,
//             'End Date': _endDateController.text,
//           };
//         }
//         _clearFields();
//         _selectedIndex = null;
//       });
//       await _updateExperienceData();
//     }
//   }

//   Future<void> _updateExperienceData() async {
//     User? user = _auth.currentUser;
//     if (user == null) return;

//     // Convert experienceList to format expected by Firestore
//     List<Map<String, dynamic>> firestoreFormat = experienceList.map((e) {
//       return {
//         'Job Title': e['Job Title'],
//         'Company': e['Company'],
//         'Start Date': e['Start Date'],
//         'End Date': e['End Date'],
//         'is_ai_generated': false, // Explicitly mark as non-AI
//       };
//     }).toList();

//     await _firestore.collection('users').doc(user.uid).set({
//       'experience': firestoreFormat,
//     }, SetOptions(merge: true));
//   }

//   void _editExperience(int index) {
//     setState(() {
//       _selectedIndex = index;
//       _jobTitleController.text = experienceList[index]['Job Title']!;
//       _companyController.text = experienceList[index]['Company']!;
//       _startDateController.text = experienceList[index]['Start Date']!;
//       _endDateController.text = experienceList[index]['End Date']!;
//     });
//   }

//   void _clearFields() {
//     _jobTitleController.clear();
//     _companyController.clear();
//     _startDateController.clear();
//     _endDateController.clear();
//   }

//   Future<void> _selectDate(
//       BuildContext context, TextEditingController controller) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       setState(() {
//         controller.text = DateFormat('dd/MM/yyyy').format(picked);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFFD1D1D1), Color(0xFF4B6965)],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: MediaQuery.of(context).size.height,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Center(
//                     child: Text(
//                       'EXPERIENCE',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF184D47),
//                         fontFamily: 'Times New Roman',
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   _buildField('Job Title', _jobTitleController),
//                   _buildField('Company Name', _companyController),
//                   _buildDateField('Start Date', _startDateController),
//                   _buildDateField('End Date', _endDateController),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _saveExperience,
//                     child: Text(_selectedIndex == null ? 'Add' : 'Update'),
//                   ),
//                   const SizedBox(height: 20),
//                   if (experienceList.isNotEmpty) ...[
//                     const Text(
//                       'Added Experience:',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Column(
//                       children: experienceList.asMap().entries.map((entry) {
//                         int index = entry.key;
//                         Map<String, String> experience = entry.value;
//                         return Card(
//                           margin: const EdgeInsets.symmetric(vertical: 5),
//                           child: ListTile(
//                             title: Text(
//                                 '${experience['Job Title']} at ${experience['Company']}'),
//                             subtitle: Text(
//                                 'Start: ${experience['Start Date']} | End: ${experience['End Date']}'),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(Icons.edit,
//                                       color: Colors.blue),
//                                   onPressed: () => _editExperience(index),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.delete,
//                                       color: Colors.red),
//                                   onPressed: () => _deleteExperience(index),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (_hasUnsavedChanges()) {
//                         bool shouldContinue = await _showUnsavedChangesDialog();
//                         if (!shouldContinue) return;
//                       }
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => SkillsPage(),
//                         ),
//                       );
//                     },
//                     child: const Text('Continue'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 5),
//           TextFormField(
//             controller: controller,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDateField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 5),
//           TextFormField(
//             controller: controller,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               suffixIcon: IconButton(
//                 icon: const Icon(Icons.calendar_today),
//                 onPressed: () => _selectDate(context, controller),
//               ),
//             ),
//             onTap: () {
//               if (label == 'End Date') {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: const Text('Enter Date'),
//                       content: TextFormField(
//                         controller: controller,
//                         decoration: const InputDecoration(
//                           hintText: 'Enter date or "Present"',
//                         ),
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text('OK'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               } else {
//                 _selectDate(context, controller);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'skills_page.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int? _selectedIndex;
  List<Map<String, dynamic>> experienceList = [];

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchExperienceData();
  }

  bool _hasUnsavedChanges() {
    return _jobTitleController.text.isNotEmpty ||
        _companyController.text.isNotEmpty ||
        _startDateController.text.isNotEmpty ||
        _endDateController.text.isNotEmpty;
  }

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
                  _saveExperience();
                  Navigator.pop(context, true);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _fetchExperienceData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        experienceList =
            List<Map<String, dynamic>>.from(data['experience'] ?? []).map((e) {
          if (e is String) {
            return {
              'content': e,
              'is_ai_generated': true,
            };
          }
          return {
            'Job Title': e['Job Title'],
            'Company': e['Company'],
            'Start Date': e['Start Date'],
            'End Date': e['End Date'],
            'content': e['content'],
            'is_ai_generated': e['is_ai_generated'] ?? false,
          };
        }).toList();
      });
    }
  }

  Future<void> _deleteExperience(int index) async {
    setState(() {
      experienceList.removeAt(index);
      _selectedIndex = null;
      _clearFields();
    });
    await _updateExperienceData();
  }

  Future<void> _saveExperience() async {
    if (_jobTitleController.text.isNotEmpty &&
        _companyController.text.isNotEmpty &&
        _startDateController.text.isNotEmpty &&
        _endDateController.text.isNotEmpty) {
      setState(() {
        if (_selectedIndex == null) {
          experienceList.add({
            'Job Title': _jobTitleController.text,
            'Company': _companyController.text,
            'Start Date': _startDateController.text,
            'End Date': _endDateController.text,
            'is_ai_generated': false,
          });
        } else {
          experienceList[_selectedIndex!] = {
            'Job Title': _jobTitleController.text,
            'Company': _companyController.text,
            'Start Date': _startDateController.text,
            'End Date': _endDateController.text,
            'is_ai_generated':
                experienceList[_selectedIndex!]['is_ai_generated'] ?? false,
          };
        }
        _clearFields();
        _selectedIndex = null;
      });
      await _updateExperienceData();
    }
  }

  Future<void> _updateExperienceData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'experience': experienceList,
    }, SetOptions(merge: true));
  }

  void _editExperience(int index) {
    var experience = experienceList[index];
    bool isAIGenerated = experience['is_ai_generated'] ?? false;

    if (isAIGenerated) {
      _editAIContent(
        context,
        experience['content'] ?? '',
        (newContent) {
          if (newContent != null && newContent.isNotEmpty) {
            setState(() {
              experienceList[index]['content'] = newContent;
            });
            _updateExperienceData();
          }
        },
      );
    } else {
      setState(() {
        _selectedIndex = index;
        _jobTitleController.text = experience['Job Title'] ?? '';
        _companyController.text = experience['Company'] ?? '';
        _startDateController.text = experience['Start Date'] ?? '';
        _endDateController.text = experience['End Date'] ?? '';
      });
    }
  }

  Future<void> _editAIContent(
    BuildContext context,
    String initialContent,
    Function(String?) onSave,
  ) async {
    final TextEditingController contentController =
        TextEditingController(text: initialContent);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Experience'),
        content: TextField(
          controller: contentController,
          maxLines: 5,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your experience details',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onSave(contentController.text);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _clearFields() {
    _jobTitleController.clear();
    _companyController.clear();
    _startDateController.clear();
    _endDateController.clear();
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
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
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
                      'EXPERIENCE',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF184D47),
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildField('Job Title', _jobTitleController),
                  _buildField('Company Name', _companyController),
                  _buildDateField('Start Date', _startDateController),
                  _buildDateField('End Date', _endDateController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveExperience,
                    child: Text(_selectedIndex == null ? 'Add' : 'Update'),
                  ),
                  const SizedBox(height: 20),
                  if (experienceList.isNotEmpty) ...[
                    const Text(
                      'Added Experience:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: experienceList.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> experience = entry.value;
                        bool isAIGenerated =
                            experience['is_ai_generated'] ?? false;

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: isAIGenerated
                                ? Text(
                                    experience['content'] ?? '',
                                    style: const TextStyle(color: Colors.blue),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${experience['Job Title']} at ${experience['Company']}'),
                                      Text(
                                          'Start: ${experience['Start Date']} | End: ${experience['End Date']}'),
                                    ],
                                  ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isAIGenerated)
                                  const Icon(Icons.auto_awesome,
                                      color: Colors.blue, size: 20),
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue, size: 20),
                                  onPressed: () => _editExperience(index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red, size: 20),
                                  onPressed: () => _deleteExperience(index),
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
                          builder: (context) => SkillsPage(),
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
              if (label == 'End Date') {
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
