import 'package:flutter/material.dart';
import 'dart:async';
import 'alarm_screen.dart';

void main() {
  runApp(AlarmApp());
}

class AlarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarm App',
      debugShowCheckedModeBanner: false,
      home: AlarmHomeScreen(),
    );
  }
}

class AlarmHomeScreen extends StatefulWidget {
  @override
  _AlarmHomeScreenState createState() => _AlarmHomeScreenState();
}

class _AlarmHomeScreenState extends State<AlarmHomeScreen> {
  TimeOfDay? selectedTime;
  Timer? alarmTimer;

  void _pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });

      _scheduleAlarm(time);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Alarm set for ${time.format(context)}'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _scheduleAlarm(TimeOfDay time) {
    final now = DateTime.now();
    DateTime alarmTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (alarmTime.isBefore(now)) {
      alarmTime = alarmTime.add(Duration(days: 1)); // Next day
    }

    final difference = alarmTime.difference(now);
    print('⏰ Alarm will ring in ${difference.inSeconds} seconds');

    alarmTimer?.cancel();
    alarmTimer = Timer(difference, () {
      print('🔔 Alarm Triggered');
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => AlarmScreen()));
    });
  }

  @override
  void dispose() {
    alarmTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alarm App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _pickTime, child: Text('Set Alarm')),
            SizedBox(height: 20),
            if (selectedTime != null)
              Text(
                'Alarm set for: ${selectedTime!.format(context)}',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
