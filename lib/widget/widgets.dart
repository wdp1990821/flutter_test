import 'package:flutter/material.dart';

class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  SwitchAndCheckBoxTestRoute({super.key});

  @override
  _SwitchAndCheckBoxTestRouteState createState() =>
      _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState
    extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = true;
  bool _checkboxSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Switch(
                value: _switchSelected,
                onChanged: (value) {
                  setState(() {
                    debugPrint('Switch ${value.toString()}');
                    _switchSelected = value;
                  });
                },
              ),
              Checkbox(
                value: _checkboxSelected,
                activeColor: Colors.red,
                onChanged: (value) {
                  setState(() {
                    debugPrint('CheckBox ${value.toString()}');
                    _checkboxSelected = value!;
                  });
                },
              ),
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ),
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                value: .5,
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                value: .3,
                valueColor: const AlwaysStoppedAnimation(Colors.black12),
                strokeWidth: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'progress_route');
                },
                child: const Text('Progress Route'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressRoute extends StatefulWidget {
  const ProgressRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProgressRouteState();
  }
}

class _ProgressRouteState extends State<ProgressRoute>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, // 注意State类需要混入SingleTickerProviderStateMixin(提供动画帧计时/触发器)
      duration: const Duration(seconds: 3),
    );
    _animationController.forward();
    _animationController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                  .animate(_animationController),
              value: _animationController.value,
            ),
          ),
          
        ],
      ),
    );
  }
}


