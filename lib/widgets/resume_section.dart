import 'package:flutter/material.dart';
import '../models/resume_template.dart';

class ResumeSection extends StatelessWidget {
  final Section section;
  ResumeSection({required this.section});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Column(
              children: section.fields.map((field) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(field,
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("User Input Here",
                          style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
