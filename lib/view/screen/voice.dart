// // import 'package:speech_to_text/speech_recognition_error.dart';
// // import 'package:speech_to_text/speech_recognition_result.dart';
// // import 'package:speech_to_text/speech_to_text.dart';
// // import 'package:flutter/material.dart';

// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({Key? key, required this.control}) : super(key: key);
// //   final TextEditingController control;
// //   @override
// //   MyHomePageState createState() => MyHomePageState();
// // }

// // class MyHomePageState extends State<MyHomePage> {
// //   final SpeechToText _speechToText = SpeechToText();
// //   bool _speechEnabled = false;
// //   bool _speechAvailable = false;
// //   String _lastWords = '';
// //   String _currentWords = '';
// //   final String _selectedLocaleId = 'es_MX';

// //   printLocales() async {
// //     var locales = await _speechToText.locales();
// //     for (var local in locales) {
// //       debugPrint(local.name);
// //       debugPrint(local.localeId);
// //     }
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initSpeech();
// //   }

// //   void errorListener(SpeechRecognitionError error) {
// //     debugPrint(error.errorMsg.toString());
// //   }

// //   void statusListener(String status) async {
// //     debugPrint("status $status");
// //     if (status == "done" && _speechEnabled) {
// //       setState(() {
// //         _lastWords += " $_currentWords";
// //         _currentWords = "";
// //         _speechEnabled = false;
// //       });
// //       await _startListening();
// //     }
// //   }

// //   /// This has to happen only once per app
// //   void _initSpeech() async {
// //     _speechAvailable = await _speechToText.initialize(
// //         onError: errorListener, onStatus: statusListener);
// //     setState(() {});
// //   }

// //   /// Each time to start a speech recognition session
// //   Future _startListening() async {
// //     debugPrint("=================================================");
// //     await _stopListening();
// //     await Future.delayed(const Duration(milliseconds: 50));
// //     await _speechToText.listen(
// //       onResult: _onSpeechResult,
// //       localeId: _selectedLocaleId,
// //       listenOptions: SpeechListenOptions(
// //           cancelOnError: false,
// //           partialResults: true,
// //           listenMode: ListenMode.dictation),
// //     );
// //     setState(() {
// //       _speechEnabled = true;
// //     });
// //   }

// //   /// Manually stop the active speech recognition session
// //   /// Note that there are also timeouts that each platform enforces
// //   /// and the SpeechToText plugin supports setting timeouts on the
// //   /// listen method.
// //   Future _stopListening() async {
// //     setState(() {
// //       _speechEnabled = false;
// //     });
// //     await _speechToText.stop();
// //   }

// //   /// This is the callback that the SpeechToText plugin calls when
// //   /// the platform returns recognized words.
// //   void _onSpeechResult(SpeechRecognitionResult result) {
// //     setState(() {
// //       _currentWords = result.recognizedWords;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Speech Demo'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             Container(
// //               padding: const EdgeInsets.all(16),
// //               child: const Text(
// //                 'Recognized words:',
// //                 style: TextStyle(fontSize: 20.0),
// //               ),
// //             ),
// //             Expanded(
// //               child: Container(
// //                 padding: const EdgeInsets.all(16),
// //                 child: TextFormField(
// //                   onSaved: (newValue) {
// //                     widget.control.text =  _lastWords.isNotEmpty
// //                       ? '$_lastWords $_currentWords'
// //                       : _speechAvailable
// //                           ? 'Tap the microphone to start listening...'
// //                           : 'Speech not available';
// //                   },

// //                   controller: widget.control,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed:
// //             _speechToText.isNotListening ? _startListening : _stopListening,
// //         tooltip: 'Listen',
// //         child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_recognition_error.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Flutter Demo',
//       home: MyHomePage1(),
//     );
//   }
// }

// class MyHomePage1 extends StatefulWidget {
//   const MyHomePage1({super.key});

//   @override
//   State<MyHomePage1> createState() => _MyHomePage1State();
// }

// class _MyHomePage1State extends State<MyHomePage1> {
//   TextEditingController name = TextEditingController();
//   TextEditingController phone = TextEditingController();

//   void _updateName(String recognizedWords) {
//     setState(() {
//       name.text = recognizedWords;
//     });
//   }

//   void _updatePassword(String recognizedWords) {
//     setState(() {
//       phone.text = recognizedWords;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Form"),
//       ),
//       body: Form(
//         child: Column(
//           children: [
//             const Text("Name"),
//             TextFormField(
//               controller: name,
//               decoration: InputDecoration(
//                 hintText: "Name",
//                 suffix: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             MyHomePage(onWordsRecognized: _updateName),
//                       ),
//                     );
//                   },
//                   child: const Icon(Icons.mic),
//                 ),
//               ),
//             ),
//             const Text("PHone Number"),
//             TextFormField(
//               controller: phone,
//               decoration: InputDecoration(
//                 hintText: "Phone Number",
//                 suffix: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             MyHomePage(onWordsRecognized: _updatePassword),
//                       ),
//                     );
//                   },
//                   child: const Icon(Icons.mic),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   final Function(String) onWordsRecognized;

