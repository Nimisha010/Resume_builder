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
  final _formKey = GlobalKey<FormState>(); // Add a form key for validation

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
    if (_formKey.currentState!.validate()) {
      // Only save if the form is valid
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
              child: Form(
                key: _formKey, // Add the form key here
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
                    _buildField('Name', _nameController, isMandatory: true),
                    _buildField('Address', _addressController,
                        isMandatory: true),
                    _buildField('Phone no', _phoneController,
                        isMandatory: true, isPhone: true),
                    _buildField('Email ID', _emailController,
                        isMandatory: true),
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
                            if (_formKey.currentState!.validate()) {
                              await _saveUserData(); // Save data if "Save" is clicked
                              setState(() {
                                _isEditing = !_isEditing; // Toggle edit mode
                              });
                            }
                          } else {
                            setState(() {
                              _isEditing = !_isEditing; // Toggle edit mode
                            });
                          }
                        }),
                        _buildButton('Continue', () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EducationPage(),
                              ),
                            );
                          }
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
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {bool isMandatory = false, bool isPhone = false}) {
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
                    errorText: isMandatory && controller.text.isEmpty
                        ? 'This field is required'
                        : null, // Show error if field is mandatory and empty
                  ),
                  validator: (value) {
                    if (isMandatory && (value == null || value.isEmpty)) {
                      return 'This field is required'; // Validation message
                    }
                    if (isPhone) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      }
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return 'Enter a valid 10-digit phone number';
                      }
                    }
                    return null;
                  },
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _languagesController = TextEditingController();

  bool _hasUnsavedChanges = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _nameController.addListener(_updateFieldStates);
    _addressController.addListener(_updateFieldStates);
    _phoneController.addListener(_updateFieldStates);
    _emailController.addListener(_updateFieldStates);
    _linkedinController.addListener(_updateFieldStates);
    _githubController.addListener(_updateFieldStates);
    _languagesController.addListener(_updateFieldStates);
  }

  @override
  void dispose() {
    _nameController.removeListener(_updateFieldStates);
    _addressController.removeListener(_updateFieldStates);
    _phoneController.removeListener(_updateFieldStates);
    _emailController.removeListener(_updateFieldStates);
    _linkedinController.removeListener(_updateFieldStates);
    _githubController.removeListener(_updateFieldStates);
    _languagesController.removeListener(_updateFieldStates);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateFieldStates() {
    setState(() {
      _hasUnsavedChanges = true;
    });
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        Map<String, dynamic>? contactDetails = data["contactDetails"];

        if (contactDetails != null) {
          setState(() {
            _nameController.text = contactDetails["name"] ?? "";
            _addressController.text = contactDetails["address"] ?? "";
            _phoneController.text = contactDetails["phone"] ?? "";
            _emailController.text = contactDetails["email"] ?? user.email ?? "";
            _linkedinController.text = contactDetails["linkedin"] ?? "";
            _githubController.text = contactDetails["github"] ?? "";
            _languagesController.text = contactDetails["languages"] ?? "";
            _hasUnsavedChanges = false;
          });
        }
      }
    }
  }

  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
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

        setState(() {
          _hasUnsavedChanges = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Details saved successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _handleContinue() async {
    // Scroll to top to ensure any error messages are visible
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    // Check mandatory fields
    if (_nameController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all mandatory fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Validate phone and email formats
    if (!RegExp(r'^[0-9]{10}$').hasMatch(_phoneController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 10-digit phone number'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Check for unsaved changes
    if (_hasUnsavedChanges) {
      bool shouldSave = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Unsaved Changes'),
              content: const Text(
                  'You have unsaved changes. Do you want to save before continuing?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Continue Without Saving'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Save & Continue'),
                ),
              ],
            ),
          ) ??
          false;

      if (shouldSave) {
        await _saveUserData();
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EducationPage(),
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
            controller: _scrollController,
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            child: Form(
              key: _formKey,
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
                  const SizedBox(height: 30),
                  _buildField('Name', _nameController, isMandatory: true),
                  const SizedBox(height: 15),
                  _buildField('Address', _addressController, isMandatory: true),
                  const SizedBox(height: 15),
                  _buildField('Phone no', _phoneController, isMandatory: true),
                  const SizedBox(height: 15),
                  _buildField('Email ID', _emailController, isMandatory: true),
                  const SizedBox(height: 15),
                  _buildField('LinkedIn Profile', _linkedinController),
                  const SizedBox(height: 15),
                  _buildField('Github Profile', _githubController),
                  const SizedBox(height: 15),
                  _buildField('Languages', _languagesController),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('Save', _saveUserData),
                      _buildButton('Continue', _handleContinue),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {bool isMandatory = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isMandatory ? '$label*' : label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            hintText: isMandatory ? 'Enter $label' : 'Enter $label (optional)',
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 15,
            ),
          ),
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 130,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF184D47),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 3,
          padding: const EdgeInsets.symmetric(vertical: 12),
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
