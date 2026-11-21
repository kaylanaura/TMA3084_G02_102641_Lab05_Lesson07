import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Card(
          child: ListTile(
            leading: Icon(Icons.trending_up, color: Colors.green),
            title: Text('Revenue'),
            subtitle: Text('Up 12% this quarter'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.people, color: Colors.blue),
            title: Text('Clients'),
            subtitle: Text('24 active accounts'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.event, color: Colors.deepPurple),
            title: Text('Meetings'),
            subtitle: Text('3 scheduled today'),
          ),
        ),
      ],
    );
  }
}
