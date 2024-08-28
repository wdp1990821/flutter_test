import 'package:flutter/material.dart';

class ScrollTestRoute extends StatelessWidget {
  const ScrollTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('滚动组件测试'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('sss'),
          ],
        ),
      ),
    );
  }
}
