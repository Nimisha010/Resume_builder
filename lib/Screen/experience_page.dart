/*
import 'package:flutter/material.dart';
import 'skills_page.dart'; // Import SkillsPage

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  bool _isEditing = true;
  List<Map<String, String>> experienceList = [];

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _fromMonthController = TextEditingController();
  final TextEditingController _fromYearController = TextEditingController();
  final TextEditingController _toMonthController = TextEditingController();
  final TextEditingController _toYearController = TextEditingController();

  void _addExperience() {
    if (_jobTitleController.text.isNotEmpty &&
        _organizationController.text.isNotEmpty &&
        _fromMonthController.text.isNotEmpty &&
        _fromYearController.text.isNotEmpty &&
        _toMonthController.text.isNotEmpty &&
        _toYearController.text.isNotEmpty) {
      setState(() {
        experienceList.add({
          'Job Title': _jobTitleController.text,
          'Organization': _organizationController.text,
          'From': '${_fromMonthController.text} ${_fromYearController.text}',
          'To': '${_toMonthController.text} ${_toYearController.text}',
        });

        _jobTitleController.clear();
        _organizationController.clear();
        _fromMonthController.clear();
        _fromYearController.clear();
        _toMonthController.clear();
        _toYearController.clear();
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
            colors: [Colors.white, Color(0xFF97C4B8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
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
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildField('Job Title', _jobTitleController),
            _buildField('Organization name', _organizationController),
            const Text('Duration',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(child: _buildDropdown('Month', _fromMonthController)),
                const SizedBox(width: 10),
                Expanded(child: _buildDropdown('Year', _fromYearController)),
                const SizedBox(width: 10),
                const Text('To', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Expanded(child: _buildDropdown('Month', _toMonthController)),
                const SizedBox(width: 10),
                Expanded(child: _buildDropdown('Year', _toYearController)),
              ],
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: _addExperience,
              icon: const Icon(Icons.add, color: Colors.black),
              label: const Text('Add', style: TextStyle(color: Colors.black)),
            ),
            const SizedBox(height: 10),
            const Text(
              'Experience Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            experienceList.isEmpty
                ? const Text('No experience details added.',
                    style: TextStyle(fontSize: 16))
                : Column(
                    children: experienceList.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, String> experience = entry.value;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(
                              '${experience['Job Title']} - ${experience['Organization']}'),
                          subtitle: Text(
                              'From: ${experience['From']}  |  To: ${experience['To']}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.black),
                            onPressed: () => _editExperience(index),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 20),
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
                    MaterialPageRoute(builder: (context) => SkillsPage()),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, TextEditingController controller) {
    List<String> items =
        label == 'Month' ? _months : List.generate(25, (i) => '${2000 + i}');

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      value: controller.text.isEmpty ? null : controller.text,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          controller.text = newValue!;
        });
      },
    );
  }

  void _editExperience(int index) {
    setState(() {
      Map<String, String> experience = experienceList[index];
      _jobTitleController.text = experience['Job Title']!;
      _organizationController.text = experience['Organization']!;
      List<String> fromParts = experience['From']!.split(' ');
      List<String> toParts = experience['To']!.split(' ');
      _fromMonthController.text = fromParts[0];
      _fromYearController.text = fromParts[1];
      _toMonthController.text = toParts[0];
      _toYearController.text = toParts[1];

      experienceList.removeAt(index);
    });
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF184D47),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
}
*/
/*
import 'package:flutter/material.dart';
import 'skills_page.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  bool _isEditing = false;
  List<Map<String, String>> experienceList = [];

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _fromMonthController = TextEditingController();
  final TextEditingController _fromYearController = TextEditingController();
  final TextEditingController _toMonthController = TextEditingController();
  final TextEditingController _toYearController = TextEditingController();

  void _addExperience() {
    if (_jobTitleController.text.isNotEmpty &&
        _organizationController.text.isNotEmpty &&
        _fromMonthController.text.isNotEmpty &&
        _fromYearController.text.isNotEmpty &&
        _toMonthController.text.isNotEmpty &&
        _toYearController.text.isNotEmpty) {
      setState(() {
        experienceList.add({
          'Job Title': _jobTitleController.text,
          'Organization': _organizationController.text,
          'From': '${_fromMonthController.text} ${_fromYearController.text}',
          'To': '${_toMonthController.text} ${_toYearController.text}',
        });

        _jobTitleController.clear();
        _organizationController.clear();
        _fromMonthController.clear();
        _fromYearController.clear();
        _toMonthController.clear();
        _toYearController.clear();
      });
    }
  }

  void _editExperience(int index) {
    setState(() {
      Map<String, String> experience = experienceList[index];
      _jobTitleController.text = experience['Job Title']!;
      _organizationController.text = experience['Organization']!;

      List<String> fromParts = experience['From']!.split(' ');
      List<String> toParts = experience['To']!.split(' ');

      _fromMonthController.text = fromParts[0];
      _fromYearController.text = fromParts[1];
      _toMonthController.text = toParts[0];
      _toYearController.text = toParts[1];

      experienceList.removeAt(index);
      _isEditing = true; // Enable editing mode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFF97C4B8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
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
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildField('Job Title', _jobTitleController),
            _buildField('Organization name', _organizationController),
            const SizedBox(height: 10),
            const Text(
              'Duration',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                    child: _buildDropdown('From Month', _fromMonthController)),
                const SizedBox(width: 10),
                Expanded(
                    child: _buildDropdown('From Year', _fromYearController)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildDropdown('To Month', _toMonthController)),
                const SizedBox(width: 10),
                Expanded(child: _buildDropdown('To Year', _toYearController)),
              ],
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: _addExperience,
              icon: const Icon(Icons.add, color: Colors.black),
              label: const Text('Add', style: TextStyle(color: Colors.black)),
            ),
            const SizedBox(height: 10),
            const Text(
              'Experience Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            experienceList.isEmpty
                ? const Text(
                    'No experience details added.',
                    style: TextStyle(fontSize: 16),
                  )
                : Column(
                    children: experienceList.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, String> experience = entry.value;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(
                              '${experience['Job Title']} - ${experience['Organization']}'),
                          subtitle: Text(
                              'From: ${experience['From']}\nTo: ${experience['To']}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.black),
                            onPressed: () => _editExperience(index),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 20),
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
                    MaterialPageRoute(builder: (context) => SkillsPage()),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        enabled: _isEditing,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, TextEditingController controller) {
    List<String> items = label.contains('Month')
        ? _months
        : List.generate(25, (i) => '${2000 + i}');

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      value: controller.text.isEmpty ? null : controller.text,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: _isEditing
          ? (String? newValue) {
              setState(() {
                controller.text = newValue!;
              });
            }
          : null,
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF184D47),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
}
*/
/*
import 'package:flutter/material.dart';
import 'skills_page.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  bool _isEditing = false;
  List<Map<String, String>> experienceList = [];

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _fromMonthController = TextEditingController();
  final TextEditingController _fromYearController = TextEditingController();
  final TextEditingController _toMonthController = TextEditingController();
  final TextEditingController _toYearController = TextEditingController();

  void _addExperience() {
    if (_jobTitleController.text.isNotEmpty &&
        _organizationController.text.isNotEmpty &&
        _fromMonthController.text.isNotEmpty &&
        _fromYearController.text.isNotEmpty &&
        _toMonthController.text.isNotEmpty &&
        _toYearController.text.isNotEmpty) {
      setState(() {
        experienceList.add({
          'Job Title': _jobTitleController.text,
          'Organization': _organizationController.text,
          'From': '${_fromMonthController.text} ${_fromYearController.text}',
          'To': '${_toMonthController.text} ${_toYearController.text}',
        });

        _jobTitleController.clear();
        _organizationController.clear();
        _fromMonthController.clear();
        _fromYearController.clear();
        _toMonthController.clear();
        _toYearController.clear();
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
            colors: [Colors.white, Color(0xFF97C4B8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50), // Moves the heading down
            const Center(
              child: Text(
                'EXPERIENCE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildField('Job Title', _jobTitleController),
            _buildField('Organization name', _organizationController),
            const SizedBox(height: 10),
            const Text(
              'Duration',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(child: _buildDropdown('Month', _fromMonthController)),
                const SizedBox(width: 10),
                Expanded(child: _buildDropdown('Year', _fromYearController)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildDropdown('Month', _toMonthController)),
                const SizedBox(width: 10),
                Expanded(child: _buildDropdown('Year', _toYearController)),
              ],
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: _addExperience,
              icon: const Icon(Icons.add, color: Colors.black),
              label: const Text('Add', style: TextStyle(color: Colors.black)),
            ),
            const SizedBox(height: 20),
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
                    MaterialPageRoute(builder: (context) => SkillsPage()),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, TextEditingController controller) {
    List<String> items =
        label == 'Month' ? _months : List.generate(25, (i) => '${2000 + i}');

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      value: controller.text.isEmpty ? null : controller.text,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            controller.text = newValue;
          });
        }
      },
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF184D47),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
}
*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> _saveExperience() async {
    if (_isEditing &&
        _jobTitleController.text.isNotEmpty &&
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

  void _enableEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  void _clearFields() {
    _jobTitleController.clear();
    _companyController.clear();
    _startDateController.clear();
    _endDateController.clear();
  }

  Widget _buildField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      enabled: _isEditing,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                _buildField('Start Date', _startDateController),
                _buildField('End Date', _endDateController),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _enableEditing,
                  child: const Text('Edit'),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _saveExperience,
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
                if (experienceList.isNotEmpty) ...[
                  const Text(
                    'Added Experience:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: experienceList.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, String> experience = entry.value;
                      return GestureDetector(
                        onTap: () => _enableEditing(),
                        child: Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(
                              '${experience['Job Title']} at ${experience['Company']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              'Start: ${experience['Start Date']}  |  End: ${experience['End Date']}',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SkillsPage()),
                    );
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> _saveExperience() async {
    if (_isEditing &&
        _jobTitleController.text.isNotEmpty &&
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

  void _enableEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  void _clearFields() {
    _jobTitleController.clear();
    _companyController.clear();
    _startDateController.clear();
    _endDateController.clear();
  }

/*
  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: controller,
        enabled: _isEditing,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
*/
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
                      _buildField('Start Date', _startDateController),
                      _buildField('End Date', _endDateController),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _enableEditing,
                        child: const Text('Edit'),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _saveExperience,
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
                      if (experienceList.isNotEmpty) ...[
                        const Text(
                          'Added Experience:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: experienceList.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, String> experience = entry.value;
                            return Card(
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                title: Text(
                                  '${experience['Job Title']} at ${experience['Company']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  'Start: ${experience['Start Date']}  |  End: ${experience['End Date']}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SkillsPage()),
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
        ),
      ),
    );
  }
}
