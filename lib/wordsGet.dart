import 'package:english_vocabulary/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import "home.dart" as homedart;

class WordsGet extends StatelessWidget {
  const WordsGet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: WordsGetStful(),
      ),
    );
  }
}

class WordsGetStful extends StatefulWidget {
  const WordsGetStful({super.key});

  @override
  State<WordsGetStful> createState() => _WordsGetStfulState();
}

class _WordsGetStfulState extends State<WordsGetStful> {
  double _leftVal = 0;
  double _topVal = 0;
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
            future: fetchEnglishWords(),
            builder: ((context, AsyncSnapshot<List<List<String>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return PageView(
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                  children: [
                    ...List.generate(snapshot.data!.length, (index) {
                      return Post(
                        meaningHead: snapshot.data![index][0],
                        meaningTail: snapshot.data![index][1],
                        color: Colors.white,
                      );
                    }),
                  ],
                );
              } else {
                return Container();
              }
            })),
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              // Navigator.pushReplacement(context,
              //     new MaterialPageRoute(builder: (context) => HomePg()));
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
        ),
      ],
    );
  }
}

class Post extends StatelessWidget {
  // const Post({super.key});
  Post(
      {required this.color,
      required this.meaningHead,
      required this.meaningTail});
  final Color color;
  final String meaningHead;
  final String meaningTail;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: BehindMotion(), children: [
        Expanded(
          child: Container(
            // height: double.infinity,
            // width: double.infinity,
            // color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                meaningTail,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        Container(
          color: Colors.red,
        ),
      ]),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: color,
        child: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff7C6A6A),
                  Color(0xff841212),
                ],
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    meaningHead,
                    style: TextStyle(
                      fontSize: meaningHead.length > 7 ? 40 : 60,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Future _speak() async {
                        FlutterTts flutterTts = FlutterTts();

                        List<dynamic> languages = await flutterTts.getLanguages;
                        var result = await flutterTts.speak(meaningHead);

                        // if (result == 1)
                        //   setState(() => ttsState = TtsState.playing);
                      }

                      _speak();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Image.asset(
                        "assets/sound.png",
                        width: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<List<List<String>>> fetchEnglishWords() async {
  var resp = await http.get(Uri.parse(
      'https://raw.githubusercontent.com/hey-om7/english-vocabulary/main/Printable/PrintReadyFile.txt'));
  ;
  List allWords = resp.body.toString().split("--------------------");
  List<List<String>> sep = [];
  for (int i = 0; i < allWords.length - 1; i++) {
    String element = allWords[i];
    List a1 = element.toString().split(":");
    String meaningHead = a1[0].toString().split(".)")[1].trim();
    meaningHead = meaningHead.substring(0, 1).toUpperCase() +
        meaningHead.substring(
          1,
        );
    String meaningTail = a1[1].toString().trim();
    meaningTail = meaningTail.substring(0, 1).toUpperCase() +
        meaningTail.substring(1, meaningTail.length - 3);
    sep.add([meaningHead, meaningTail]);
  }
  if (homedart.isShuffle) {
    sep.shuffle();
  }
  return sep;
}


// Column(
//       children: [
//         Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Icon(Icons.arrow_back_ios_new_rounded),
//             ),
//           ],
//         ),
//         Expanded(
//           child: Stack(
//             children: [
//               Positioned(
//                   left: _leftVal,
//                   top: _topVal,
//                   child: GestureDetector(
//                     onPanUpdate: (details) {
//                       setState(() {
//                         _leftVal = details.delta.dx;
//                         _topVal = details.delta.dy;
//                       });
//                       print("$_leftVal:$_topVal");
//                     },
//                     child: Container(
//                       height: 200,
//                       width: 200,
//                       color: Colors.red,
//                     ),
//                   ))
//             ],
//           ),
//         ),
//       ],
//     );