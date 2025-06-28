import 'package:flutter/material.dart';
import 'rhyming_test_page.dart';
import 'syllable_test_page.dart';
import 'segmenting_test_page.dart';
import 'blending_test_page.dart';
import 'initial_sound_test_page.dart';
import 'final_sound_test_page.dart';
import 'middle_sound_test_page.dart';

void main() {
  runApp(const TalkingBearApp());
}

class TalkingBearApp extends StatelessWidget {
  const TalkingBearApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talking Bear Phonological App',
      home: const BearHomePage(),
    );
  }
}

class BearHomePage extends StatefulWidget {
  const BearHomePage({super.key});

  @override
  State<BearHomePage> createState() => _BearHomePageState();
}

class _BearHomePageState extends State<BearHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: const Text('Talking Bear Phonological App'),
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Choose a Phonological Test',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _testCard(context, 'Rhyming', Icons.music_note, Colors.red, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const RhymingTestPage(),
                    ));
                  }),
                  _testCard(context, 'Syllables', Icons.audiotrack, Colors.blue, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const SyllableTestPage(),
                    ));
                  }),
                  _testCard(context, 'Segmenting', Icons.scatter_plot, Colors.green, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const SegmentingTestPage(),
                    ));
                  }),
                  _testCard(context, 'Blending', Icons.merge, Colors.purple, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const BlendingTestPage(),
                    ));
                  }),
                  _testCard(context, 'Initial Sound', Icons.text_fields, Colors.orange, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const InitialSoundTestPage(),
                    ));
                  }),
                  _testCard(context, 'Final Sound', Icons.text_fields, Colors.teal, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const FinalSoundTestPage(),
                    ));
                  }),
                  _testCard(context, 'Middle Sound', Icons.text_fields, Colors.indigo, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const MiddleSoundTestPage(),
                    ));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _testCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.8), color],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 