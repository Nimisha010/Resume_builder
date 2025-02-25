/*
import 'package:flutter/material.dart';
import 'education_page.dart';

class CreateResumePage extends StatefulWidget {
  const CreateResumePage({super.key});

  @override
  _CreateResumePageState createState() => _CreateResumePageState();
}

class _CreateResumePageState extends State<CreateResumePage> {
  bool _isEditing = true; // Default to editing mode

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _languagesController = TextEditingController();

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
                    'CONTACT DETAILS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF184D47), // Teal color
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildField('Name', _nameController),
                _buildField('Address', _addressController),
                _buildField('Phone no', _phoneController),
                _buildField('Email ID', _emailController),
                _buildField('LinkedIn Profile (optional)', _linkedinController),
                _buildField('Github Profile', _githubController),
                _buildField('Languages', _languagesController),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton('Edit', () {
                      setState(() {
                        _isEditing = true;
                      });
                    }),
                    _buildButton('Continue', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EducationPage(),
                        ),
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
import 'education_page.dart';

class CreateResumePage extends StatefulWidget {
  const CreateResumePage({super.key});

  @override
  _CreateResumePageState createState() => _CreateResumePageState();
}

class _CreateResumePageState extends State<CreateResumePage> {
  bool _isEditing = false; // Default to preview mode

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _languagesController = TextEditingController();

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
                    'CONTACT DETAILS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF184D47), // Teal color
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildField('Name', _nameController),
                _buildField('Address', _addressController),
                _buildField('Phone no', _phoneController),
                _buildField('Email ID', _emailController),
                _buildField('LinkedIn Profile (optional)', _linkedinController),
                _buildField('Github Profile', _githubController),
                _buildField('Languages', _languagesController),
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
                        MaterialPageRoute(
                          builder: (context) => const EducationPage(),
                        ),
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
          _isEditing
              ? TextFormField(
                  controller: controller,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    controller.text.isEmpty ? ' ' : controller.text,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
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
}*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'education_page.dart';

class CreateResumePage extends StatefulWidget {
  const CreateResumePage({super.key});

  @override
  _CreateResumePageState createState() => _CreateResumePageState();
}

class _CreateResumePageState extends State<CreateResumePage> {
  bool _isEditing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _languagesController = TextEditingController();

  Future<void> saveUserData() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "default_user";

    await FirebaseFirestore.instance.collection("users").doc(userId).set({
      "contactDetails": {
        "name": _nameController.text,
        "address": _addressController.text,
        "phone": _phoneController.text,
        "email": _emailController.text,
        "linkedin": _linkedinController.text,
        "github": _githubController.text,
        "languages": _languagesController.text,
      }
    }, SetOptions(merge: true));

    print("Data saved successfully!");
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
                    'CONTACT DETAILS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF184D47),
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildField('Name', _nameController),
                _buildField('Address', _addressController),
                _buildField('Phone no', _phoneController),
                _buildField('Email ID', _emailController),
                _buildField('LinkedIn Profile (optional)', _linkedinController),
                _buildField('Github Profile', _githubController),
                _buildField('Languages', _languagesController),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton(_isEditing ? 'Save' : 'Edit', () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    }),
                    _buildButton('Continue', () async {
                      await saveUserData(); // Save data before navigating
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EducationPage(),
                        ),
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
          _isEditing
              ? TextFormField(
                  controller: controller,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    controller.text.isEmpty ? ' ' : controller.text,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
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
          backgroundColor: const Color(0xFF184D47),
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
}*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'education_page.dart';

class CreateResumePage extends StatefulWidget {
  const CreateResumePage({super.key});

  @override
  _CreateResumePageState createState() => _CreateResumePageState();
}

class _CreateResumePageState extends State<CreateResumePage> {
  bool _isEditing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _languagesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Fetch existing data when the page loads
  }

  Future<void> _loadUserData() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    if (userId.isNotEmpty) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        Map<String, dynamic>? contactDetails = data["contactDetails"];

        if (contactDetails != null) {
          setState(() {
            _nameController.text = contactDetails["name"] ?? "";
            _addressController.text = contactDetails["address"] ?? "";
            _phoneController.text = contactDetails["phone"] ?? "";
            _emailController.text = contactDetails["email"] ?? "";
            _linkedinController.text = contactDetails["linkedin"] ?? "";
            _githubController.text = contactDetails["github"] ?? "";
            _languagesController.text = contactDetails["languages"] ?? "";
          });
        }
      }
    }
  }

  Future<void> _saveUserData() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    if (userId.isNotEmpty) {
      await FirebaseFirestore.instance.collection("users").doc(userId).set({
        "contactDetails": {
          "name": _nameController.text,
          "address": _addressController.text,
          "phone": _phoneController.text,
          "email": _emailController.text,
          "linkedin": _linkedinController.text,
          "github": _githubController.text,
          "languages": _languagesController.text,
        }
      }, SetOptions(merge: true));

      print("Data saved successfully!");
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'CONTACT DETAILS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF184D47),
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildField('Name', _nameController),
                _buildField('Address', _addressController),
                _buildField('Phone no', _phoneController),
                _buildField('Email ID', _emailController),
                _buildField('LinkedIn Profile (optional)', _linkedinController),
                _buildField('Github Profile', _githubController),
                _buildField('Languages', _languagesController),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton(_isEditing ? 'Save' : 'Edit', () async {
                      if (_isEditing) {
                        await _saveUserData(); // Save data if "Save" is clicked
                      }
                      setState(() {
                        _isEditing = !_isEditing; // Toggle edit mode
                      });
                    }),
                    _buildButton('Continue', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EducationPage(),
                        ),
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
          _isEditing
              ? TextFormField(
                  controller: controller,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    controller.text.isEmpty ? ' ' : controller.text,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
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
          backgroundColor: const Color(0xFF184D47),
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'education_page.dart';

class CreateResumePage extends StatefulWidget {
  const CreateResumePage({super.key});

  @override
  _CreateResumePageState createState() => _CreateResumePageState();
}

class _CreateResumePageState extends State<CreateResumePage> {
  bool _isEditing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _languagesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Fetch existing data when the page loads
  }

  Future<void> _loadUserData() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    if (userId.isNotEmpty) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        Map<String, dynamic>? contactDetails = data["contactDetails"];

        if (contactDetails != null) {
          setState(() {
            _nameController.text = contactDetails["name"] ?? "";
            _addressController.text = contactDetails["address"] ?? "";
            _phoneController.text = contactDetails["phone"] ?? "";
            _emailController.text = contactDetails["email"] ?? "";
            _linkedinController.text = contactDetails["linkedin"] ?? "";
            _githubController.text = contactDetails["github"] ?? "";
            _languagesController.text = contactDetails["languages"] ?? "";
          });
        }
      }
    }
  }

  Future<void> _saveUserData() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    if (userId.isNotEmpty) {
      await FirebaseFirestore.instance.collection("users").doc(userId).set({
        "contactDetails": {
          "name": _nameController.text,
          "address": _addressController.text,
          "phone": _phoneController.text,
          "email": _emailController.text,
          "linkedin": _linkedinController.text,
          "github": _githubController.text,
          "languages": _languagesController.text,
        }
      }, SetOptions(merge: true));

      print("Data saved successfully!");
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'CONTACT DETAILS',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF184D47),
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildField('Name', _nameController),
                  _buildField('Address', _addressController),
                  _buildField('Phone no', _phoneController),
                  _buildField('Email ID', _emailController),
                  _buildField(
                      'LinkedIn Profile (optional)', _linkedinController),
                  _buildField('Github Profile', _githubController),
                  _buildField('Languages', _languagesController),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton(_isEditing ? 'Save' : 'Edit', () async {
                        if (_isEditing) {
                          await _saveUserData(); // Save data if "Save" is clicked
                        }
                        setState(() {
                          _isEditing = !_isEditing; // Toggle edit mode
                        });
                      }),
                      _buildButton('Continue', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EducationPage(),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 20), // Add extra space at the bottom
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
          _isEditing
              ? TextFormField(
                  controller: controller,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    controller.text.isEmpty ? ' ' : controller.text,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
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
          backgroundColor: const Color(0xFF184D47),
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
