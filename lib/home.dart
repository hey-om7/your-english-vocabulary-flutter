import 'package:english_vocabulary/wordsGet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class HomePg extends StatelessWidget {
  const HomePg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeStful(),
    );
  }
}

class HomeStful extends StatefulWidget {
  const HomeStful({super.key});

  @override
  State<HomeStful> createState() => _HomeStfulState();
}

class _HomeStfulState extends State<HomeStful> {
  @override
  Widget build(BuildContext context) {
    print(isShuffle);
    return Container(
      child: Column(
        children: [
          // Row(
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.pop(context);
          //         // SystemNavigator.pop();
          //         SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Icon(Icons.arrow_back_ios_new_rounded),
          //       ),
          //     ),
          //   ],
          // ),
          Expanded(
            child: Container(
              // color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "English",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 60,
                          ),
                        ),
                        Text(
                          "Vocabulary",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 55,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              onTap: () {
                // fetchEnglishWords().then((value) => print(value.body));
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => WordsGet()));
              },
              child: startBtn(context),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isShuffle = !isShuffle;
                // print(isShuffle);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 10),
              child: Opacity(
                opacity: isShuffle ? 1 : 0.3,
                child: Image.asset(
                  "assets/shuffle.png",
                  width: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

bool isShuffle = true;

Container startBtn(context) {
  return Container(
    height: 75,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      // color: Colors.amber,
      gradient: LinearGradient(
        colors: [Color(0xff7C6A6A), Color(0xff841212)],
      ),
    ),
    child: Center(
      child: Text(
        "Start",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    ),
  );
}
