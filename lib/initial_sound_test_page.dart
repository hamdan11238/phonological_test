import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class InitialSoundTestPage extends StatefulWidget {
  const InitialSoundTestPage({super.key});

  @override
  State<InitialSoundTestPage> createState() => _InitialSoundTestPageState();
}

class _InitialSoundTestPageState extends State<InitialSoundTestPage> {
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
  late List<_InitialSoundQuestion> _questions;
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

  List<_InitialSoundQuestion> _buildQuestions() {
    return [
      // Basic initial sound questions
      _InitialSoundQuestion(
        question: "What is the first sound in cat?",
        answer: "ka",
      ),
      _InitialSoundQuestion(
        question: "What is the first sound in dog?",
        answer: "d",
      ),
      

      _InitialSoundQuestion(
        question: "What is the first sound in hat?",
        answer: "ha",
      ),
      _InitialSoundQuestion(
        question: "What is the first sound in run?",
        answer: "r",
      ),
      // Different question formats
      _InitialSoundQuestion(
        question: "What sound does big start with?",
        answer: "b",
      ),
      _InitialSoundQuestion(
        question: "Say the first sound in red.",
        answer: "r",
      ),
      _InitialSoundQuestion(
        question: "What is the beginning sound in blue?",
        answer: "b",
      ),
      _InitialSoundQuestion(
        question: "What sound comes first in green?",
        answer: "g",
      ),
      _InitialSoundQuestion(
        question: "What is the first sound you hear in black?",
        answer: "b",
      ),
      // Multiple choice questions
      _InitialSoundQuestion(
        question: "Which word starts with 'c'? a) cat b) dog c) sun",
        answer: "cat",
      ),
      _InitialSoundQuestion(
        question: "Which word starts with 'd'? a) hat b) dog c) run",
        answer: "dog",
      ),
      _InitialSoundQuestion(
        question: "Which word starts with 's'? a) big b) sun c) red",
        answer: "sun",
      ),
      // More variety
      _InitialSoundQuestion(
        question: "What is the first sound in white?",
        answer: "w",
      ),
      _InitialSoundQuestion(
        question: "What sound does brown start with?",
        answer: "b",
      ),
      _InitialSoundQuestion(
        question: "Say the first sound in pink.",
        answer: "p",
      ),
      _InitialSoundQuestion(
        question: "What is the beginning sound in purple?",
        answer: "p",
      ),
      _InitialSoundQuestion(
        question: "What sound comes first in orange?",
        answer: "o",
      ),
      _InitialSoundQuestion(
        question: "What is the first sound you hear in yellow?",
        answer: "y",
      ),
      _InitialSoundQuestion(
        question: "What sound does book start with?",
        answer: "b",
      ),
      _InitialSoundQuestion(
        question: "Say the first sound in ball.",
        answer: "b",
      ),
      _InitialSoundQuestion(
        question: "What is the beginning sound in fish?",
        answer: "f",
      ),
      _InitialSoundQuestion(
        question: "What sound comes first in tree?",
        answer: "t",
      ),
      _InitialSoundQuestion(
        question: "What is the first sound you hear in moon?",
        answer: "m",
      ),
      _InitialSoundQuestion(
        question: "What sound does star start with?",
        answer: "s",
      ),
      _InitialSoundQuestion(
        question: "Say the first sound in car.",
        answer: "c",
      ),
      _InitialSoundQuestion(
        question: "What is the beginning sound in house?",
        answer: "h",
      ),
      _InitialSoundQuestion(
        question: "What sound comes first in mouse?",
        answer: "m",
      ),
      _InitialSoundQuestion(
        question: "What is the first sound you hear in cake?",
        answer: "c",
      ),
      _InitialSoundQuestion(
        question: "What sound does bike start with?",
        answer: "b",
      ),
      _InitialSoundQuestion(
        question: "Say the first sound in boat.",
        answer: "b",
      ),
      _InitialSoundQuestion(
        question: "What is the beginning sound in rain?",
        answer: "r",
      ),
      _InitialSoundQuestion(
        question: "What sound comes first in train?",
        answer: "t",
      ),
      _InitialSoundQuestion(
        question: "What is the first sound you hear in bird?",
        answer: "b",
      ),
      _InitialSoundQuestion(
        question: "What sound does word start with?",
        answer: "w",
      ),
      _InitialSoundQuestion(
        question: "Say the first sound in light.",
        answer: "l",
      ),
      _InitialSoundQuestion(
        question: "What is the beginning sound in night?",
        answer: "n",
      ),
      _InitialSoundQuestion(
        question: "What sound comes first in day?",
        answer: "d",
      ),
      _InitialSoundQuestion(
        question: "What is the first sound you hear in way?",
        answer: "w",
      ),
      _InitialSoundQuestion(
        question: "What sound does fun start with?",
        answer: "f",
      ),
      _InitialSoundQuestion(
        question: "Say the first sound in bun.",
        answer: "b",
      ),
      _InitialSoundQuestion(
        question: "What is the beginning sound in pig?",
        answer: "p",
      ),
      _InitialSoundQuestion(
        question: "What sound comes first in bed?",
        answer: "b",
      ),
      _InitialSoundQuestion(
        question: "What is the first sound you hear in shoe?",
        answer: "sh",
      ),
      _InitialSoundQuestion(
        question: "What sound does bean start with?",
        answer: "b",
      ),
      _InitialSoundQuestion(
        question: "Say the first sound in fellow.",
        answer: "f",
      ),
      _InitialSoundQuestion(
        question: "What is the beginning sound in sack?",
        answer: "s",
      ),
      _InitialSoundQuestion(
        question: "What sound comes first in kite?",
        answer: "k",
      ),
      _InitialSoundQuestion(
        question: "What is the first sound you hear in clown?",
        answer: "c",
      ),
      _InitialSoundQuestion(
        question: "What sound does sink start with?",
        answer: "s",
      ),
      _InitialSoundQuestion(
        question: "Say the first sound in turtle.",
        answer: "t",
      ),
      _InitialSoundQuestion(
        question: "What is the beginning sound in door hinge?",
        answer: "d",
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
    if (!_speechInitialized) {
      print('Speech not initialized');
      return '';
    }
    try {
      setState(() => _isListening = true);
      bool available = await _speech.initialize();
      if (!available) {
        print('Speech not available');
        setState(() => _isListening = false);
        return '';
      }
      await _speech.listen(
        localeId: 'en_US',
        listenFor: const Duration(seconds: 12),
        pauseFor: const Duration(seconds: 3),
        partialResults: false,
        listenMode: stt.ListenMode.confirmation,
        onResult: (result) {
          print('Speech result: [32m${result.recognizedWords}[0m');
        },
      );
      int waited = 0;
      while (_isListening && waited < 15000) {
        await Future.delayed(const Duration(milliseconds: 100));
        waited += 100;
      }
      await _speech.stop();
      String result = _speech.lastRecognizedWords;
      print('Final result: "$result"');
      return result;
    } catch (e) {
      print('Listen error: $e');
      setState(() => _isListening = false);
      return '';
    }
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

  Future<void> _onTextSubmitted(String text) async {
    if (text.trim().isEmpty) return;
    setState(() {
      _waitingForMic = false;
      _userAnswer = text.trim();
    });
    final correct = _checkAnswer(text.trim());
    setState(() {
      _feedbackMessage = correct ? "Correct! Great job!" : "Oops! Try again!";
      _feedbackColor = correct ? Colors.green : Colors.red;
      if (correct) _correctAnswers++;
    });
    await _speak(_feedbackMessage);
    if (correct) {
      await Future.delayed(const Duration(seconds: 1));
      _textController.clear();
      _nextQuestion();
    } else {
      setState(() {
        _waitingForMic = true;
      });
      _textController.clear();
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
        title: const Text('Initial Sound Test'),
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
                    if (_waitingForMic && !_isListening && !_useTextInput)
                      IconButton(
                        icon: const Icon(Icons.mic, size: 60, color: Colors.deepOrangeAccent),
                        tooltip: 'Tap to answer',
                        onPressed: () => _onMicPressed(),
                      ),
                    if (_waitingForMic && !_isListening && _useTextInput)
                      Column(
                        children: [
                          TextField(
                            controller: _textController,
                            decoration: const InputDecoration(
                              hintText: 'Type your answer here...',
                              border: OutlineInputBorder(),
                            ),
                            onSubmitted: (value) => _onTextSubmitted(value),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => _onTextSubmitted(_textController.text),
                            child: const Text('Submit Answer'),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Input Method: '),
                        Switch(
                          value: _useTextInput,
                          onChanged: (value) {
                            setState(() {
                              _useTextInput = value;
                              _textController.clear();
                            });
                          },
                        ),
                        Text(_useTextInput ? 'Text' : 'Voice'),
                      ],
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

class _InitialSoundQuestion {
  final String question;
  final String answer;
  final List<String>? allowAnyAnswer;
  _InitialSoundQuestion({required this.question, required this.answer, this.allowAnyAnswer});
} 