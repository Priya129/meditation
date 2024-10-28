import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String duration;
  final String imagePath;

  DetailScreen({
    required this.title,
    required this.duration,
    required this.imagePath,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  bool isSpeaking = false;
  double playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _toggleSpeakPause() async {
    if (isSpeaking) {
      await _flutterTts.stop();
    } else {
      _speakInstructions();
    }
    setState(() {
      isSpeaking = !isSpeaking;
    });
  }

  Future<void> _speakInstructions() async {
    List<String> instructions = [
      'Step 1: Prepare your materials and make sure you have everything you need.',
      'Step 2: Follow the instructions step by step to ensure the best results.',
      'Step 3: Double-check your work for any mistakes.',
      'Step 4: Clean up and put away your materials when finished.',
    ];

    _flutterTts.setSpeechRate(playbackSpeed);
    _flutterTts.awaitSpeakCompletion(true);

    for (String instruction in instructions) {
      await _flutterTts.speak(instruction);
      await Future.delayed(const Duration(seconds: 3));
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.imagePath,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Instructions:',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: const [
                    ListTile(
                      leading: Text('•', style: TextStyle(color: Colors.white, fontSize: 20)),
                      title: Text(
                        'Step 1: Prepare your materials and make sure you have everything you need.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      leading: Text('•', style: TextStyle(color: Colors.white, fontSize: 20)),
                      title: Text(
                        'Step 2: Follow the instructions step by step to ensure the best results.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      leading: Text('•', style: TextStyle(color: Colors.white, fontSize: 20)),
                      title: Text(
                        'Step 3: Double-check your work for any mistakes.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      leading: Text('•', style: TextStyle(color: Colors.white, fontSize: 20)),
                      title: Text(
                        'Step 4: Clean up and put away your materials when finished.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(isSpeaking ? Icons.pause : Icons.play_arrow, color: Colors.white),
                    onPressed: _toggleSpeakPause,
                  ),
                  const SizedBox(width: 16),
                  const Text('Speed:', style: TextStyle(color: Colors.white)),
                  Slider(
                    value: playbackSpeed,
                    min: 0.5,
                    max: 1.5,
                    divisions: 4,
                    label: playbackSpeed.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() {
                        playbackSpeed = value;
                        _flutterTts.setSpeechRate(playbackSpeed);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
