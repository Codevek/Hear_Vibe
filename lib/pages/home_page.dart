import 'package:flutter/material.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';

class HomePage extends StatefulWidget {
  final String firstName;
  final String middleName;
  final String lastName;
  final String nickName;

  const HomePage({
    super.key,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.nickName,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  PorcupineManager? _porcupineManager;
  String detectionMessage = '';
  Future<void> _checkMicPermissionAndStart() async {
    final status = await Permission.microphone.request();

    if (status.isGranted) {
      await _startWakeWordDetection();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Microphone permission is required")),
      );
    }
  }

  Future<void> _startWakeWordDetection() async {
    _porcupineManager = await PorcupineManager.fromKeywordPaths(
      'nWaxpX2URuqdT1ZAvzcSK4M/6yIXhdovnHW2z9kIWINDKKoBXXMAvQ==',
      ['assets/porcupine_models/Emergency_en_android_v3_0_0.ppn'],
          (int keywordIndex) => _onWakeWordDetected(),
      sensitivities: [0.65],
    );
    await _porcupineManager!.start();
  }

  @override
  void initState() {
    super.initState();
    _checkMicPermissionAndStart();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.95, end: 1.05).animate(_controller);

    _startWakeWordDetection();
  }

  Future<void> _onWakeWordDetected() async {
    setState(() {
      detectionMessage = 'Detected Emergency';
    });

    final prefs = await SharedPreferences.getInstance();
    final rawPattern = prefs.getStringList("vibration_Emergency") ?? [];
    final pattern = rawPattern.map((e) => int.tryParse(e) ?? 0).where((e) => e > 0).toList();

    if ((await Vibration.hasVibrator() ?? false) && pattern.isNotEmpty) {
      final withPauses = [0];
      for (final ms in pattern) {
        withPauses.add(ms);
        withPauses.add(150);
      }
      withPauses.removeLast();
      Vibration.vibrate(pattern: withPauses);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _porcupineManager?.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String fullName = widget.firstName;

    if (widget.middleName.isNotEmpty) {
      fullName += ' ${widget.middleName}';
    }

    fullName += ' ${widget.lastName}';

    if (widget.nickName.isNotEmpty) {
      fullName += " or ${widget.nickName}.";
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 250, 255, 1),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 28, right: 28),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Listening for\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      TextSpan(
                        text: widget.firstName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Color.fromRGBO(8, 129, 208, 1),
                        ),
                      ),
                      if (widget.middleName.isNotEmpty)
                        TextSpan(
                          text: ' ${widget.middleName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Color.fromRGBO(8, 129, 208, 1),
                          ),
                        ),
                      TextSpan(
                        text: ' ${widget.lastName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Color.fromRGBO(8, 129, 208, 1),
                        ),
                      ),
                      if (widget.nickName.isNotEmpty) ...[
                        TextSpan(
                          text: ' or ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        TextSpan(
                          text: widget.nickName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Color.fromRGBO(8, 129, 208, 1),
                          ),
                        ),
                      ],
                      TextSpan(
                        text: '.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.grey.shade800,
                        ),
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 30.0),
              child: ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  'lib/images/icon.png',
                  fit: BoxFit.contain,
                  height: 120,
                  width: 300,
                  color: const Color.fromRGBO(8, 129, 208, 1),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 260,
                  width: 275,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    detectionMessage,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}