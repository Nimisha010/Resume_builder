/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:resume_app/Screen/selection_page.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
//import 'screen/selection_page.dart';
import 'screen/create_resume_page.dart'; // Import the create resume page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/login': (context) => const LoginPage(),
        '/resume_selection': (context) => const ResumeSelectionPage(),
        '/create_resume': (context) => const CreateResumePage(),
      },
      home: const LoginPage(),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
import 'screen/splash_screen.dart'; // Import Splash Screen
import 'screen/selection_page.dart';
import 'screen/create_resume_page.dart'; // Import Create Resume Page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/login': (context) => const LoginPage(),
        '/resume_selection': (context) => const ResumeSelectionPage(),
        '/create_resume': (context) => const CreateResumePage(),
      },
      home: const SplashScreen(), // Start with Splash Screen
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
import 'screen/splash_screen.dart';
import 'screen/selection_page.dart';
import 'screen/create_resume_page.dart';
import 'services/template_service.dart'; // Import TemplateService

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/login': (context) => const LoginPage(),
        '/resume_selection': (context) => const ResumeSelectionPage(),
        '/create_resume': (context) => const CreateResumePage(),
        '/templates': (context) => const TemplateScreen(), // Add TemplateScreen
      },
      home: const SplashScreen(), // Start with Splash Screen
    );
  }
}

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({super.key});

  @override
  _TemplateScreenState createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  final TemplateService _templateService = TemplateService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Resume Templates")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _templateService
            .fetchTemplateJson("temp_1"), // Fetch JSON from Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading template"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data found"));
          } else {
            Map<String, dynamic> template = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Template: ${template['template_name']}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...template['sections'].map<Widget>((section) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${section['title']}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        if (section['fields'] != null)
                          ...List.generate(section['fields'].length, (index) {
                            return Text("• ${section['fields'][index]}");
                          }),
                        const SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:resume_app/Screen/choose_template_page.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
import 'screen/splash_screen.dart';
import 'screen/selection_page.dart';
import 'screen/create_resume_page.dart';
//import 'screen/choose_templates_page.dart'; // Import ChooseTemplatePage
import 'screen/resume_preview_page.dart'; // Import ResumePreviewPage
import 'services/template_service.dart'; // Import TemplateService

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/login': (context) => const LoginPage(),
        '/resume_selection': (context) => const ResumeSelectionPage(),
        '/create_resume': (context) => const CreateResumePage(),
        '/templates': (context) => const TemplateScreen(),
        '/choose_template': (context) => const ChooseTemplatePage(userData: {}),
      },
      home: const SplashScreen(), // Start with Splash Screen
      onGenerateRoute: (settings) {
        if (settings.name == '/resume_preview') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ResumePreviewPage(
              userData: args['userData'],
              selectedTemplate: args['selectedTemplate'],
            ),
          );
        }
        return null;
      },
    );
  }
}

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({super.key});

  @override
  _TemplateScreenState createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  final TemplateService _templateService = TemplateService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Resume Templates")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _templateService
            .fetchTemplateJson("temp_1"), // Fetch JSON from Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading template"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data found"));
          } else {
            Map<String, dynamic> template = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Template: ${template['template_name']}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...List<Map<String, dynamic>>.from(template['sections'] ?? [])
                      .map((section) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${section['title']}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        if (section['fields'] != null)
                          ...List<String>.from(section['fields']).map((field) {
                            return Text("• $field");
                          }).toList(),
                        const SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
import 'screen/splash_screen.dart';
import 'screen/selection_page.dart';
import 'screen/create_resume_page.dart';
import 'screen/resume_preview_page.dart';
import 'screen/choose_template_page.dart';
import 'services/template_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/login': (context) => const LoginPage(),
        '/resume_selection': (context) => const ResumeSelectionPage(),
        '/create_resume': (context) => const CreateResumePage(),
        '/templates': (context) => const TemplateScreen(),
      },
      home: const SplashScreen(),
      onGenerateRoute: (settings) {
        // Handle navigation to ChooseTemplatePage
        if (settings.name == '/choose_template') {
          final args = settings.arguments as Map<String, dynamic>?;

          if (args == null || !args.containsKey('userData')) {
            return MaterialPageRoute(
              builder: (context) => const ErrorScreen(
                message: "Invalid user data. Missing userData.",
              ),
            );
          }

          return MaterialPageRoute(
            builder: (context) => ChooseTemplatePage(
              userData: args['userData'] ?? {},
            ),
          );
        }

        // Handle navigation to ResumePreviewPage
        if (settings.name == '/resume_preview') {
          final args = settings.arguments as Map<String, dynamic>?;

          if (args == null || !args.containsKey('templateId')) {
            return MaterialPageRoute(
              builder: (context) => const ErrorScreen(
                message: "Invalid template data. Missing templateId.",
              ),
            );
          }

          return MaterialPageRoute(
            builder: (context) => ResumePreviewPage(
              templateId: args['templateId'], // Pass templateId
              userData: args['userData'] ?? {}, // Pass userData
            ),
          );
        }

        return null;
      },
    );
  }
}

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({super.key});

  @override
  _TemplateScreenState createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  final TemplateService _templateService = TemplateService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Resume Templates")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _templateService.fetchTemplateJson("temp_1"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading template"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data found"));
          } else {
            Map<String, dynamic> template = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Template: ${template['template_name']}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...List<Map<String, dynamic>>.from(template['sections'] ?? [])
                      .map((section) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${section['title']}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        if (section['fields'] != null)
                          ...List<String>.from(section['fields']).map((field) {
                            return Text("• $field");
                          }).toList(),
                        const SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// Error handling screen
class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: Center(
          child: Text(message,
              style: const TextStyle(fontSize: 18, color: Colors.red))),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
import 'screen/splash_screen.dart';
import 'screen/selection_page.dart';
import 'screen/create_resume_page.dart';
import 'screen/resume_preview_page.dart';
import 'screen/choose_template_page.dart';
import 'screen/template_screen.dart'; // ✅ Added missing import
import 'screen/error_screen.dart'; // ✅ Added missing import
import 'services/template_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/login': (context) => const LoginPage(),
        '/resume_selection': (context) => const ResumeSelectionPage(),
        '/create_resume': (context) => const CreateResumePage(),
        '/templates': (context) => const TemplateScreen(),
      },
      home: const SplashScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/choose_template') {
          final args = settings.arguments as Map<String, dynamic>?;

          if (args == null || !args.containsKey('userData')) {
            return MaterialPageRoute(
              builder: (context) => const ErrorScreen(
                message: "Invalid user data. Missing userData.",
              ),
            );
          }

          return MaterialPageRoute(
            builder: (context) => ChooseTemplatePage(
              userData: args['userData'] ?? {},
            ),
          );
        }

        if (settings.name == '/resume_preview') {
          final args = settings.arguments as Map<String, dynamic>?;

          if (args == null || !args.containsKey('templateId')) {
            return MaterialPageRoute(
              builder: (context) => const ErrorScreen(
                message: "Invalid template data. Missing templateId.",
              ),
            );
          }

          return MaterialPageRoute(
            builder: (context) => ResumePreviewPage(
              templateId: args['templateId'],
              userData: args['userData'] ?? {},
            ),
          );
        }

        return null;
      },
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
import 'screen/splash_screen.dart';
import 'screen/selection_page.dart';
import 'screen/create_resume_page.dart';
import 'screen/resume_preview_page.dart';
import 'screen/choose_template_page.dart';
import 'screen/template_screen.dart';
import 'screen/error_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text("Error initializing Firebase: ${snapshot.error}"),
              ),
            ),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Resume Builder',
          theme: ThemeData(primarySwatch: Colors.teal),
          routes: {
            '/login': (context) => const LoginPage(),
            '/resume_selection': (context) => const ResumeSelectionPage(),
            '/create_resume': (context) => const CreateResumePage(),
            '/templates': (context) => const TemplateScreen(),
            '/choose_template': (context) =>
                const ErrorScreen(message: "Invalid navigation"), // Default
          },
          home: const SplashScreen(),
          onGenerateRoute: (settings) {
            if (settings.name == '/choose_template') {
              final args = settings.arguments;
              if (args is Map<String, dynamic> &&
                  args.containsKey('userData')) {
                return MaterialPageRoute(
                  builder: (context) => ChooseTemplatePage(
                    userData: args['userData'],
                  ),
                );
              }
              return MaterialPageRoute(
                builder: (context) =>
                    const ErrorScreen(message: "Invalid user data."),
              );
            }

            if (settings.name == '/resume_preview') {
              final args = settings.arguments;
              if (args is Map<String, dynamic> &&
                  args.containsKey('templateId')) {
                return MaterialPageRoute(
                  builder: (context) => ResumePreviewPage(
                    templateId: args['templateId'],
                    userData: args['userData'] ?? {},
                  ),
                );
              }
              return MaterialPageRoute(
                builder: (context) =>
                    const ErrorScreen(message: "Invalid template data."),
              );
            }

            return null; // Fallback to default Flutter navigation handling
          },
        );
      },
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
import 'screen/splash_screen.dart';
import 'screen/selection_page.dart';
import 'screen/create_resume_page.dart';
import 'screen/template_preview_page.dart';
import 'screen/choose_template_page.dart';
import 'services/template_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/login': (context) => const LoginPage(),
        '/resume_selection': (context) => const ResumeSelectionPage(),
        '/create_resume': (context) => const CreateResumePage(),
        '/template_preview': (context) => TemplatePreviewPage(
              template: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
      },
      home: const SplashScreen(),
      onGenerateRoute: (settings) {
        // Handle navigation to ChooseTemplatePage
        if (settings.name == '/choose_template') {
          final args = settings.arguments as Map<String, dynamic>?;

          if (args == null || !args.containsKey('userData')) {
            return MaterialPageRoute(
              builder: (context) => const ErrorScreen(
                message: "Invalid user data. Missing userData.",
              ),
            );
          }

          return MaterialPageRoute(
            builder: (context) => ChooseTemplatePage(
              userData: args['userData'] ?? {},
            ),
          );
        }

        // Handle navigation to ResumePreviewPage
        if (settings.name == '/resume_preview') {
          final args = settings.arguments as Map<String, dynamic>?;

          if (args == null || !args.containsKey('templateId')) {
            return MaterialPageRoute(
              builder: (context) => const ErrorScreen(
                message: "Invalid template data. Missing templateId.",
              ),
            );
          }

          return MaterialPageRoute(
            builder: (context) => TemplatePreviewPage(
              templateId: args['templateId'], // Pass templateId
              userData: args['userData'] ?? {}, // Pass userData
            ),
          );
        }

        return null;
      },
    );
  }
}

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({super.key});

  @override
  _TemplateScreenState createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  final TemplateService _templateService = TemplateService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Resume Templates")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _templateService.fetchTemplateJson("temp_1"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading template"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data found"));
          } else {
            Map<String, dynamic> template = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Template: ${template['template_name']}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...List<Map<String, dynamic>>.from(template['sections'] ?? [])
                      .map((section) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${section['title']}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        if (section['fields'] != null)
                          ...List<String>.from(section['fields']).map((field) {
                            return Text("• $field");
                          }).toList(),
                        const SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// Error handling screen
class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: Center(
          child: Text(message,
              style: const TextStyle(fontSize: 18, color: Colors.red))),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
import 'screen/splash_screen.dart';
import 'screen/selection_page.dart';
import 'screen/create_resume_page.dart';
import 'screen/resume_preview.dart';
import 'screen/resume_selection.dart';
import 'services/firestore_service.dart';
import 'dart:convert'; // Import JSON package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/login': (context) => const LoginPage(),
        '/resume_selection': (context) => const ResumeSelectionPage(),
        '/create_resume': (context) => const CreateResumePage(),
      },
      home: const SplashScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/choose_template') {
          final args = settings.arguments as Map<String, dynamic>?;

          if (args == null || !args.containsKey('userData')) {
            return MaterialPageRoute(
              builder: (context) => const ErrorScreen(
                message: "Invalid user data. Missing userData.",
              ),
            );
          }

          return MaterialPageRoute(
            builder: (context) => ChooseTemplatePage(
              userData: args['userData'] ?? {},
            ),
          );
        }

        if (settings.name == '/resume_preview') {
          final args = settings.arguments as Map<String, dynamic>?;

          if (args == null || !args.containsKey('templateId')) {
            return MaterialPageRoute(
              builder: (context) => const ErrorScreen(
                message: "Invalid template data. Missing templateId.",
              ),
            );
          }

          return MaterialPageRoute(
            builder: (context) => TemplatePreviewPage(
              templateId: args['templateId'],
              userData: args['userData'] ?? {},
            ),
          );
        }

        return null;
      },
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: Center(
        child: Text(message,
            style: const TextStyle(fontSize: 18, color: Colors.red)),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
import 'screen/splash_screen.dart'; // Import Splash Screen
import 'screen/selection_page.dart';
import 'screen/create_resume_page.dart'; // Import Create Resume Page
import 'screen/resume_selection.dart'; // Import Resume Selection Screen
import 'screen/summary_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ATS Resume Builder',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/resume_selection': (context) => ResumeSelectionScreen(),
        '/create_resume': (context) => const CreateResumePage(),
        '/generate_summary': (context) => const GenerateSummaryPage(),
      },
      home: const SplashScreen(), // Start with Splash Screen
    );
  }
}

/*

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
import 'screen/splash_screen.dart'; // Import Splash Screen
import 'screen/selection_page.dart';
import 'screen/create_resume_page.dart'; // Import Create Resume Page
import 'screen/resume_selection.dart'; // Import Resume Selection Screen
import 'screen/resume_preview.dart'; // Import Resume Preview Screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ATS Resume Builder',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Define routes for navigation
      routes: {
        '/login': (context) => const LoginPage(),
        '/resume_selection': (context) => ResumeSelectionScreen(),
        '/create_resume': (context) => const CreateResumePage(),
        '/resume_preview': (context) {
          // Extract arguments passed via Navigator.pushNamed
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return ResumePreviewScreen(
            template: args['template'],
            userData: args['userData'],
          );
        },
      },
      home: const SplashScreen(), // Start with Splash Screen
    );
  }
}*/
