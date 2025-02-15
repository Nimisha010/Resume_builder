/*import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  bool _isEditing = false;
  List<Map<String, dynamic>> projects = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _technologyController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();
  final TextEditingController _certificateController = TextEditingController();

  List<String> technologies = [];
  List<String> awards = [];
  List<String> certificates = [];

  void _addTechnology() {
    if (_technologyController.text.isNotEmpty) {
      setState(() {
        technologies.add(_technologyController.text);
        _technologyController.clear();
      });
    }
  }

  void _addAward() {
    if (_awardController.text.isNotEmpty) {
      setState(() {
        awards.add(_awardController.text);
        _awardController.clear();
      });
    }
  }

  void _addCertificate() {
    if (_certificateController.text.isNotEmpty) {
      setState(() {
        certificates.add(_certificateController.text);
        _certificateController.clear();
      });
    }
  }

  void _addProject() {
    if (_titleController.text.isNotEmpty && _roleController.text.isNotEmpty) {
      setState(() {
        projects.add({
          'Title': _titleController.text,
          'Role': _roleController.text,
          'Technologies': List.from(technologies),
          'Awards': List.from(awards),
          'Certificates': List.from(certificates),
        });
        _titleController.clear();
        _roleController.clear();
        technologies.clear();
        awards.clear();
        certificates.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isEditing) ...[
              _buildField('Project Title', _titleController),
              _buildField('Role', _roleController),
              _buildFieldWithAddButton(
                  'Technologies/Tools', _technologyController, _addTechnology),
              _buildFieldWithAddButton(
                  'Awards/Achievements', _awardController, _addAward),
              _buildFieldWithAddButton(
                  'Certificates', _certificateController, _addCertificate),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addProject,
                child: const Text('Add Project'),
              ),
              const SizedBox(height: 10),
            ],
            const Text('Projects:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            projects.isEmpty
                ? const Text('No projects added.',
                    style: TextStyle(fontSize: 16))
                : Column(
                    children: projects.map((project) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title:
                              Text('${project['Title']} - ${project['Role']}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Technologies: ${project['Technologies'].join(', ')}'),
                              Text('Awards: ${project['Awards'].join(', ')}'),
                              Text(
                                  'Certificates: ${project['Certificates'].join(', ')}'),
                            ],
                          ),
                        ),
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
                    // Navigate to the next page (e.g., Summary, Resume Preview, etc.)
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

  Widget _buildFieldWithAddButton(
      String label, TextEditingController controller, VoidCallback onPressed) {
    return Row(
      children: [
        Expanded(child: _buildField(label, controller)),
        const SizedBox(width: 10),
        ElevatedButton(onPressed: onPressed, child: const Text('Add')),
      ],
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'choose_template_page.dart'; // Import the ChooseTemplatePage

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  bool _isEditing = false;
  List<Map<String, dynamic>> projects = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _technologyController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();
  final TextEditingController _certificateController = TextEditingController();

  List<String> technologies = [];
  List<String> awards = [];
  List<String> certificates = [];

  void _addTechnology() {
    if (_technologyController.text.isNotEmpty) {
      setState(() {
        technologies.add(_technologyController.text);
        _technologyController.clear();
      });
    }
  }

  void _addAward() {
    if (_awardController.text.isNotEmpty) {
      setState(() {
        awards.add(_awardController.text);
        _awardController.clear();
      });
    }
  }

  void _addCertificate() {
    if (_certificateController.text.isNotEmpty) {
      setState(() {
        certificates.add(_certificateController.text);
        _certificateController.clear();
      });
    }
  }

  void _addProject() {
    if (_titleController.text.isNotEmpty && _roleController.text.isNotEmpty) {
      setState(() {
        projects.add({
          'Title': _titleController.text,
          'Role': _roleController.text,
          'Technologies': List.from(technologies),
          'Awards': List.from(awards),
          'Certificates': List.from(certificates),
        });
        _titleController.clear();
        _roleController.clear();
        technologies.clear();
        awards.clear();
        certificates.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isEditing) ...[
              _buildField('Project Title', _titleController),
              _buildField('Role', _roleController),
              _buildFieldWithAddButton(
                  'Technologies/Tools', _technologyController, _addTechnology),
              _buildFieldWithAddButton(
                  'Awards/Achievements', _awardController, _addAward),
              _buildFieldWithAddButton(
                  'Certificates', _certificateController, _addCertificate),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addProject,
                child: const Text('Add Project'),
              ),
              const SizedBox(height: 10),
            ],
            const Text('Projects:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            projects.isEmpty
                ? const Text('No projects added.',
                    style: TextStyle(fontSize: 16))
                : Column(
                    children: projects.map((project) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title:
                              Text('${project['Title']} - ${project['Role']}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Technologies: ${project['Technologies'].join(', ')}'),
                              Text('Awards: ${project['Awards'].join(', ')}'),
                              Text(
                                  'Certificates: ${project['Certificates'].join(', ')}'),
                            ],
                          ),
                        ),
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
                      MaterialPageRoute(
                          builder: (context) => ChooseTemplatePage()),
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

  Widget _buildFieldWithAddButton(
      String label, TextEditingController controller, VoidCallback onPressed) {
    return Row(
      children: [
        Expanded(child: _buildField(label, controller)),
        const SizedBox(width: 10),
        ElevatedButton(onPressed: onPressed, child: const Text('Add')),
      ],
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'choose_template_page.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  bool _isEditing = true;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _technologyController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();
  final TextEditingController _certificateController = TextEditingController();

  List<String> technologies = [];
  List<String> awards = [];
  List<String> certificates = [];

  void _addTechnology() {
    if (_technologyController.text.isNotEmpty) {
      setState(() {
        technologies.add(_technologyController.text);
        _technologyController.clear();
      });
    }
  }

  void _addAward() {
    if (_awardController.text.isNotEmpty) {
      setState(() {
        awards.add(_awardController.text);
        _awardController.clear();
      });
    }
  }

  void _addCertificate() {
    if (_certificateController.text.isNotEmpty) {
      setState(() {
        certificates.add(_certificateController.text);
        _certificateController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD6E2E3), Color(0xFFB7C4C6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderText('PROJECTS'),
                _buildInputField('Title', _titleController),
                _buildInputField('Role', _roleController),
                _buildInputFieldWithAddButton('Technologies/Tools used',
                    _technologyController, _addTechnology),
                _buildHeaderText('AWARDS/ACHIEVEMENTS'),
                _buildInputFieldWithAddButton('', _awardController, _addAward),
                _buildHeaderText('CERTIFICATES'),
                _buildInputFieldWithAddButton(
                    '', _certificateController, _addCertificate),
                const SizedBox(height: 20),
                _buildBottomButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
          color: Color(0xFF184D47),
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildInputFieldWithAddButton(
      String hint, TextEditingController controller, VoidCallback onAdd) {
    return Column(
      children: [
        _buildInputField(hint, controller),
        TextButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add, color: Color(0xFF184D47)),
          label: const Text('+ Add',
              style: TextStyle(
                  color: Color(0xFF184D47), fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton('Edit', () {
          setState(() {
            _isEditing = !_isEditing;
          });
        }),
        _buildButton('Continue', () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChooseTemplatePage()));
        }),
      ],
    );
  }

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
/*
import 'package:flutter/material.dart';
import 'choose_template_page.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  bool _isEditing = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _technologyController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();
  final TextEditingController _certificateController = TextEditingController();

  List<String> technologies = [];
  List<String> awards = [];
  List<String> certificates = [];

  void _addTechnology() {
    if (_isEditing && _technologyController.text.isNotEmpty) {
      setState(() {
        technologies.add(_technologyController.text);
        _technologyController.clear();
      });
    }
  }

  void _addAward() {
    if (_isEditing && _awardController.text.isNotEmpty) {
      setState(() {
        awards.add(_awardController.text);
        _awardController.clear();
      });
    }
  }

  void _addCertificate() {
    if (_isEditing && _certificateController.text.isNotEmpty) {
      setState(() {
        certificates.add(_certificateController.text);
        _certificateController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD6E2E3), Color(0xFFB7C4C6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderText('PROJECTS'),
                _buildInputField('Title', _titleController),
                _buildInputField('Role', _roleController),
                _buildInputFieldWithAddButton('Technologies/Tools used',
                    _technologyController, _addTechnology),
                _buildHeaderText('AWARDS/ACHIEVEMENTS'),
                _buildInputFieldWithAddButton('', _awardController, _addAward),
                _buildHeaderText('CERTIFICATES'),
                _buildInputFieldWithAddButton(
                    '', _certificateController, _addCertificate),
                const SizedBox(height: 20),
                _buildBottomButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
          color: Color(0xFF184D47),
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: _isEditing ? Colors.white : Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          controller: controller,
          enabled: _isEditing, // Disable input when not editing
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildInputFieldWithAddButton(
      String hint, TextEditingController controller, VoidCallback onAdd) {
    return Column(
      children: [
        _buildInputField(hint, controller),
        TextButton.icon(
          onPressed: _isEditing ? onAdd : null, // Disable when not editing
          icon: Icon(Icons.add,
              color: _isEditing ? const Color(0xFF184D47) : Colors.grey),
          label: Text('+ Add',
              style: TextStyle(
                  color: _isEditing ? const Color(0xFF184D47) : Colors.grey,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(_isEditing ? 'Save' : 'Edit', () {
          setState(() {
            _isEditing = !_isEditing;
          });
        }),
        _buildButton('Continue', () {
          if (!_isEditing) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChooseTemplatePage()));
          }
        }),
      ],
    );
  }

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

/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'choose_template_page.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isEditing = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _technologyController = TextEditingController();

  List<Map<String, dynamic>> projects = []; // List to store multiple projects

  @override
  void initState() {
    super.initState();
    _fetchProjectsData(); // Fetch projects data when the page loads
  }

  /// Fetch user's projects data from Firestore
  Future<void> _fetchProjectsData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        projects = List<Map<String, dynamic>>.from(data['projects'] ?? []);
      });
    }
  }

  /// Save projects data to Firestore
  Future<void> _saveProjectsData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'projects': projects,
    }, SetOptions(merge: true)); // Merge to avoid overwriting other fields
  }

  /// Add a new project
  void _addProject() {
    if (_isEditing &&
        _titleController.text.isNotEmpty &&
        _roleController.text.isNotEmpty &&
        _technologyController.text.isNotEmpty) {
      setState(() {
        projects.add({
          'title': _titleController.text,
          'role': _roleController.text,
          'technologies': _technologyController.text.split(','),
        });
        _titleController.clear();
        _roleController.clear();
        _technologyController.clear();
      });
      _saveProjectsData(); // Save to Firestore
    }
  }

  /// Delete a project
  void _deleteProject(int index) {
    setState(() {
      projects.removeAt(index);
    });
    _saveProjectsData(); // Save to Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD6E2E3), Color(0xFFB7C4C6)],
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderText('PROJECTS'),
                  _buildInputField('Title', _titleController),
                  _buildInputField('Role', _roleController),
                  _buildInputField('Technologies/Tools used (comma-separated)',
                      _technologyController),
                  const SizedBox(height: 10),
                  if (_isEditing) _buildAddButton('Add Project', _addProject),
                  const SizedBox(height: 20),
                  _buildProjectsList(),
                  const SizedBox(height: 20),
                  _buildBottomButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
          color: Color(0xFF184D47),
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: _isEditing ? Colors.white : Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          controller: controller,
          enabled: _isEditing, // Disable input when not editing
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF184D47),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildProjectsList() {
    return projects.isEmpty
        ? const Text('No projects added.', style: TextStyle(fontSize: 16))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: projects.asMap().entries.map((entry) {
              int index = entry.key;
              var project = entry.value;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text(
                    project['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Role: ${project['role']}'),
                      Text(
                          'Technologies: ${project['technologies'].join(', ')}'),
                    ],
                  ),
                  trailing: _isEditing
                      ? IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteProject(index),
                        )
                      : null,
                ),
              );
            }).toList(),
          );
  }

  Widget _buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(_isEditing ? 'Save' : 'Edit', () {
          setState(() {
            _isEditing = !_isEditing;
          });
        }),
        _buildButton('Continue', () {
          if (!_isEditing) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChooseTemplatePage()));
          }
        }),
      ],
    );
  }

  /// Added `_buildButton` method
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
import 'choose_template_page.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isEditing = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _technologyController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();
  final TextEditingController _certificateController = TextEditingController();

  List<Map<String, dynamic>> projects = []; // List to store multiple projects
  List<String> awards = []; // List to store awards/achievements
  List<String> certificates = []; // List to store certificates

  @override
  void initState() {
    super.initState();
    _fetchProjectsData(); // Fetch projects, awards, and certificates data when the page loads
  }

  /// Fetch user's projects, awards, and certificates data from Firestore
  Future<void> _fetchProjectsData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        projects = List<Map<String, dynamic>>.from(data['projects'] ?? []);
        awards = List<String>.from(data['awards'] ?? []);
        certificates = List<String>.from(data['certificates'] ?? []);
      });
    }
  }

  /// Save projects, awards, and certificates data to Firestore
  Future<void> _saveProjectsData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'projects': projects,
      'awards': awards,
      'certificates': certificates,
    }, SetOptions(merge: true)); // Merge to avoid overwriting other fields
  }

  /// Add a new project
  void _addProject() {
    if (_isEditing &&
        _titleController.text.isNotEmpty &&
        _roleController.text.isNotEmpty &&
        _technologyController.text.isNotEmpty) {
      setState(() {
        projects.add({
          'title': _titleController.text,
          'role': _roleController.text,
          'technologies': _technologyController.text.split(','),
        });
        _titleController.clear();
        _roleController.clear();
        _technologyController.clear();
      });
      _saveProjectsData(); // Save to Firestore
    }
  }

  /// Add a new award
  void _addAward() {
    if (_isEditing && _awardController.text.isNotEmpty) {
      setState(() {
        awards.add(_awardController.text);
        _awardController.clear();
      });
      _saveProjectsData(); // Save to Firestore
    }
  }

  /// Add a new certificate
  void _addCertificate() {
    if (_isEditing && _certificateController.text.isNotEmpty) {
      setState(() {
        certificates.add(_certificateController.text);
        _certificateController.clear();
      });
      _saveProjectsData(); // Save to Firestore
    }
  }

  /// Delete a project
  void _deleteProject(int index) {
    setState(() {
      projects.removeAt(index);
    });
    _saveProjectsData(); // Save to Firestore
  }

  /// Delete an award
  void _deleteAward(int index) {
    setState(() {
      awards.removeAt(index);
    });
    _saveProjectsData(); // Save to Firestore
  }

  /// Delete a certificate
  void _deleteCertificate(int index) {
    setState(() {
      certificates.removeAt(index);
    });
    _saveProjectsData(); // Save to Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD6E2E3), Color(0xFFB7C4C6)],
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderText('PROJECTS'),
                  _buildInputField('Title', _titleController),
                  _buildInputField('Role', _roleController),
                  _buildInputField('Technologies/Tools used (comma-separated)',
                      _technologyController),
                  const SizedBox(height: 10),
                  if (_isEditing) _buildAddButton('Add Project', _addProject),
                  const SizedBox(height: 20),
                  _buildProjectsList(),
                  const SizedBox(height: 20),
                  _buildHeaderText('AWARDS/ACHIEVEMENTS'),
                  _buildInputField('Award/Achievement', _awardController),
                  const SizedBox(height: 10),
                  if (_isEditing) _buildAddButton('Add Award', _addAward),
                  const SizedBox(height: 20),
                  _buildAwardsList(),
                  const SizedBox(height: 20),
                  _buildHeaderText('CERTIFICATES'),
                  _buildInputField('Certificate', _certificateController),
                  const SizedBox(height: 10),
                  if (_isEditing)
                    _buildAddButton('Add Certificate', _addCertificate),
                  const SizedBox(height: 20),
                  _buildCertificatesList(),
                  const SizedBox(height: 20),
                  _buildBottomButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
          color: Color(0xFF184D47),
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: _isEditing ? Colors.white : Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          controller: controller,
          enabled: _isEditing, // Disable input when not editing
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF184D47),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildProjectsList() {
    return projects.isEmpty
        ? const Text('No projects added.', style: TextStyle(fontSize: 16))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: projects.asMap().entries.map((entry) {
              int index = entry.key;
              var project = entry.value;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text(
                    project['title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Role: ${project['role']}'),
                      Text(
                          'Technologies: ${project['technologies'].join(', ')}'),
                    ],
                  ),
                  trailing: _isEditing
                      ? IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteProject(index),
                        )
                      : null,
                ),
              );
            }).toList(),
          );
  }

  Widget _buildAwardsList() {
    return awards.isEmpty
        ? const Text('No awards added.', style: TextStyle(fontSize: 16))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: awards.asMap().entries.map((entry) {
              int index = entry.key;
              var award = entry.value;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text(
                    award,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  trailing: _isEditing
                      ? IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteAward(index),
                        )
                      : null,
                ),
              );
            }).toList(),
          );
  }

  Widget _buildCertificatesList() {
    return certificates.isEmpty
        ? const Text('No certificates added.', style: TextStyle(fontSize: 16))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: certificates.asMap().entries.map((entry) {
              int index = entry.key;
              var certificate = entry.value;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text(
                    certificate,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  trailing: _isEditing
                      ? IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteCertificate(index),
                        )
                      : null,
                ),
              );
            }).toList(),
          );
  }

  Widget _buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(_isEditing ? 'Save' : 'Edit', () {
          setState(() {
            _isEditing = !_isEditing;
          });
        }),
        _buildButton('Continue', () {
          if (!_isEditing) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChooseTemplatePage()));
          }
        }),
      ],
    );
  }

  /// Added `_buildButton` method
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
