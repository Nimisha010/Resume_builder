import 'package:flutter/material.dart';
import 'create_resume_page.dart'; // Import the new page

class ResumeSelectionPage extends StatelessWidget {
  const ResumeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.teal], // Gradient colors
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Create Resume Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateResumePage(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/back_images/create_resumes.png', // Ensure this image is in your assets folder
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Create resume',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Saved Resumes Button
              /* GestureDetector(
                onTap: () {
                  // Navigate to saved resumes page (To be implemented)
                },
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/back_images/saved_resumes.png', // Ensure this image is in your assets folder
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Saved resumes',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
