// ignore_for_file: file_names, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';

import '../../providers/ads_controllor.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  static const int maxSeconds = 60; // Set your timer max seconds
  int currentSeconds = 0; // Timer's current time
  Timer? _timer;
  bool isRunning = false;

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel(); // Cancel any existing timer if one exists
    }
    setState(() {
      isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (currentSeconds < maxSeconds) {
          currentSeconds++;
        } else {
          _timer!.cancel();
          isRunning = false;
        }
      });
    });
  }

  void pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    setState(() {
      currentSeconds = 0;
      isRunning = false;
    });
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  String getTimeString() {
    int minutes = currentSeconds ~/ 60;
    int seconds = currentSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AdsController());
    AdsController adcontroller = Get.put(AdsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer Clock'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Beautiful Clock UI
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: currentSeconds / maxSeconds,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation(Colors.blue),
                  ),
                ),
                Text(
                  getTimeString(),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Buttons for Start/Pause/Reset
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: isRunning ? pauseTimer : startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRunning ? Colors.orange : Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                  ),
                  child: Text(isRunning ? 'Pause' : 'Start',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  onPressed: resetTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
