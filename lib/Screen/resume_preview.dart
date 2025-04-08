/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'templates/template1.dart';
import 'templates/template2.dart';
import 'templates/template3.dart';
import 'templates/template4.dart';
import 'templates/template5.dart';
import 'templates/template6.dart';
import 'templates/template7.dart';

class ResumePreviewScreen extends StatefulWidget {
  final String templateName;
  final String userId;

  ResumePreviewScreen({required this.templateName, required this.userId});

  @override
  _ResumePreviewScreenState createState() => _ResumePreviewScreenState();
}

class _ResumePreviewScreenState extends State<ResumePreviewScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();
      if (doc.exists) {
        setState(() {
          userData = doc.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Resume Preview")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      //appBar: AppBar(title: Text("Preview - ${widget.templateName}")),
      body: _getTemplateWidget(widget.templateName, userData!),
    );
  }

  Widget _getTemplateWidget(
      String templateName, Map<String, dynamic> userData) {
    switch (templateName) {
      case 'Classic Resume':
        return Template1(userId: userData);
      case 'Modern Resume':
        return Template2(userData: userData);
      case 'Red Template':
        return Template3(userId: userData);
      case 'Green Template':
        return Template4(userId: userData);
      case 'Column Resume':
        return Template5(userId: widget.userId);
      case 'Professional Resume':
        return Template6(userId: widget.userId);
      case 'Column Template':
        return Template7(userId: widget.userId);
      default:
        return Center(child: Text('Template not found'));
    }
  }
}
*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'templates/template1.dart';
import 'templates/template2.dart';
import 'templates/template3.dart';
import 'templates/template4.dart';
import 'templates/template5.dart';
import 'templates/template6.dart';
import 'templates/template7.dart';

class ResumePreviewScreen extends StatefulWidget {
  final String templateName;
  final String userId;
  final bool includeAISuggestions;
  final Map<String, dynamic> userData;

  const ResumePreviewScreen({
    required this.templateName,
    required this.userId,
    required this.includeAISuggestions,
    required this.userData,
    Key? key,
  }) : super(key: key);

  @override
  _ResumePreviewScreenState createState() => _ResumePreviewScreenState();
}

class _ResumePreviewScreenState extends State<ResumePreviewScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();
      if (doc.exists) {
        setState(() {
          userData = doc.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Resume Preview")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: _getTemplateWidget(widget.templateName, userData!),
    );
  }

  Widget _getTemplateWidget(
      String templateName, Map<String, dynamic> userData) {
    switch (templateName) {
      case 'Classic Resume':
        return Template1(
          templateName: templateName,
          userId: userData,
          includeAISuggestions: widget.includeAISuggestions,
        );
      case 'Modern Resume':
        return Template2(
          userData: userData,
          // includeAISuggestions: widget.includeAISuggestions,
        );
      case 'Red Template':
        return Template3(
          userId: userData,
          //  includeAISuggestions: widget.includeAISuggestions,
        );
      case 'Green Template':
        return Template4(
          templateName: templateName,
          userId: userData,
          includeAISuggestions: widget.includeAISuggestions,
        );
      case 'Column Resume':
        return Template5(
          userId: widget.userId,
          //  includeAISuggestions: widget.includeAISuggestions,
        );
      case 'Professional Resume':
        return Template6(
          userId: widget.userId,
          //  includeAISuggestions: widget.includeAISuggestions,
        );
      case 'Column Template':
        return Template7(
          userId: widget.userId,
          // includeAISuggestions: widget.includeAISuggestions,
        );
      default:
        return Center(child: Text('Template not found'));
    }
  }
}
