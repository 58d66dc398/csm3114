import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(
//       home: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//     Text("Let's start"),
//     Text("Image App", textAlign: TextAlign.center)
//   ])));
// }

// void onPressed() {
//   print('bonk');
// }

// void main() {
//   runApp(MaterialApp(
//       home: Scaffold(
//           backgroundColor: Colors.blueGrey[500],
//           appBar: AppBar(
//               title: const Text("Image App"),
//               centerTitle: true,
//               backgroundColor: Colors.blueGrey[900]),
//           // body: const Column(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     crossAxisAlignment: CrossAxisAlignment.stretch,
//           //     children: [
//           //       TextButton(
//           //           onPressed: onPressed,
//           //           child: Text("Let's start",
//           //               style: TextStyle(color: Colors.white, fontSize: 32))),
//           //       Text("Flutter Development Course",
//           //           textAlign: TextAlign.center,
//           //           style: TextStyle(color: Colors.white, fontSize: 24)),
//           //     ]))));
//           body: const Center(
//               child: Image(image: AssetImage('images/heh.jpeg'))))));
// }

void main() {
  runApp(ImageApp());
}

class ImageApp extends StatefulWidget {
  const ImageApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return ImageAppState();
  }
}

class ImageAppState extends State<ImageApp> {
  var lazy = 0;

  void wakuwaku() {
    setState(() {
      lazy = 0;
    });
  }

  void pikapika() {
    setState(() {
      lazy = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.blueGrey[500],
            appBar: AppBar(
                title: const Text("Image App"),
                centerTitle: true,
                backgroundColor: Colors.blueGrey[900]),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                      child: Image(
                          image: AssetImage((lazy > 0
                              ? 'images/wut.jpeg'
                              : 'images/heh.jpeg')))),
                  TextButton(
                      onPressed: wakuwaku,
                      child: const Text("Heh",
                          style: TextStyle(color: Colors.white, fontSize: 32))),
                  TextButton(
                      onPressed: pikapika,
                      child: const Text("Wut",
                          style: TextStyle(color: Colors.white, fontSize: 32))),
                ])));
  }
}