//   const MyHomePage({Key? key, required this.onWordsRecognized})
//       : super(key: key);

//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> {
//   final SpeechToText _speechToText = SpeechToText();
//   bool _speechAvailable = false;
//   String _currentWords = '';
//   final String _selectedLocaleId = 'en_US';

//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//   }

//   void errorListener(SpeechRecognitionError error) {
//     debugPrint(error.errorMsg.toString());
//   }

//   void statusListener(String status) {
//     debugPrint("status $status");
//   }

//   void _initSpeech() async {
//     _speechAvailable = await _speechToText.initialize(
//       onError: errorListener,
//       onStatus: statusListener,
//     );
//     setState(() {});
//   }

//   Future _startListening() async {
//     if (!_speechAvailable) return;

//     await _speechToText.listen(
//       onResult: _onSpeechResult,
//       localeId: _selectedLocaleId,
//       listenOptions: SpeechListenOptions(
//         partialResults: true,
//         listenMode: ListenMode.dictation,
//       ),
//     );
//   }

//   void _onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       _currentWords = result.recognizedWords;
//     });
//     widget.onWordsRecognized(_currentWords);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Speech Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: const Text(
//                 'Recognized words:',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 _currentWords.isNotEmpty
//                     ? _currentWords
//                     : _speechAvailable
//                         ? 'Tap the microphone to start listening...'
//                         : 'Speech not available',
//                 style: const TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _startListening,
//         tooltip: 'Listen',
//         child: const Icon(Icons.mic),
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechPage extends StatefulWidget {
  final Function(Map<String, String>) onComplete;
  final List<String> questions;

  const SpeechPage(
      {Key? key, required this.onComplete, required this.questions})
      : super(key: key);

  @override
  SpeechPageState createState() => SpeechPageState();
}

class SpeechPageState extends State<SpeechPage>
    with SingleTickerProviderStateMixin {
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  bool _speechAvailable = false;
  String _currentWords = '';
  final String _selectedLocaleId = 'en_US';
  int _currentQuestionIndex = 0;
  final Map<String, String> _responses = {};
  AnimationController? controller;
  bool iswaving = false;
  Color inital = Colors.yellow;

  @override
  void initState() {
    super.initState();

    _initSpeech();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _speakCurrentQuestion();
    }); // Speak the first question when the screen loads

    inital = Color.fromRGBO(
      Random().nextInt(256), // Red
      Random().nextInt(256), // Green
      Random().nextInt(256), // Blue
      1.0, // Opacity
    );
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _initSpeech() async {
    _speechAvailable = await _speechToText.initialize(
      onError: errorListener,
      onStatus: statusListener,
    );
    setState(() {});
  }

  void errorListener(SpeechRecognitionError error) {
    debugPrint(error.errorMsg.toString());
  }

  void statusListener(String status) {
    debugPrint("status $status");
  }

  Future _startListening() async {
    if (!_speechAvailable) {
      controller!.stop();
      return;
    }

    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: _selectedLocaleId,
      listenFor: const Duration(seconds: 15),
      listenOptions: SpeechListenOptions(
        partialResults: true,
        listenMode: ListenMode.dictation,
      ),
    );
    controller!.repeat(reverse: true);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _currentWords = result.recognizedWords;
    });

    if (result.finalResult) {
      _responses[widget.questions[_currentQuestionIndex]] = _currentWords;
    }
  }

  Future<void> _speakCurrentQuestion() async {
    if (_currentQuestionIndex < widget.questions.length) {
      await _flutterTts.speak(widget.questions[_currentQuestionIndex]);
    }
  }

  void _nextQuestion() {
    setState(() {
      inital = Color.fromRGBO(
        Random().nextInt(256), // Red
        Random().nextInt(256), // Green
        Random().nextInt(256), // Blue
        0.5, // Opacity
      );
      if (_currentQuestionIndex < widget.questions.length - 1) {
        _currentQuestionIndex++;
        _currentWords = '';
        _speakCurrentQuestion(); // Speak the next question when it's shown
      } else {
        widget.onComplete(_responses);
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 300,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: controller!,
                    builder: (context, child) {
                      double waveoffset = 20.0 * controller!.value;
                      return Transform.translate(
                        offset: Offset(0, waveoffset),
                        child: Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                              color: inital,
                              borderRadius: BorderRadius.circular(150.0)),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 35,
                    left: 55,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150.0)),
                      child: Center(
                        child: Text(
                          _currentQuestionIndex < widget.questions.length
                              ? widget.questions[_currentQuestionIndex]
                              : 'Finished',
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              _currentWords.isNotEmpty
                  ? _currentWords
                  : _speechAvailable
                      ? 'Tap the microphone to start listening...'
                      : 'Speech not available',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _currentWords.isNotEmpty ? _nextQuestion : null,
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                    color: _currentWords.isNotEmpty ? Colors.white : inital,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  height: 50,
                  width: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color:
                          _currentWords.isNotEmpty ? Colors.black : Colors.grey,
                    ),
                  )),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startListening,
        tooltip: 'Listen',
        child: const Icon(Icons.mic),
      ),
    );
  }
}
