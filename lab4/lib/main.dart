import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Lab4()));

// TODO: (in future labs) module based crap
class Lab4Task3Part3 extends StatelessWidget {
  const Lab4Task3Part3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Lab4());
  }
}

class Lab4 extends StatefulWidget {
  const Lab4({super.key});

  @override
  State<StatefulWidget> createState() => _Lab4();
}

class _Lab4 extends State<Lab4> {
  // 3.3
  int? input;
  String output = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Lab 4")),
        body: Center(
            child: TextField(
                decoration: const InputDecoration(hintText: "Input"),
                onChanged: (value) => setState(
                    () => output = (input = int.tryParse(value)) == null
                        ? "Numbers, Please"
                        : input! > 500
                            ? "Exceeded Credit Limit"
                            : "Processing"))),
        bottomSheet: Container(
          alignment: Alignment.center,
          height: 64,
          child: Text("Output: $output"),
        ));
  }

// // 3.1
// bool blue = false;
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//       body: GestureDetector(
//           onTap: () => setState(() => blue = !blue),
//           child: Container(color: blue ? Colors.blue : Colors.red)));
// }

// // 3.2
// var count = 0;
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//       body: Center(
//           child:
//               Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//     TextButton(
//         onPressed: () => setState(() => print(++count)), // add()
//         child: const Text("Click Me!")),
//     Text("You clicked me $count times!")
//   ])));
// }
}

// var text = "My Text";
//
// class Lab4 extends StatelessWidget {
//   const Lab4({super.key});
//
//   // 2.1
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: const Text("Lab 4"),
//           centerTitle: true,
//         ),
//         body: Center(
//             child: Container(
//           color: Colors.green,
//           child: ElevatedButton(
//             onPressed: () => {text = "Mobile Framework"},
//             child: Text(text),
//           ), // 2.2
//         )),
//       );
//
// // Widget build(BuildContext context) {
// //   // 1.3
// //   return Center(
// //       child:
// //       Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
// //         Container(height: 96, width: 96, color: Colors.red),
// //         Container(height: 96, width: 96, color: Colors.green),
// //         Container(height: 96, width: 96, color: Colors.blue),
// //       ]));
// //
// //   // 1.4
// //   return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
// //     GestureDetector(
// //       onTap: () => {print("Information successfully submitted")},
// //       child: Container(
// //         padding: const EdgeInsets.all(32),
// //         color: Colors.green,
// //         child: const Text("Submit", style: TextStyle(fontSize: 32)),
// //       ),
// //     ),
// //     GestureDetector(
// //       onTap: () => {print("Cancel submission")},
// //       child: Container(
// //         padding: const EdgeInsets.all(32),
// //         color: Colors.red,
// //         child: const Text("Cancel", style: TextStyle(fontSize: 32)),
// //       ),
// //     ),
// //   ]);
// // }
// }
