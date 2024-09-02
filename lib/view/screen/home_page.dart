import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';
import 'package:voiceassistant/view/screen/voice.dart';

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({super.key});

  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  PorcupineManager? _porcupineManager;

  bool married = false;
  bool check = false;

  List<String> l = [
    'What is your name?',
    'What is your mobile number?',
    'What is your address?',
    'Are you married?'
  ];

  @override
  void initState() {
    super.initState();
    initializePorcupine((keywordIndex) {
      if (keywordIndex == 0) {
        log("Detected Wake word");
        _onWakeWordDetected();
      }
    });
  }

  void _onWakeWordDetected() {
    Future.delayed(Duration(seconds: 2), () {
      _porcupineManager?.stop(); // Stop listening after detecting wake word
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SpeechPage(
            onComplete: passingAllController,
            questions: l,
          ),
        ),
      );
    });
  }

  Future<void> initializePorcupine(Function(int) wakeword) async {
    try {
      final ByteData data = await rootBundle.load('assets/gimmy.ppn');
      final Directory tempDir = await getTemporaryDirectory();
      final File tempFile = File('${tempDir.path}/gimmy.ppn');
      await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);

      _porcupineManager = await PorcupineManager.fromKeywordPaths(
        '1pSPSs01odW7pIvWLas3I/hgxbACl24c/oryKT3wI9O9UzFRDbZw6w==',
        [tempFile.path],
        wakeword,
      );
      await _porcupineManager!.start();
    } catch (e) {
      print('Error initializing Porcupine: $e');
    }
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    address.dispose();
    _porcupineManager?.stop();
    super.dispose();
  }

  String convertSequenceToNumber(String sequence) {
    final numbers = sequence.split(' ').map(int.parse).toList();
    return numbers.join('');
  }

  void passingAllController(Map<String, String> responses) {
    setState(() {
      name.text = responses[l[0]] ?? '';
      phone.text = convertSequenceToNumber(responses[l[1]]!);
      address.text = responses[l[2]] ?? '';

      married = responses[l[3]] == 'yes' ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 249, 246, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(250, 249, 246, 1),
        title: const Text("Auto Fill Form"),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 25,
            color: Colors.lightBlue,
            child: const Text(
              "Say 'Hey Gimmy' and see the magic !",
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SpeechPage(
                            onComplete: passingAllController,
                            questions: l,
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.mic),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    cursorWidth: 2.0,
                    controller: name,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    cursorWidth: 2.0,
                    controller: phone,
                    decoration: const InputDecoration(
                      hintText: "Phone Number",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    cursorWidth: 2.0,
                    controller: address,
                    decoration: const InputDecoration(
                      hintText: "Address",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        married = !married;
                      });
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Are You Married: $married",
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
