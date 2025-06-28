import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SyllableTestPage extends StatefulWidget {
  const SyllableTestPage({super.key});

  @override
  State<SyllableTestPage> createState() => _SyllableTestPageState();
}

class _SyllableTestPageState extends State<SyllableTestPage> {
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
  late List<_SyllableQuestion> _questions;
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

  List<_SyllableQuestion> _buildQuestions() {
    return [
      // Counting questions
      _SyllableQuestion(
        question: "How many syllables are in the word apple?",
        answer: "two",
        allowAnyAnswer: ["2", "two", "2 syllables", "two syllables"],
      ),
      _SyllableQuestion(
        question: "How many syllables are in the word tiger?",
        answer: "two",
        allowAnyAnswer: ["2", "two", "2 syllables", "two syllables"],
      ),
      _SyllableQuestion(
        question: "How many syllables are in the word elephant?",
        answer: "three",
        allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
      ),
      _SyllableQuestion(
        question: "How many syllables are in the word butterfly?",
        answer: "three",
        allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
      ),
      _SyllableQuestion(
        question: "How many syllables are in the word computer?",
        answer: "three",
        allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
      ),
      // Clapping questions
      _SyllableQuestion(
        question: "Clap the syllables in rainbow.",
        answer: "rain bow",
        allowAnyAnswer: ["rain bow", "rainbow", "2", "two"],
      ),
      _SyllableQuestion(
        question: "Clap the syllables in sunshine.",
        answer: "sun shine",
        allowAnyAnswer: ["sun shine", "sunshine", "2", "two","sun sign","sun sine"],
      ),
      _SyllableQuestion(
        question: "Clap the syllables in basketball.",
        answer: "basket ball",
        allowAnyAnswer: ["basket ball", "basketball", "3", "three"],
      ),
      _SyllableQuestion(
        question: "Clap the syllables in telephone.",
        answer: "tel e phone",
        allowAnyAnswer: ["tel e phone", "telephone", "3", "three"],
      ),
      _SyllableQuestion(
        question: "Clap the syllables in dinosaur.",
        answer: "di no saur",
        allowAnyAnswer: ["di no saur", "dinosaur", "3", "three"],
      ),
      // Multiple choice
      _SyllableQuestion(
        question: "Which word has 3 syllables? a) apple b) elephant c) dog",
        answer: "elephant",
      ),
      _SyllableQuestion(
        question: "Which word has 2 syllables? a) cat b) tiger c) hippopotamus",
        answer: "tiger",
      ),
      _SyllableQuestion(
        question: "Which word has 4 syllables? a) butterfly b) helicopter c) dog",
        answer: "helicopter",
      ),
      // More variety
      _SyllableQuestion(
        question: "How many syllables in watermelon?",
        answer: "four",
        allowAnyAnswer: ["4", "four", "4 syllables", "four syllables"],
      ),
      _SyllableQuestion(
        question: "Clap the syllables in strawberry.",
        answer: "straw ber ry",
        allowAnyAnswer: ["straw ber ry", "strawberry", "3", "three"],
      ),
      _SyllableQuestion(
        question: "How many syllables in chocolate?",
        answer: "two",
        allowAnyAnswer: ["2", "two", "2 syllables", "two syllables"],
      ),
      _SyllableQuestion(
        question: "Which word has 2 syllables? a) pineapple b) cat c) crocodile",
        answer: "pineapple",
      ),
      _SyllableQuestion(
        question: "Clap the syllables in kangaroo.",
        answer: "kan ga roo",
        allowAnyAnswer: ["kan ga roo", "kangaroo", "3", "three"],
      ),
      _SyllableQuestion(
        question: "How many syllables in hippopotamus?",
        answer: "five",
        allowAnyAnswer: ["5", "five", "5 syllables", "five syllables"],
      ),
      _SyllableQuestion(
        question: "Which word has 3 syllables? a) octopus b) dog c) cat",
        answer: "octopus",
      ),
      _SyllableQuestion(
        question: "Clap the syllables in penguin.",
        answer: "pen guin",
        allowAnyAnswer: ["pen guin", "penguin", "2", "two"],
      ),
      _SyllableQuestion(
        question: "How many syllables in dolphin?",
        answer: "two",
        allowAnyAnswer: ["2", "two", "2 syllables", "two syllables"],
      ),
      _SyllableQuestion(
        question: "Which word has 3 syllables? a) flamingo b) bird c) fish",
        answer: "flamingo",
      ),
      _SyllableQuestion(
        question: "Clap the syllables in ladybug.",
        answer: "la dy bug",
        allowAnyAnswer: ["la dy bug", "ladybug", "3", "three"],
      ),
      _SyllableQuestion(
        question: "How many syllables in grasshopper?",
        answer: "three",
        allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
      ),
      _SyllableQuestion(
        question: "Which word has 4 syllables? a) caterpillar b) ant c) bee",
        answer: "caterpillar",
      ),
      _SyllableQuestion(
        question: "Clap the syllables in firefly.",
        answer: "fire fly",
        allowAnyAnswer: ["fire fly", "firefly", "2", "two"],
      ),
      _SyllableQuestion(
        question: "How many syllables in dragonfly?",
        answer: "three",
        allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
      ),
      _SyllableQuestion(
        question: "Which word has 3 syllables? a) bumblebee b) bee c) wasp",
        answer: "bumblebee",
      ),
      _SyllableQuestion(
        question: "Clap the syllables in honeybee.",
        answer: "hon ey bee",
        allowAnyAnswer: ["hon ey bee", "honeybee", "3", "three"],
      ),
      _SyllableQuestion(
        question: "How many syllables in sunflower?",
        answer: "three",
        allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
      ),
      _SyllableQuestion(
        question: "Which word has 3 syllables? a) daffodil b) rose c) tulip",
        answer: "daffodil",
      ),
      _SyllableQuestion(
        question: "Clap the syllables in tulip.",
        answer: "tu lip",
        allowAnyAnswer: ["tu lip", "tulip", "2", "two"],
      ),
      _SyllableQuestion(
        question: "How many syllables in rose?",
        answer: "one",
        allowAnyAnswer: ["1", "one", "1 syllable", "one syllable"],
      ),
      _SyllableQuestion(
        question: "Which word has 2 syllables? a) lily b) marigold c) daisy",
        answer: "marigold",
      ),
      _SyllableQuestion(
        question: "Clap the syllables in daisy.",
        answer: "dai sy",
        allowAnyAnswer: ["dai sy", "daisy", "2", "two"],
      ),
      _SyllableQuestion(
        question: "How many syllables in pansy?",
        answer: "two",
        allowAnyAnswer: ["2", "two", "2 syllables", "two syllables"],
      ),
      _SyllableQuestion(
        question: "Which word has 3 syllables? a) petunia b) iris c) aster",
        answer: "petunia",
      ),
      _SyllableQuestion(
        question: "Clap the syllables in zinnia.",
        answer: "zin ni a",
        allowAnyAnswer: ["zin ni a", "zinnia", "3", "three"],
      ),
      _SyllableQuestion(
        question: "How many syllables in aster?",
        answer: "two",
        allowAnyAnswer: ["2", "two", "2 syllables", "two syllables"],
      ),
      _SyllableQuestion(
        question: "Which word has 2 syllables? a) iris b) orchid c) carnation",
        answer: "iris",
      ),
      _SyllableQuestion(
        question: "Clap the syllables in orchid.",
        answer: "or chid",
        allowAnyAnswer: ["or chid", "orchid", "2", "two"],
      ),
      _SyllableQuestion(
        question: "How many syllables in carnation?",
        answer: "three",
        allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
      ),
      _SyllableQuestion(
        question: "Which word has 5 syllables? a) chrysanthemum b) begonia c) geranium",
        answer: "chrysanthemum",
      ),
      _SyllableQuestion(
        question: "Clap the syllables in begonia.",
        answer: "be go ni a",
        allowAnyAnswer: ["be go ni a", "begonia", "4", "four"],
      ),
      _SyllableQuestion(
        question: "How many syllables in geranium?",
        answer: "four",
        allowAnyAnswer: ["4", "four", "4 syllables", "four syllables"],
      ),
      _SyllableQuestion(
        question: "Which word has 4 syllables? a) impatiens b) snapdragon c) rose",
        answer: "impatiens",
      ),
      _SyllableQuestion(
        question: "Clap the syllables in snapdragon.",
        answer: "snap drag on",
        allowAnyAnswer: ["snap drag on", "snapdragon", "3", "three"],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: const Text('Syllable Test'),
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

class _SyllableQuestion {
  final String question;
  final String answer;
  final List<String>? allowAnyAnswer;
  _SyllableQuestion({required this.question, required this.answer, this.allowAnyAnswer});
} 