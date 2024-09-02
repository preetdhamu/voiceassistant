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
//   TextEditingController address = TextEditingController();
//   bool married = false;

//   List<String> l = [
//     'What is your name ? ',
//     'What is your mobile number? ',
//     'what is your address ?',
//     'Do you married ?'
//   ];

//   void passingAllController(Map<String, String> responses) {
//     setState(() {
//       name.text = responses[l[0]] ?? '';
//       phone.text = responses[l[1]] ?? '';
//       address.text = responses[l[2]] ?? '';

//       married = responses[l[3]] == 'yes' ? true : false;
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
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SpeechPage(
//                       onComplete: passingAllController,
//                       questions: l,
//                     ),
//                   ),
//                 );
//               },
//               child: const Icon(Icons.mic),
//             ),
//             const Text("Name"),
//             TextFormField(
//               controller: name,
//               decoration: const InputDecoration(
//                 hintText: "Name",
//               ),
//             ),
//             const Text("Phone Number"),
//             TextFormField(
//               controller: phone,
//               decoration: const InputDecoration(
//                 hintText: "Phone Number",
//               ),
//             ),
//             const Text("Address"),
//             TextFormField(
//               controller: address,
//               decoration: const InputDecoration(
//                 hintText: "Address",
//               ),
//             ),
//             GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     married = !married;
//                   });
//                 },
//                 child: Text("Are You Married : ${married}")),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SpeechPage extends StatefulWidget {
//   final Function(Map<String, String>) onComplete;
//   final List<String> questions;

//   const SpeechPage(
//       {Key? key, required this.onComplete, required this.questions})
//       : super(key: key);

//   @override
//   SpeechPageState createState() => SpeechPageState();
// }

// class SpeechPageState extends State<SpeechPage> {
//   final SpeechToText _speechToText = SpeechToText();
//   bool _speechAvailable = false;
//   String _currentWords = '';
//   final String _selectedLocaleId = 'en_US';

//   int _currentQuestionIndex = 0;
//   final Map<String, String> _responses = {};

//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//   }

//   void _initSpeech() async {
//     _speechAvailable = await _speechToText.initialize(
//       onError: errorListener,
//       onStatus: statusListener,
//     );
//     setState(() {});
//   }

//   void errorListener(SpeechRecognitionError error) {
//     debugPrint(error.errorMsg.toString());
//   }

//   void statusListener(String status) {
//     debugPrint("status $status");
//   }

//   Future _startListening() async {
//     if (!_speechAvailable) return;

//     await _speechToText.listen(
//       onResult: _onSpeechResult,
//       localeId: _selectedLocaleId,
//       listenFor: const Duration(seconds: 15),
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

//     if (result.finalResult) {
//       _responses[widget.questions[_currentQuestionIndex]] = _currentWords;
//     }
//   }

//   void _nextQuestion() {
//     setState(() {
//       if (_currentQuestionIndex < widget.questions.length - 1) {
//         _currentQuestionIndex++;
//         _currentWords = '';
//       } else {
//         widget.onComplete(_responses);
//         Navigator.pop(context);
//       }
//     });
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
//               child: Text(
//                 _currentQuestionIndex < widget.questions.length
//                     ? widget.questions[_currentQuestionIndex]
//                     : 'Finished',
//                 style: const TextStyle(fontSize: 20.0),
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
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _currentWords.isNotEmpty ? _nextQuestion : null,
//               child: const Text('Next'),
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
//   TextEditingController address = TextEditingController();
//   bool married = false;

//   List<String> l = [
//     'What is your name ? ',
//     'What is your mobile number? ',
//     'what is your address ?',
//     'Do you married ?'
//   ];

//   void passingAllController(Map<String, String> responses) {
//     setState(() {
//       name.text = responses[l[0]] ?? '';
//       phone.text = responses[l[1]] ?? '';
//       address.text = responses[l[2]] ?? '';

//       married = responses[l[3]] == 'yes' ? true : false;
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
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SpeechPage(
//                       onComplete: passingAllController,
//                       questions: l,
//                     ),
//                   ),
//                 );
//               },
//               child: const Icon(Icons.mic),
//             ),
//             const Text("Name"),
//             TextFormField(
//               controller: name,
//               decoration: const InputDecoration(
//                 hintText: "Name",
//               ),
//             ),
//             const Text("Phone Number"),
//             TextFormField(
//               controller: phone,
//               decoration: const InputDecoration(
//                 hintText: "Phone Number",
//               ),
//             ),
//             const Text("Address"),
//             TextFormField(
//               controller: address,
//               decoration: const InputDecoration(
//                 hintText: "Address",
//               ),
//             ),
//             GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     married = !married;
//                   });
//                 },
//                 child: Text("Are You Married : ${married}")),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SpeechPage extends StatefulWidget {
//   final Function(Map<String, Strin[g>) onComplete;
//   final List<String> questions;

//   const SpeechPage(
//       {Key? key, required this.onComplete, required this.questions})
//       : super(key: key);

//   @override
//   SpeechPageState createState() => SpeechPageState();
// }

// class SpeechPageState extends State<SpeechPage> {
//   final SpeechToText _speechToText = SpeechToText();
//   bool _speechAvailable = false;
//   String _currentWords = '';
//   final String _selectedLocaleId = 'en_US';

//   int _currentQuestionIndex = 0;
//   final Map<String, String> _responses = {};

//   @override
//   void initState() {
//     super.initState();

//     _initSpeech();
//   }

//   void _initSpeech() async {

//     _speechAvailable = await _speechToText.initialize(
//       onError: errorListener,
//       onStatus: statusListener,
//     );
//     setState(() {});
//   }

//   void errorListener(SpeechRecognitionError error) {
//     debugPrint(error.errorMsg.toString());
//   }

//   void statusListener(String status) {
//     debugPrint("status $status");
//   }

//   Future _startListening() async {
//     if (!_speechAvailable) return;

//     await _speechToText.listen(
//       onResult: _onSpeechResult,
//       localeId: _selectedLocaleId,
//       listenFor: const Duration(seconds: 15),
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

//     if (result.finalResult) {
//       _responses[widget.questions[_currentQuestionIndex]] = _currentWords;
//     }
//   }

//   void _nextQuestion() {
//     setState(() {
//       if (_currentQuestionIndex < widget.questions.length - 1) {
//         _currentQuestionIndex++;
//         _currentWords = '';
//       } else {
//         widget.onComplete(_responses);
//         Navigator.pop(context);
//       }
//     });
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
//               child: Text(
//                 _currentQuestionIndex < widget.questions.length
//                     ? widget.questions[_currentQuestionIndex]
//                     : 'Finished',
//                 style: const TextStyle(fontSize: 20.0),
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
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _currentWords.isNotEmpty ? _nextQuestion : null,
//               child: const Text('Next'),
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

// .............

import 'package:flutter/material.dart';
import 'package:voiceassistant/view/screen/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage1(),
    );
  }
}
