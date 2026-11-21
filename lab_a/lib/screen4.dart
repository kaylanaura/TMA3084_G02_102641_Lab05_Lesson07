import 'package:flutter/material.dart';

class Screen4 extends StatelessWidget {
  const Screen4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.school, size: 96, color: Colors.teal),
            SizedBox(height: 16),
            Text(
              'FCSIT, UNIMAS',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('Software Engineering')),
                Chip(label: Text('Formal Methods')),
                Chip(label: Text('Web Application Development')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
