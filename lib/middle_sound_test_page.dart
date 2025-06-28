import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MiddleSoundTestPage extends StatefulWidget {
  const MiddleSoundTestPage({super.key});

  @override
  State<MiddleSoundTestPage> createState() => _MiddleSoundTestPageState();
}

class _MiddleSoundTestPageState extends State<MiddleSoundTestPage> {
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final TextEditingController _textController = TextEditingController();
  String _currentQuestion = '';
  String _userAnswer = '';
  String _feedbackMessage = '';
  Color _feedbackColor = Colors.transparent;
  bool _isListening = false;
  bool _waitingForMic = false;
  bool _useTextInput = false;
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  late List<_MiddleSoundQuestion> _questions;
  bool _speechInitialized = false;

  @override
  void initState() {
    super.initState();
    _flutterTts.setSpeechRate(0.5);
    _questions = _buildQuestions();
    _initializeSpeech();
    _startTest();
  }

  Future<void> _initializeSpeech() async {
    _speechInitialized = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          setState(() => _isListening = false);
        }
      },
      onError: (error) {
        setState(() => _isListening = false);
      },
    );
  }

  List<_MiddleSoundQuestion> _buildQuestions() {
    return [
      // Basic middle sound questions
      _MiddleSoundQuestion(
        question: "What is the middle sound in cat?",
        answer: "a",
      ),
      _MiddleSoundQuestion(
        question: "What is the middle sound in dog?",
        answer: "o",
      ),
      _MiddleSoundQuestion(
        question: "What is the middle sound in sun?",
        answer: "u",
      ),
      _MiddleSoundQuestion(
        question: "What is the middle sound in hat?",
        answer: "a",
      ),
      _MiddleSoundQuestion(
        question: "What is the middle sound in run?",
        answer: "u",
      ),
      // Different question formats
      _MiddleSoundQuestion(
        question: "What sound is in the middle of big?",
        answer: "i",
      ),
      _MiddleSoundQuestion(
        question: "Say the middle sound in red.",
        answer: "e",
      ),
      _MiddleSoundQuestion(
        question: "What is the center sound in blue?",
        answer: "l",
      ),
      _MiddleSoundQuestion(
        question: "What sound comes in the middle of green?",
        answer: "r",
      ),
      _MiddleSoundQuestion(
        question: "What is the middle sound you hear in black?",
        answer: "l",
      ),
      // Multiple choice questions
      _MiddleSoundQuestion(
        question: "Which word has 'a' in the middle? a) cat b) dog c) sun",
        answer: "cat",
      ),
      _MiddleSoundQuestion(
        question: "Which word has 'o' in the middle? a) hat b) dog c) run",
        answer: "dog",
      ),
      _MiddleSoundQuestion(
        question: "Which word has 'u' in the middle? a) big b) sun c) red",
        answer: "sun",
      ),
      // More variety
      _MiddleSoundQuestion(
        question: "What is the middle sound in white?",
        answer: "i",
      ),
      _MiddleSoundQuestion(
        question: "What sound is in the middle of brown?",
        answer: "r",
      ),
      _MiddleSoundQuestion(
        question: "Say the middle sound in pink.",
        answer: "i",
      ),
      _MiddleSoundQuestion(
        question: "What is the center sound in purple?",
        answer: "ur",
      ),
      _MiddleSoundQuestion(
        question: "What sound comes in the middle of orange?",
        answer: "a",
      ),
      _MiddleSoundQuestion(
        question: "What is the middle sound you hear in yellow?",
        answer: "e",
      ),
      _MiddleSoundQuestion(
        question: "What sound is in the middle of book?",
        answer: "oo",
      ),
      _MiddleSoundQuestion(
        question: "Say the middle sound in ball.",
        answer: "a",
      ),
      _MiddleSoundQuestion(
        question: "What is the center sound in fish?",
        answer: "i",
      ),
      _MiddleSoundQuestion(
        question: "What sound comes in the middle of tree?",
        answer: "r",
      ),
      _MiddleSoundQuestion(
        question: "What is the middle sound you hear in moon?",
        answer: "oo",
      ),
      _MiddleSoundQuestion(
        question: "What sound is in the middle of star?",
        answer: "t",
      ),
      _MiddleSoundQuestion(
        question: "Say the middle sound in car.",
        answer: "a",
      ),
      _MiddleSoundQuestion(
        question: "What is the center sound in house?",
        answer: "ow",
      ),
      _MiddleSoundQuestion(
        question: "What sound comes in the middle of mouse?",
        answer: "ow",
      ),
      _MiddleSoundQuestion(
        question: "What is the middle sound you hear in cake?",
        answer: "a",
      ),
      _MiddleSoundQuestion(
        question: "What sound is in the middle of bike?",
        answer: "i",
      ),
      _MiddleSoundQuestion(
        question: "Say the middle sound in boat.",
        answer: "oa",
      ),
      _MiddleSoundQuestion(
        question: "What is the center sound in rain?",
        answer: "ai",
      ),
      _MiddleSoundQuestion(
        question: "What sound comes in the middle of train?",
        answer: "ai",
      ),
      _MiddleSoundQuestion(
        question: "What is the middle sound you hear in bird?",
        answer: "ir",
      ),
      _MiddleSoundQuestion(
        question: "What sound is in the middle of word?",
        answer: "or",
      ),
      _MiddleSoundQuestion(
        question: "Say the middle sound in light.",
        answer: "i",
      ),
      _MiddleSoundQuestion(
        question: "What is the center sound in night?",
        answer: "i",
      ),
      _MiddleSoundQuestion(
        question: "What sound comes in the middle of day?",
        answer: "a",
      ),
      _MiddleSoundQuestion(
        question: "What is the middle sound you hear in way?",
        answer: "a",
      ),
      _MiddleSoundQuestion(
        question: "What sound is in the middle of fun?",
        answer: "u",
      ),
      _MiddleSoundQuestion(
        question: "Say the middle sound in bun.",
        answer: "u",
      ),
      _MiddleSoundQuestion(
        question: "What is the center sound in pig?",
        answer: "i",
      ),
      _MiddleSoundQuestion(
        question: "What sound comes in the middle of bed?",
        answer: "e",
      ),
      _MiddleSoundQuestion(
        question: "What is the middle sound you hear in shoe?",
        answer: "oe",
      ),
      _MiddleSoundQuestion(
        question: "What sound is in the middle of bean?",
        answer: "ea",
      ),
      _MiddleSoundQuestion(
        question: "Say the middle sound in fellow.",
        answer: "e",
      ),
      _MiddleSoundQuestion(
        question: "What is the center sound in sack?",
        answer: "a",
      ),
      _MiddleSoundQuestion(
        question: "What sound comes in the middle of kite?",
        answer: "i",
      ),
      _MiddleSoundQuestion(
        question: "What is the middle sound you hear in clown?",
        answer: "ow",
      ),
      _MiddleSoundQuestion(
        question: "What sound is in the middle of sink?",
        answer: "i",
      ),
      _MiddleSoundQuestion(
        question: "Say the middle sound in turtle.",
        answer: "ur",
      ),
      _MiddleSoundQuestion(
        question: "What is the center sound in door hinge?",
        answer: "oor",
      ),
    ];
  }

  void _startTest() {
    _currentQuestionIndex = 0;
    _correctAnswers = 0;
    _userAnswer = '';
    _feedbackMessage = '';
    _feedbackColor = Colors.transparent;
    _currentQuestion = _questions[0].question;
    _speak(_currentQuestion);
    setState(() {
      _waitingForMic = true;
    });
  }

  Future<void> _speak(String text) async {
    await _flutterTts.speak(text);
    await _flutterTts.awaitSpeakCompletion(true);
  }

  Future<String> _listen() async {
    if (!_speechInitialized) {
      await _initializeSpeech();
    }
    
    if (!_speechInitialized) return '';
    
    setState(() => _isListening = true);
    await _speech.listen(
      localeId: 'en_US',
      listenFor: const Duration(seconds: 8),
      pauseFor: const Duration(seconds: 1),
      partialResults: false,
      listenMode: stt.ListenMode.confirmation,
    );
    
    // Wait for a shorter time
    int waited = 0;
    while (_isListening && waited < 9000) {
      await Future.delayed(const Duration(milliseconds: 100));
      waited += 100;
    }
    await _speech.stop();
    return _speech.lastRecognizedWords;
  }

  Future<void> _onMicPressed() async {
    setState(() {
      _waitingForMic = false;
    });
    
    final spoken = await _listen();
    _userAnswer = spoken;
    
    if (spoken.isEmpty) {
      setState(() {
        _feedbackMessage = "Didn't hear anything. Try again!";
        _feedbackColor = Colors.amber;
      });
      await _speak("I didn't hear you. Let's try again.");
      setState(() {
        _waitingForMic = true;
      });
      return;
    }
    
    // Immediate answer checking
    final correct = _checkAnswer(spoken);
    setState(() {
      _feedbackMessage = correct ? "Correct! Great job!" : "Oops! Try again!";
      _feedbackColor = correct ? Colors.green : Colors.red;
      if (correct) _correctAnswers++;
    });
    
    await _speak(_feedbackMessage);
    
    if (correct) {
      await Future.delayed(const Duration(seconds: 1));
      _nextQuestion();
    } else {
      setState(() {
        _waitingForMic = true;
      });
    }
  }

  bool _checkAnswer(String answer) {
    final q = _questions[_currentQuestionIndex];
    final user = answer.trim().toLowerCase();
    
    if (q.allowAnyAnswer != null) {
      return q.allowAnyAnswer!.any((a) => user.contains(a.toLowerCase()));
    }
    
    return user.contains(q.answer.toLowerCase());
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _userAnswer = '';
      _feedbackMessage = '';
      _feedbackColor = Colors.transparent;
    });
    if (_currentQuestionIndex < _questions.length) {
      _currentQuestion = _questions[_currentQuestionIndex].question;
      _speak(_currentQuestion);
      setState(() {
        _waitingForMic = true;
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    final score = (_correctAnswers / _questions.length * 100).round();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Test Complete!'),
        content: Text('You got $_correctAnswers out of ${_questions.length} correct!\nScore: $score%'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Back to Menu'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _startTest();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: const Text('Middle Sound Test'),
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: _questions.isEmpty ? 0 : (_currentQuestionIndex + 1) / _questions.length,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
            ),
            const SizedBox(height: 10),
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentQuestion,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _userAnswer.isNotEmpty ? "You said: $_userAnswer" : '',
                      style: const TextStyle(fontSize: 20, color: Colors.black87),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _feedbackMessage,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: _feedbackColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (_isListening)
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                      ),
                    if (_waitingForMic && !_isListening)
                      IconButton(
                        icon: const Icon(Icons.mic, size: 60, color: Colors.deepOrangeAccent),
                        tooltip: 'Tap to answer',
                        onPressed: _onMicPressed,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiddleSoundQuestion {
  final String question;
  final String answer;
  final List<String>? allowAnyAnswer;
  _MiddleSoundQuestion({required this.question, required this.answer, this.allowAnyAnswer});
} 