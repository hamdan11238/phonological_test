import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BlendingTestPage extends StatefulWidget {
  const BlendingTestPage({super.key});

  @override
  State<BlendingTestPage> createState() => _BlendingTestPageState();
}

class _BlendingTestPageState extends State<BlendingTestPage> {
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
  late List<_BlendingQuestion> _questions;
  bool _speechInitialized = false;

  @override
  void initState() {
    super.initState();
    _flutterTts.setSpeechRate(0.5);
    _questions = _buildQuestions();
    _initializeSpeech();
    _testSpeechRecognition();
    _startTest();
  }

  Future<void> _testSpeechRecognition() async {
    print('Testing speech recognition...');
    bool available = await _speech.initialize();
    print('Speech available: $available');
    
    if (available) {
      print('Speech recognition is available');
    } else {
      print('Speech recognition is NOT available');
    }
  }

  Future<void> _initializeSpeech() async {
    try {
      _speechInitialized = await _speech.initialize(
        onStatus: (status) {
          print('Speech status: $status');
          if (status == 'done' || status == 'notListening') {
            setState(() => _isListening = false);
          }
        },
        onError: (error) {
          print('Speech error: $error');
          setState(() => _isListening = false);
        },
      );
      print('Speech initialized: $_speechInitialized');
    } catch (e) {
      print('Speech initialization error: $e');
      _speechInitialized = false;
    }
  }

  List<_BlendingQuestion> _buildQuestions() {
    return [
      // Basic blending
      _BlendingQuestion(
        question: "What word do these sounds make: c a t?",
        answer: "cat",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: d o g?",
        answer: "dog",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: s u n?",
        answer: "sun",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: h a t?",
        answer: "hat",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: r u n?",
        answer: "run",
      ),
      // Different question formats
      _BlendingQuestion(
        question: "Blend these sounds: b i g",
        answer: "big",
      ),
      _BlendingQuestion(
        question: "What word do you get when you blend: r e d?",
        answer: "red",
      ),
      _BlendingQuestion(
        question: "Put these sounds together: b l ue",
        answer: "blue",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: g r ee n?",
        answer: "green",
      ),
      _BlendingQuestion(
        question: "Blend the sounds: b l a ck",
        answer: "black",
      ),
      // More complex words
      _BlendingQuestion(
        question: "What word do these sounds make: wh i t?",
        answer: "white",
      ),
      _BlendingQuestion(
        question: "Blend these sounds: b r ow n",
        answer: "brown",
      ),
      _BlendingQuestion(
        question: "What word do you get when you blend: p i nk?",
        answer: "pink",
      ),
      _BlendingQuestion(
        question: "Put these sounds together: p ur p l",
        answer: "purple",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: or a nge?",
        answer: "orange",
      ),
      // Different instruction styles
      _BlendingQuestion(
        question: "Blend the sounds: y e ll ow",
        answer: "yellow",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: b oo k?",
        answer: "book",
      ),
      _BlendingQuestion(
        question: "Put these sounds together: b a ll",
        answer: "ball",
      ),
      _BlendingQuestion(
        question: "What word do you get when you blend: f i sh?",
        answer: "fish",
      ),
      _BlendingQuestion(
        question: "Blend these sounds: t r ee",
        answer: "tree",
      ),
      // More variety
      _BlendingQuestion(
        question: "What word do these sounds make: m oo n?",
        answer: "moon",
      ),
      _BlendingQuestion(
        question: "Blend the sounds: s t ar",
        answer: "star",
      ),
      _BlendingQuestion(
        question: "What word do you get when you blend: c ar?",
        answer: "car",
      ),
      _BlendingQuestion(
        question: "Put these sounds together: h ow s",
        answer: "house",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: m ow s?",
        answer: "mouse",
      ),
      _BlendingQuestion(
        question: "Blend these sounds: c a k",
        answer: "cake",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: b i k?",
        answer: "bike",
      ),
      _BlendingQuestion(
        question: "Blend the sounds: b oa t",
        answer: "boat",
      ),
      _BlendingQuestion(
        question: "What word do you get when you blend: r ai n?",
        answer: "rain",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: t r ai n?",
        answer: "train",
      ),
      _BlendingQuestion(
        question: "Blend these sounds: b ir d",
        answer: "bird",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: w or d?",
        answer: "word",
      ),
      _BlendingQuestion(
        question: "Blend the sounds: l i gh t",
        answer: "light",
      ),
      _BlendingQuestion(
        question: "What word do you get when you blend: n i gh t?",
        answer: "night",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: d ay?",
        answer: "day",
      ),
      _BlendingQuestion(
        question: "Blend these sounds: w ay",
        answer: "way",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: f u n?",
        answer: "fun",
      ),
      _BlendingQuestion(
        question: "Blend the sounds: b u n",
        answer: "bun",
      ),
      _BlendingQuestion(
        question: "What word do you get when you blend: p i g?",
        answer: "pig",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: b e d?",
        answer: "bed",
      ),
      _BlendingQuestion(
        question: "Blend these sounds: sh oe",
        answer: "shoe",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: b ea n?",
        answer: "bean",
      ),
      _BlendingQuestion(
        question: "Blend the sounds: f e ll ow",
        answer: "fellow",
      ),
      _BlendingQuestion(
        question: "What word do you get when you blend: s a ck?",
        answer: "sack",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: k i t?",
        answer: "kite",
      ),
      _BlendingQuestion(
        question: "Blend these sounds: c l ow n",
        answer: "clown",
      ),
      _BlendingQuestion(
        question: "What word do these sounds make: s i nk?",
        answer: "sink",
      ),
      _BlendingQuestion(
        question: "Blend the sounds: t ur t l",
        answer: "turtle",
      ),
      _BlendingQuestion(
        question: "What word do you get when you blend: d oor h i nge?",
        answer: "door hinge",
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
      listenFor: const Duration(seconds: 12),
      pauseFor: const Duration(seconds: 2),
      partialResults: false,
      listenMode: stt.ListenMode.confirmation,
    );
    
    // Wait for a longer time
    int waited = 0;
    while (_isListening && waited < 13000) {
      await Future.delayed(const Duration(milliseconds: 100));
      waited += 100;
    }
    await _speech.stop();
    return _speech.lastRecognizedWords;
  }

  Future<void> _onMicPressed() async {
    setState(() {
      _waitingForMic = false;
      _isListening = false;
    });
    
    final spoken = await _listen();
    _userAnswer = spoken;
    
    if (spoken.isEmpty) {
      setState(() {
        _feedbackMessage = "Didn't hear anything. Try again!";
        _feedbackColor = Colors.amber;
        _waitingForMic = true;
        _isListening = false;
      });
      await _speak("I didn't hear you. Let's try again.");
      return;
    }
    
    // Immediate answer checking
    final correct = _checkAnswer(spoken);
    setState(() {
      _feedbackMessage = correct ? "Correct! Great job!" : "Oops! Try again!";
      _feedbackColor = correct ? Colors.green : Colors.red;
      if (correct) _correctAnswers++;
      _isListening = false;
    });
    
    await _speak(_feedbackMessage);
    
    if (correct) {
      await Future.delayed(const Duration(seconds: 1));
      _nextQuestion();
    } else {
      setState(() {
        _waitingForMic = true;
        _isListening = false;
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
        title: const Text('Blending Test'),
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

class _BlendingQuestion {
  final String question;
  final String answer;
  final List<String>? allowAnyAnswer;
  _BlendingQuestion({required this.question, required this.answer, this.allowAnyAnswer});
} 