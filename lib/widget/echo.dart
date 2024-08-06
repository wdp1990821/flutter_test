import 'package:flutter/material.dart';

class Echo extends StatelessWidget {
  const Echo({
    super.key,
    required this.text,
    this.bgColor = Colors.grey,
  });

  final String text;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: bgColor,
        child: Text(text),
      ),
    );
  }
}

// class ContextRoute extends StatelessWidget {
//   const ContextRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Context测试"),
//       ),
//       body: Builder(builder: (context) {
//         Scaffold? scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
//         return (scaffold!.appBar as AppBar).title;
//       }),
//     );
//   }
// }


