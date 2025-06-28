import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SegmentingTestPage extends StatefulWidget {
  const SegmentingTestPage({super.key});

  @override
  State<SegmentingTestPage> createState() => _SegmentingTestPageState();
}

class _SegmentingTestPageState extends State<SegmentingTestPage> {
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
  late List<_SegmentingQuestion> _questions;
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

  List<_SegmentingQuestion> _buildQuestions() {
    return [
      // Basic segmenting
      _SegmentingQuestion(
        question: "What sounds do you hear in cat?",
        answer: "c a t",
        allowAnyAnswer: ["c a t", "cat", "c at", "ca t"],
      ),
      _SegmentingQuestion(
        question: "What sounds do you hear in dog?",
        answer: "d o g",
        allowAnyAnswer: ["d o g", "dog", "d og", "do g"],
      ),
      _SegmentingQuestion(
        question: "What sounds do you hear in sun?",
        answer: "s u n",
        allowAnyAnswer: ["s u n", "sun", "s un", "su n"],
      ),
      _SegmentingQuestion(
        question: "What sounds do you hear in hat?",
        answer: "h a t",
        allowAnyAnswer: ["h a t", "hat", "h at", "ha t"],
      ),
      _SegmentingQuestion(
        question: "What sounds do you hear in run?",
        answer: "r u n",
        allowAnyAnswer: ["r u n", "run", "r un", "ru n"],
      ),
      // Different question formats
      _SegmentingQuestion(
        question: "Say each sound in big.",
        answer: "b i g",
        allowAnyAnswer: ["b i g", "big", "b ig", "bi g"],
      ),
      _SegmentingQuestion(
        question: "Break down the word red into sounds.",
        answer: "r e d",
        allowAnyAnswer: ["r e d", "red", "r ed", "re d"],
      ),
      _SegmentingQuestion(
        question: "What are the sounds in blue?",
        answer: "b l ue",
        allowAnyAnswer: ["b l ue", "blue", "b lue", "bl ue"],
      ),
      _SegmentingQuestion(
        question: "Segment the word green.",
        answer: "g r ee n",
        allowAnyAnswer: ["g r ee n", "green", "g reen", "gr een"],
      ),
      _SegmentingQuestion(
        question: "Tell me the sounds in black.",
        answer: "b l a ck",
        allowAnyAnswer: ["b l a ck", "black", "b lack", "bl ack"],
      ),
      // More complex words
      _SegmentingQuestion(
        question: "What sounds do you hear in white?",
        answer: "wh i t",
        allowAnyAnswer: ["wh i t", "white", "wh ite", "whi te"],
      ),
      _SegmentingQuestion(
        question: "Say each sound in brown.",
        answer: "b r ow n",
        allowAnyAnswer: ["b r ow n", "brown", "b rown", "br own"],
      ),
      _SegmentingQuestion(
        question: "What sounds are in pink?",
        answer: "p i nk",
        allowAnyAnswer: ["p i nk", "pink", "p ink", "pi nk"],
      ),
      _SegmentingQuestion(
        question: "Break down purple into sounds.",
        answer: "p ur p l",
        allowAnyAnswer: ["p ur p l", "purple", "p urple", "pur ple"],
      ),
      _SegmentingQuestion(
        question: "What sounds do you hear in orange?",
        answer: "or a nge",
        allowAnyAnswer: ["or a nge", "orange", "or ange", "ora nge"],
      ),
      // Different instruction styles
      _SegmentingQuestion(
        question: "Segment the word yellow.",
        answer: "y e ll ow",
        allowAnyAnswer: ["y e ll ow", "yellow", "y ellow", "ye llow"],
      ),
      _SegmentingQuestion(
        question: "What sounds make up book?",
        answer: "b oo k",
        allowAnyAnswer: ["b oo k", "book", "b ook", "bo ok"],
      ),
      _SegmentingQuestion(
        question: "Say each sound in ball.",
        answer: "b a ll",
        allowAnyAnswer: ["b a ll", "ball", "b all", "ba ll"],
      ),
      _SegmentingQuestion(
        question: "What sounds do you hear in fish?",
        answer: "f i sh",
        allowAnyAnswer: ["f i sh", "fish", "f ish", "fi sh"],
      ),
      _SegmentingQuestion(
        question: "Break down tree into sounds.",
        answer: "t r ee",
        allowAnyAnswer: ["t r ee", "tree", "t ree", "tr ee"],
      ),
      // More variety
      _SegmentingQuestion(
        question: "What sounds are in moon?",
        answer: "m oo n",
        allowAnyAnswer: ["m oo n", "moon", "m oon", "mo on"],
      ),
      _SegmentingQuestion(
        question: "Segment the word star.",
        answer: "s t ar",
        allowAnyAnswer: ["s t ar", "star", "s tar", "st ar"],
      ),
      _SegmentingQuestion(
        question: "What sounds do you hear in car?",
        answer: "c ar",
        allowAnyAnswer: ["c ar", "car", "c ar"],
      ),
      _SegmentingQuestion(
        question: "Say each sound in house.",
        answer: "h ow s",
        allowAnyAnswer: ["h ow s", "house", "h ouse", "ho use"],
      ),
      _SegmentingQuestion(
        question: "What sounds make up mouse?",
        answer: "m ow s",
        allowAnyAnswer: ["m ow s", "mouse", "m ouse", "mo use"],
      ),
      _SegmentingQuestion(
        question: "Break down cake into sounds.",
        answer: "c a k",
        allowAnyAnswer: ["c a k", "cake", "c ake", "ca ke"],
      ),
      _SegmentingQuestion(
        question: "What sounds do you hear in bike?",
        answer: "b i k",
        allowAnyAnswer: ["b i k", "bike", "b ike", "bi ke"],
      ),
      _SegmentingQuestion(
        question: "Segment the word boat.",
        answer: "b oa t",
        allowAnyAnswer: ["b oa t", "boat", "b oat", "bo at"],
      ),
      _SegmentingQuestion(
        question: "What sounds are in rain?",
        answer: "r ai n",
        allowAnyAnswer: ["r ai n", "rain", "r ain", "ra in"],
      ),
      _SegmentingQuestion(
        question: "Say each sound in train.",
        answer: "t r ai n",
        allowAnyAnswer: ["t r ai n", "train", "t rain", "tr ain"],
      ),
      _SegmentingQuestion(
        question: "What sounds do you hear in bird?",
        answer: "b ir d",
        allowAnyAnswer: ["b ir d", "bird", "b ird", "bi rd"],
      ),
      _SegmentingQuestion(
        question: "Break down word into sounds.",
        answer: "w or d",
        allowAnyAnswer: ["w or d", "word", "w ord", "wo rd"],
      ),
      _SegmentingQuestion(
        question: "What sounds make up light?",
        answer: "l i gh t",
        allowAnyAnswer: ["l i gh t", "light", "l ight", "li ght"],
      ),
      _SegmentingQuestion(
        question: "Segment the word night.",
        answer: "n i gh t",
        allowAnyAnswer: ["n i gh t", "night", "n ight", "ni ght"],
      ),
      _SegmentingQuestion(
        question: "What sounds do you hear in day?",
        answer: "d ay",
        allowAnyAnswer: ["d ay", "day", "d ay"],
      ),
      _SegmentingQuestion(
        question: "Say each sound in way.",
        answer: "w ay",
        allowAnyAnswer: ["w ay", "way", "w ay"],
      ),
      _SegmentingQuestion(
        question: "What sounds are in fun?",
        answer: "f u n",
        allowAnyAnswer: ["f u n", "fun", "f un", "fu n"],
      ),
      _SegmentingQuestion(
        question: "Break down bun into sounds.",
        answer: "b u n",
        allowAnyAnswer: ["b u n", "bun", "b un", "bu n"],
      ),
      _SegmentingQuestion(
        question: "What sounds do you hear in pig?",
        answer: "p i g",
        allowAnyAnswer: ["p i g", "pig", "p ig", "pi g"],
      ),
      _SegmentingQuestion(
        question: "Segment the word bed.",
        answer: "b e d",
        allowAnyAnswer: ["b e d", "bed", "b ed", "be d"],
      ),
      _SegmentingQuestion(
        question: "What sounds make up shoe?",
        answer: "sh oe",
        allowAnyAnswer: ["sh oe", "shoe", "sh oe"],
      ),
      _SegmentingQuestion(
        question: "Say each sound in bean.",
        answer: "b ea n",
        allowAnyAnswer: ["b ea n", "bean", "b ean", "be an"],
      ),
      _SegmentingQuestion(
        question: "What sounds do you hear in fellow?",
        answer: "f e ll ow",
        allowAnyAnswer: ["f e ll ow", "fellow", "f ellow", "fe llow"],
      ),
      _SegmentingQuestion(
        question: "Break down sack into sounds.",
        answer: "s a ck",
        allowAnyAnswer: ["s a ck", "sack", "s ack", "sa ck"],
      ),
      _SegmentingQuestion(
        question: "What sounds are in kite?",
        answer: "k i t",
        allowAnyAnswer: ["k i t", "kite", "k ite", "ki te"],
      ),
      _SegmentingQuestion(
        question: "Segment the word clown.",
        answer: "c l ow n",
        allowAnyAnswer: ["c l ow n", "clown", "c lown", "cl own"],
      ),
      _SegmentingQuestion(
        question: "What sounds do you hear in sink?",
        answer: "s i nk",
        allowAnyAnswer: ["s i nk", "sink", "s ink", "si nk"],
      ),
      _SegmentingQuestion(
        question: "Break down turtle into sounds.",
        answer: "t ur t l",
        allowAnyAnswer: ["t ur t l", "turtle", "t urtle", "tu rtle"],
      ),
      _SegmentingQuestion(
        question: "What sounds make up door hinge?",
        answer: "d oor h i nge",
        allowAnyAnswer: ["d oor h i nge", "door hinge", "d oorhinge", "doo rhinge"],
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
        title: const Text('Segmenting Test'),
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

class _SegmentingQuestion {
  final String question;
  final String answer;
  final List<String>? allowAnyAnswer;
  _SegmentingQuestion({required this.question, required this.answer, this.allowAnyAnswer});
} 