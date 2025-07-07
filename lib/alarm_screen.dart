import 'package:flutter/material.dart';
import 'package:my_alarm_app/notification_service.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  void initState() {
    super.initState();
    NotificationService.playLoopingAlarm();
  }

  @override
  void dispose() {
    NotificationService.stopAlarm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('⏰ Alarm Ringing!', style: TextStyle(fontSize: 28)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                NotificationService.stopAlarm();
                Navigator.pop(context);
              },
              child: Text('Stop Alarm'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
