import 'dart:math';

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
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, 'layout_builder_route'),
                child: const Text('Layout Builder Route'),
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, 'clip_test_route'),
                child: const Text('Clip Route'),
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
      appBar: AppBar(
        title: const Text("sss"),
      ),
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
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: 100,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 30,
                        color: Colors.red,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 30,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Wrap(
              spacing: 8,
              runSpacing: 4,
              alignment: WrapAlignment.center,
              children: [
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('A')),
                  label: Text('Hamilton'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('M')),
                  label: Text('Lafayatte'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('H')),
                  label: Text('Mulligan'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('J')),
                  label: Text('Laurens'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('A')),
                  label: Text('Hamilton'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('M')),
                  label: Text('Lafayatte'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('H')),
                  label: Text('Mulligan'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('J')),
                  label: Text('Laurens'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('A')),
                  label: Text('Hamilton'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('M')),
                  label: Text('Lafayatte'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('H')),
                  label: Text('Mulligan'),
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('J')),
                  label: Text('Laurens'),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  child: const Text('Hello world',
                      style: TextStyle(color: Colors.white)),
                ),
                const Positioned(
                  left: 18,
                  child: Text('I am Jack'),
                ),
                const Positioned(
                  top: 18,
                  child: Text('Your friend'),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 100),
              constraints: const BoxConstraints.tightFor(width: 50, height: 25),
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.red, Colors.orange],
                  center: Alignment.topLeft,
                  radius: .98,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              transform: Matrix4.rotationZ(.2),
              alignment: Alignment.center,
              child: const Text(
                '5.20',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint({super.key, this.tag, required this.child});

  final Widget child;
  final T? tag;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // assert在编译release版本时会被去除
      assert(() {
        print('${tag ?? key ?? child} : $constraints');
        return true;
      }());
      return child;
    });
  }
}

class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    // 通过LayoutBuilder拿到父组件传递的约束，然后判断maxWidth是否小于200
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 200) {
        return Column(mainAxisSize: MainAxisSize.min, children: children);
      } else {
        // 大于200显示双列
        var childrens = <Widget>[];
        for (var i = 0; i < children.length; i += 2) {
          if (i + 1 < children.length) {
            childrens.add(Row(
              mainAxisSize: MainAxisSize.min,
              children: [children[i], children[i + 1]],
            ));
          } else {
            childrens.add(children[i]);
          }
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: childrens,
        );
      }
    });
  }
}

class LayoutBuilderRoute extends StatelessWidget {
  const LayoutBuilderRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var children = List.filled(1, const Text('A'));
    return Column(
      children: [
        SizedBox(width: 20, child: ResponsiveColumn(children: children)),
        const Padding(
          padding: EdgeInsets.all(3),
          child: Text('AAAAA'),
        ),
        ResponsiveColumn(children: children),
        const LayoutLogPrint(child: Text('xx')),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Colors.red, Color.fromARGB(255, 235, 146, 12)]),
            borderRadius: BorderRadius.circular(3.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(2, 2),
                blurRadius: 4,
              )
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          color: Colors.black,
          child: Transform(
            transform: Matrix4.skewY(0.3),
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.deepOrange,
              child: const Text('Apartment for rent!'),
            ),
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: Transform.translate(
            offset: const Offset(-20, -5),
            child: const Text('Hello world!'),
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: Transform.rotate(
            angle: pi / 2,
            child: const Text('Hello world!'),
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: Transform.scale(
            scale: 1.5,
            child: const Text('Hello world!'),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: RotatedBox(
                quarterTurns: 1,
                child: Text('Hello world!'),
              ),
            ),
            Text(
              '你好',
              style: TextStyle(color: Colors.greenAccent, fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}

class ClipTestRoute extends StatelessWidget {
  const ClipTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset('images/background.jpg', width: 50, height: 50);
    return Center(
      child: Column(
        children: [
          avatar, // 不裁剪
          ClipOval(child: avatar), // 裁剪为圆形
          ClipRRect(
            // 裁剪为圆角矩形
            borderRadius: BorderRadius.circular(5),
            child: avatar,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .5, // 宽度为原来宽度的一半，另一半会溢出
                child: avatar,
              ),
              const Text('你好世界！', style: TextStyle(color: Colors.green)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRect(
                // 将溢出部分裁剪
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,
                  child: avatar,
                ),
              ),
              const Text('你好世界！', style: TextStyle(color: Colors.green)),
            ],
          ),
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.red),
            child: ClipRect(
              clipper: MyClipper(),
              child: avatar,
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return const Rect.fromLTWH(5, 10, 20, 20);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

