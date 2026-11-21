import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  bool _alarmOn = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _alarmOn ? Icons.alarm_on : Icons.alarm_off,
            size: 96,
            color: _alarmOn ? Colors.orange : Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            '7:00 AM',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(_alarmOn ? 'Alarm is ON' : 'Alarm is OFF'),
          Switch(
            value: _alarmOn,
            onChanged: (value) => setState(() => _alarmOn = value),
          ),
        ],
      ),
    );
  }
}
