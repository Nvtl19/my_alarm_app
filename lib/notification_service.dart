import 'package:audioplayers/audioplayers.dart';

class NotificationService {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playLoopingAlarm() async {
    try {
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.play(AssetSource('sounds/alarm.mp3'));
    } catch (e) {
      print('Error playing alarm: $e');
    }
  }

  static Future<void> stopAlarm() async {
    try {
      await _player.stop();
    } catch (e) {
      print('Error stopping alarm: $e');
    }
  }
}
