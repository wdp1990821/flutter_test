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
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, 'focus_test_route'),
                child: const Text('Focus Route'),
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, 'form_test_route'),
                child: const Text('Form Route'),
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

class FocusTestRoute extends StatefulWidget {
  const FocusTestRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FocusTestRouteState();
  }
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode? focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextField'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              focusNode: focusNode1,
              decoration: const InputDecoration(
                hintText: '请输入用户名',
                labelText: '用户名',
                prefixIcon: Icon(Icons.person),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            TextField(
              focusNode: focusNode2,
              decoration: const InputDecoration(
                labelText: '密码',
                hintText: "您的登录密码",
                prefixIcon: Icon(Icons.lock),
                hintStyle: TextStyle(color: Colors.yellow, fontSize: 20),
              ),
              obscureText: true,
            ),
            Builder(builder: (ctx) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // 将焦点从第一个TextField移到第二个TextField
                      // 这是第一种写法
                      // FocusScope.of(context).requestFocus(focusNode2);
                      // 这是第二种写法
                      focusScopeNode ??= FocusScope.of(context);
                      focusScopeNode?.requestFocus(focusNode2);
                    },
                    child: const Text('移动焦点'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                    },
                    child: const Text('隐藏键盘'),
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}

class FormTestRoute extends StatefulWidget {
  const FormTestRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FormTestRouteState();
  }
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey, //设置globalkey，用于后面获取FormState
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              controller: _unameController,
              decoration: const InputDecoration(
                labelText: '用户名',
                hintText: '用户名或邮箱',
                icon: Icon(Icons.person),
              ),
              validator: (v) {
                return v!.trim().isNotEmpty ? null : '用户名不能为空';
              },
            ),
            TextFormField(
              controller: _pwdController,
              decoration: const InputDecoration(
                labelText: '密码',
                hintText: '您的登录密码',
                icon: Icon(Icons.lock),
              ),
              validator: (v) {
                return v!.trim().length > 5 ? null : "密码不能少于6位";
              },
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // 通过_formKey.currentState 获取FormState后调用validate()方法校验用户名密码是否合法
                        // ignore: unrelated_type_equality_checks
                        if ((_formKey.currentState as FormState).validate()) {
                          // 验证通过提交数据
                          debugPrint("验证通过！！！");
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('登录'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
