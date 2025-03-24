/*import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resume_template.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<ResumeTemplate>> fetchTemplates() async {
    QuerySnapshot snapshot = await _db.collection('templates').get();
    return snapshot.docs
        .map((doc) =>
            ResumeTemplate.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}*/
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resume_template.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<ResumeTemplate>> getTemplates() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('templates').get();

      if (querySnapshot.docs.isEmpty) {
        print("Firestore has no templates.");
        return [];
      }

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> jsonData = doc.data() as Map<String, dynamic>;

        print(
            "Fetched Template Data: ${jsonData.toString()}"); // ✅ Debugging print

        return ResumeTemplate.fromJson(jsonData);
      }).toList();
    } catch (e) {
      print("🔥 Error fetching templates: $e");
      return [];
    }
  }
}
*/
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resume_template.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Fetch templates from Firestore
  Future<List<ResumeTemplate>> getTemplates() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('templates').get();

      if (querySnapshot.docs.isEmpty) {
        print("Firestore has no templates.");
        return [];
      }

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> jsonData = doc.data() as Map<String, dynamic>;

        print("Fetched Template Data: ${jsonData.toString()}");

        return ResumeTemplate.fromJson(jsonData);
      }).toList();
    } catch (e) {
      print("🔥 Error fetching templates: $e");
      return [];
    }
  }

  // Fetch user data by userId
  Future<Map<String, String>> getUserData(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _db.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return {
          "name": userDoc["name"] ?? "No name",
          "address": userDoc["address"] ?? "No address",
          "phone": userDoc["phone"] ?? "No phone",
          "email": userDoc["email"] ?? "No email",
          "github": userDoc["github"] ?? "No GitHub",
          "linkedin": userDoc["linkedin"] ?? "No LinkedIn",
          "languages": userDoc["languages"] ?? "No languages",
          // Add other fields as necessary
        };
      } else {
        throw "User not found!";
      }
    } catch (e) {
      print("🔥 Error fetching user data: $e");
      return {};
    }
  }
}
*/
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resume_template.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch templates from Firestore
  Future<List<ResumeTemplate>> getTemplates() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('templates').get();

      if (querySnapshot.docs.isEmpty) {
        print("Firestore has no templates.");
        return [];
      }

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> jsonData = doc.data() as Map<String, dynamic>;

        print("Fetched Template Data: ${jsonData.toString()}");

        return ResumeTemplate.fromJson(jsonData);
      }).toList();
    } catch (e) {
      print("🔥 Error fetching templates: $e");
      return [];
    }
  }

  // Fetch user data by userId
  Future<Map<String, String>> getUserData(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _db.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        throw Exception("User not found!");
      }

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      return {
        "name": userData["name"] ?? "No name",
        "address": userData["address"] ?? "No address",
        "phone": userData["phone"] ?? "No phone",
        "email": userData["email"] ?? "No email",
        "github": userData["github"] ?? "No GitHub",
        "linkedin": userData["linkedin"] ?? "No LinkedIn",
        "languages": userData["languages"] ?? "No languages",
        // Add other fields as necessary
      };
    } catch (e) {
      print("🔥 Error fetching user data: $e");
      return {
        "name": "Error",
        "address": "Error",
        "phone": "Error",
        "email": "Error",
        "github": "Error",
        "linkedin": "Error",
        "languages": "Error",
        // Add other fallback values for missing fields
      };
    }
  }
}
*/
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resume_template.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ResumeTemplate>> getTemplates() async {
    QuerySnapshot querySnapshot = await _firestore.collection('templates').get();
    return querySnapshot.docs.map((doc) {
      return ResumeTemplate.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<Map<String, String>> getUserData(String userId) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('users').doc(userId).get();
    return docSnapshot.data() as Map<String, String>;
  }
}*/
/*correct one

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resume_template.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch templates from Firestore
  Future<List<ResumeTemplate>> getTemplates() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('templates').get();

      if (querySnapshot.docs.isEmpty) {
        print("❌ Firestore has no templates.");
        return [];
      }

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> jsonData = doc.data() as Map<String, dynamic>;

        print("✅ Fetched Template Data: ${jsonData.toString()}");

        return ResumeTemplate.fromJson(jsonData);
      }).toList();
    } catch (e) {
      print("🔥 Error fetching templates: $e");
      return [];
    }
  }

  // Fetch user data by userId
  Future<Map<String, String>> getUserData(String userId) async {
    try {
      print("🔍 Fetching user data for ID: $userId"); // Debugging print

      DocumentSnapshot userDoc =
          await _db.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        throw Exception("❌ User not found in Firestore!");
      }

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      print("✅ User Data Fetched: ${userData.toString()}"); // Debugging

      return {
        "name": userData["name"]?.toString() ?? "Not Provided",
        "address": userData["address"]?.toString() ?? "Not Provided",
        "phone": userData["phone"]?.toString() ?? "Not Provided",
        "email": userData["email"]?.toString() ?? "Not Provided",
        "github": userData["github"]?.toString() ?? "Not Provided",
        "linkedin": userData["linkedin"]?.toString() ?? "Not Provided",
        "languages": userData["languages"]?.toString() ?? "Not Provided",
      };
    } catch (e) {
      print("🔥 Error fetching user data: $e");
      return {
        "name": "Error",
        "address": "Error",
        "phone": "Error",
        "email": "Error",
        "github": "Error",
        "linkedin": "Error",
        "languages": "Error",
      };
    }
  }
}
*/
/*correct one
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resume_template.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch templates from Firestore
  Future<List<ResumeTemplate>> getTemplates() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('templates').get();

      if (querySnapshot.docs.isEmpty) {
        print("❌ Firestore has no templates.");
        return [];
      }

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> jsonData = doc.data() as Map<String, dynamic>;

        print("✅ Fetched Template Data: ${jsonData.toString()}");

        return ResumeTemplate.fromJson(jsonData);
      }).toList();
    } catch (e) {
      print("🔥 Error fetching templates: $e");
      return [];
    }
  }

  // Fetch user data by userId (FIX: Return `Map<String, dynamic>`)
  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      print("🔍 Fetching user data for ID: $userId");

      DocumentSnapshot userDoc =
          await _db.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        throw Exception("❌ User not found in Firestore!");
      }

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      print("✅ User Data Fetched: ${userData.toString()}");

      return userData; // Return full user data including `contactDetails`
    } catch (e) {
      print("🔥 Error fetching user data: $e");
      return {}; // Return empty map on error
    }
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resume_template.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 🔍 Fetch available resume templates from Firestore
  Future<List<ResumeTemplate>> getTemplates() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('templates').get();

      if (querySnapshot.docs.isEmpty) {
        print("❌ No templates found in Firestore.");
        return [];
      }

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> jsonData = doc.data() as Map<String, dynamic>;
        return ResumeTemplate.fromJson(jsonData);
      }).toList();
    } catch (e) {
      print("🔥 Error fetching templates: $e");
      return [];
    }
  }

  // 🔍 Fetch user data by userId
  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _db.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        print("❌ User not found in Firestore!");
        return {};
      }

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      print("✅ User Data Fetched: ${userData.toString()}");

      return userData;
    } catch (e) {
      print("🔥 Error fetching user data: $e");
      return {};
    }
  }

  // 💾 Save selected template for a user
  Future<void> saveSelectedTemplate(String userId, String templateName) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .update({'selectedTemplate': templateName});
      print("✅ Selected template '$templateName' saved for user $userId.");
    } catch (e) {
      print("🔥 Error saving selected template: $e");
    }
  }

  // 📌 Get selected template name for a user
  Future<String?> getSelectedTemplate(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _db.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        print("❌ No user found with ID: $userId");
        return null;
      }

      // Explicitly cast data to Map<String, dynamic>
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      if (userData == null || !userData.containsKey('selectedTemplate')) {
        print("❌ No selected template found for user $userId.");
        return null;
      }

      String templateName = userData['selectedTemplate'];
      print("✅ User $userId selected template: $templateName");
      return templateName;
    } catch (e) {
      print("🔥 Error fetching selected template: $e");
      return null;
    }
  }
}
