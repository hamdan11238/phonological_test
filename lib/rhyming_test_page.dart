import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RhymingTestPage extends StatefulWidget {
  const RhymingTestPage({super.key});

  @override
  State<RhymingTestPage> createState() => _RhymingTestPageState();
}

class _RhymingTestPageState extends State<RhymingTestPage> {
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
  late List<_RhymingQuestion> _questions;
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

  List<_RhymingQuestion> _buildQuestions() {
    return [
      // Recognition
      _RhymingQuestion(
        question: "Which word rhymes with cat? a) dog  b) mat  c) fish",
        answer: "mat",
      ),
      _RhymingQuestion(
        question: "Which word rhymes with log? a) frog  b) sun  c) car",
        answer: "frog",
      ),
      _RhymingQuestion(
        question: "Which word rhymes with star? a) car  b) book  c) tree",
        answer: "car",
      ),
      _RhymingQuestion(
        question: "Which word rhymes with cake? a) bike  b) lake  c) sun",
        answer: "lake",
      ),
      // Production
      _RhymingQuestion(
        question: "Tell me a word that rhymes with dog.",
        answer: "log",
        allowAnyRhyme: ["fog", "hog", "jog", "frog", "bog", "cog", "log"],
      ),
      _RhymingQuestion(
        question: "Say a word that rhymes with sun.",
        answer: "fun",
        allowAnyRhyme: ["fun", "run", "bun", "none", "done", "gun"],
      ),
      _RhymingQuestion(
        question: "Can you think of a word that rhymes with tree?",
        answer: "bee",
        allowAnyRhyme: ["bee", "see", "free", "three", "knee", "flee", "key"],
      ),
      // Rhyme Judgment
      _RhymingQuestion(
        question: "Do cat and hat rhyme? (yes or no)",
        answer: "yes",
      ),
      _RhymingQuestion(
        question: "Do fish and dish rhyme? (yes or no)",
        answer: "yes",
      ),
      _RhymingQuestion(
        question: "Do book and ball rhyme? (yes or no)",
        answer: "no",
      ),
      _RhymingQuestion(
        question: "Do cake and bike rhyme? (yes or no)",
        answer: "no",
      ),
      // More variety
      _RhymingQuestion(
        question: "Which of these words rhymes with 'mouse'? a) house  b) dog  c) sun",
        answer: "house",
      ),
      _RhymingQuestion(
        question: "Say a word that rhymes with 'star'.",
        answer: "car",
        allowAnyRhyme: ["car", "bar", "far", "jar", "tar"],
      ),
      _RhymingQuestion(
        question: "Do 'night' and 'light' rhyme? (yes or no)",
        answer: "yes",
      ),
      _RhymingQuestion(
        question: "Which word rhymes with 'cake'? a) snake  b) sun  c) dog",
        answer: "snake",
      ),
      _RhymingQuestion(
        question: "Tell me a word that rhymes with 'red'.",
        answer: "bed",
        allowAnyRhyme: ["bed", "head", "said", "led", "fed"],
      ),
      _RhymingQuestion(
        question: "Do 'blue' and 'shoe' rhyme? (yes or no)",
        answer: "yes",
      ),
      _RhymingQuestion(
        question: "Which of these words rhymes with 'fun'? a) run  b) dog  c) cat",
        answer: "run",
      ),
      _RhymingQuestion(
        question: "Say a word that rhymes with 'pig'.",
        answer: "wig",
        allowAnyRhyme: ["wig", "big", "dig", "fig", "jig"],
      ),
      _RhymingQuestion(
        question: "Do 'moon' and 'soon' rhyme? (yes or no)",
        answer: "yes",
      ),
      _RhymingQuestion(
        question: "Which word rhymes with 'cake'? a) lake  b) sun  c) dog",
        answer: "lake",
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
      
      // Check if speech is available
      bool available = await _speech.initialize();
      if (!available) {
        print('Speech not available');
        setState(() => _isListening = false);
        return '';
      }
      
      await _speech.listen(
        localeId: 'en_US',
        listenFor: const Duration(seconds: 12),
        pauseFor: const Duration(seconds: 2),
        partialResults: false,
        listenMode: stt.ListenMode.confirmation,
        onResult: (result) {
          print('Speech result: ${result.recognizedWords}');
        },
      );
      
      // Wait for a longer time
      int waited = 0;
      while (_isListening && waited < 13000) {
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
    
    if (q.allowAnyRhyme != null) {
      return q.allowAnyRhyme!.any((r) => user.contains(r.toLowerCase()));
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

  Future<void> _onTextSubmitted(String text) async {
    if (text.trim().isEmpty) return;
    
    setState(() {
      _waitingForMic = false;
      _userAnswer = text.trim();
    });
    
    // Immediate answer checking
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
        title: const Text('Rhyming Test'),
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
                        onPressed: _onMicPressed,
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

class _RhymingQuestion {
  final String question;
  final String answer;
  final List<String>? allowAnyRhyme;
  _RhymingQuestion({required this.question, required this.answer, this.allowAnyRhyme});
}

