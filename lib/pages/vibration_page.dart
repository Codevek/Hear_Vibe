import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'vibration_config_page.dart';

class VibrationPage extends StatefulWidget {
  const VibrationPage({super.key});

  @override
  State<VibrationPage> createState() => _VibrationPageState();
}

class _VibrationPageState extends State<VibrationPage> {
  final Map<String, bool> triggerWords = {
    "Emergency": true,
    "Come Here": true,
    "Help Me": true,
  };
  Future<void> _loadToggleStates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      triggerWords.forEach((key, _) {
        triggerWords[key] = prefs.getBool('enabled_$key') ?? true;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    _loadToggleStates();
  }

  final Color blueTone = const Color.fromRGBO(242, 250, 255, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueTone,
      appBar: AppBar(
        title: const Text("Trigger Words", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: blueTone,
        foregroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: triggerWords.length,
        itemBuilder: (context, index) {
          final word = triggerWords.keys.elementAt(index);
          final isEnabled = triggerWords[word]!;

          return Card(
            color: Colors.white,
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(word, style: const TextStyle(fontSize: 18)),
              trailing: Switch(
                value: isEnabled,
                activeColor: Colors.blue,
                onChanged: (value) async{
                  setState(() {
                    triggerWords[word] = value;
                  });
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('enabled_$word', value);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VibrationConfigPage(triggerWord: word),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}