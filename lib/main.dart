import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test0715/widget/animation.dart';
import 'package:flutter_application_test0715/widget/customwidget.dart';
import 'package:flutter_application_test0715/widget/functionview.dart';
import 'package:flutter_application_test0715/widget/network.dart';
import 'package:flutter_application_test0715/widget/widgets.dart';

import 'widget/scroll.dart';

void main() {
  // debugPaintSizeEnabled = true;
  var onError = FlutterError.onError; // 先将onerror保存起来
  FlutterError.onError = (FlutterErrorDetails details) {
    onError?.call(details); // 调用默认的onError
    reportErrorAndLog(details); // 上报
  };
  runZoned(
    () => runApp(const MyApp()),
    zoneSpecification: ZoneSpecification(
      // 拦截print
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLog(line);
        parent.print(zone, 'Interceptor: $line');
      },
      // 拦截未处理的异步错误
      handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
          Object error, StackTrace stackTrace) {
        //  reportErrorAndLog(makeDetails(error, stackTrace));
        parent.print(zone, '${error.toString()} $stackTrace');
      },
    ),
  );
}

void collectLog(String line) {
  // 收集日志方法
}

void reportErrorAndLog(FlutterErrorDetails details) {
  // 上报错误和日志逻辑
}

// FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
// 构建错误信息
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot·
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // 名为'/'的路由作为应用的首页
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        'new_page': (context) => const NewRoute(),
        'tip_page': (context) {
          return TipRoute(
              text: ModalRoute.of(context)!.settings.arguments.toString());
        },
        'route_page': (context) => const RouterTestRoute(),
        'image_icon_page': (context) => const ImageIconRoute(),
        'switch_checkbox_page': (context) => SwitchAndCheckBoxTestRoute(),
        'progress_route': (context) => const ProgressRoute(),
        'focus_test_route': (context) => const FocusTestRoute(),
        'form_test_route': (context) => const FormTestRoute(),
        'layout_builder_route': (context) => const LayoutBuilderRoute(),
        'clip_test_route': (context) => const ClipTestRoute(),
        'scaffold_test_route': (context) => const ScaffoldRoute(),
        'singlechildscrollview_test_route': (context) =>
            const SingleChildScrollViewTestRoute(),
        'infinite_listview_route': (context) => const InfiniteListView(),
        'scroll_controller_route': (context) =>
            const ScrollControllerTestRoute(),
        'scroll_notification_route': (context) =>
            const ScrollNotificationRoute(),
        'animated_list_route': (context) => const AnimatedListRoute(),
        'infinite_gridview_route': (context) => const InfiniteGridView(),
        'page_view_route': (context) => const PageViewRoute(),
        'keep_alive_test_route': (context) => const KeepAliveTestRoute(),
        'tab_view_route1': (context) => const TabViewRoute1(),
        'tab_view_route2': (context) => const TabViewRoute2(),
        'custom_scroll_view_route': (context) => const CustomScrollViewRoute(),
        'persistend_header_route': (context) => const PersistentHeaderRoute(),
        'snap_app_bar_route': (context) => const SnapAppBar(),
        'nested_tab_bar_view_route': (context) => const NestedTabBarView(),
        'function_view_route': (context) => const FunctionviewRoute(),
        'will_pop_scope_route': (context) => const WillPopScopeRoute(),
        'inherited_widget_test_route': (context) =>
            const InheritedWidgetTestRoute(),
        'provider_route': (context) => const ProviderRoute(),
        'theme_test_route': (context) => const ThemeTestRoute(),
        'value_listenable_route': (context) => const ValueListenableRoute(),
        'future_builder_route': (context) => const FutureBuilderRoute(),
        'stream_builder_route': (context) => const StreamBuilderRoute(),
        'dialog_route': (context) => const DialogTestRoute(),
        'pointer_move_route': (context) => const PointerMoveIndicatorRoute(),
        'gesture_route': (context) => const GestureTestRoute(),
        'drag_route': (context) => const DragTestRoute(),
        'gesture_recognizer_route': (context) => const GestureRecognizerRoute(),
        'notification_route': (context) => const NotificationRoute(),
        'animation_route': (context) => const AnimationRoute(),
        'scale_animation_route': (context) => const ScaleAnimationRoute(),
        'hero_animation_route_a': (context) => const HeroAnimationRouteA(),
        'stagger_route': (context) => const StaggerRoute(),
        'animated_switcher_counter_route': (context) =>
            const AnimatedSwitcherCounterRoute(),
        'animated_widget_route': (context) => const AnimatedWidgetTest(),
        'custom_widget_route': (context) => const CustomWidgetRoute(),
        'gradient_button_route': (context) => const GradientButtonRoute(),
        'turn_box_route': (context) => const TurnBoxRoute(),
        'custom_paint_route': (context) => const CustomPaintRoute(),
        'circular_progress_route': (context) =>
            const GradientCircularProgressRoute(),
        'net_work_route': (context) => const NetworkRoute(),
        'file_operation_route': (context) => const FileOperationRoute(),
        'shared_preferences_route': (context) => const SharedPreferencesDemo(),
        'http_test_route': (context) => const HttpTestRoute(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DefaultTextStyle(
                style: const TextStyle(color: Colors.cyan, fontSize: 20),
                textAlign: TextAlign.start,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Hello $_counter'),
                    const Text('I am Jack'),
                    const Text(
                      "I am Jack",
                      style: TextStyle(
                        inherit: false, // 不继承默认样式
                        color: Colors.grey,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: const Text('Submit'),
                      icon: const Icon(Icons.send),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      label: const Text("add"),
                      icon: const Icon(Icons.add),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      label: const Text('info'),
                      icon: const Icon(Icons.info),
                    ),
                  ],
                )),
            const Text(
              'You have clicked the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'new_page');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) {
                //     return const NewRoute();
                //   }),
                // );
              },
              child: const Text('open new route'),
            ),
            const Image(
              image: AssetImage('assets/images/fuyou.png'),
              width: 100,
              height: 100,
            ),
            // Image.network(
            //   'https://avatars2.githubusercontent.com/u/20411648?s=460&v=4',
            //   width: 50,
            // ),
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, 'scaffold_test_route'),
                child: const Text('Scroll Route')),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, 'function_view_route'),
              child: const Text('Function Route'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, 'animation_route'),
              child: const Text('Animation Route'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, 'custom_widget_route'),
              child: const Text('Custom Widget Route'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, 'net_work_route'),
              child: const Text('Net Work Route'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NewRoute extends StatelessWidget {
  const NewRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New route'),
      ),
      body: Column(
        children: <Widget>[
          const Text('This is new route'),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const RouterTestRoute();
                  }),
                );
              },
              child: const Text('Open New Page')),
        ],
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  const TipRoute({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    // debugger(when: text.isEmpty);
    // print("ssss");
    // debugPrint('1000');

    return Scaffold(
      appBar: AppBar(
        title: const Text('提示'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              const Text(
                'Hello world',
                textAlign: TextAlign.left,
              ),
              Text(
                'Hello world! Im Jack.' * 4,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text("Hello world",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      height: 1.2,
                      fontFamily: 'Courier',
                      background: Paint()..color = Colors.yellow,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed)),
              const Text.rich(TextSpan(children: [
                TextSpan(text: "Home:"),
                TextSpan(
                  text: "https://flutterchina.club",
                  style: TextStyle(
                    color: Colors.pink,
                  ),
                )
              ])),
              Text(text),
              ElevatedButton(
                onPressed: () {
                  // 树状态打印
                  // debugDumpApp();
                  // 渲染树，布局调试
                  // debugDumpRenderTree();
                  Navigator.pop(context, '我是返回值');
                },
                child: const Text('返回'),
              ),
              const RandomWordsWidget(),
              Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover,
                width: 200,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  const RouterTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          var result = await Navigator.push(context, MaterialPageRoute(
            builder: (builder) {
              return const TipRoute(text: '我是提示XXX');
            },
          ));
          print('路由返回值： $result');
        },
        child: const Text('打开提示页'),
      ),
    );
  }
}

class RandomWordsWidget extends StatelessWidget {
  const RandomWordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String icons = '';
    icons += "\uE03e";
    icons += '\uE237';
    icons += '\uE287';

    final wordPair = WordPair.random();

    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              wordPair.toString(),
              selectionColor: Colors.yellow,
              style: const TextStyle(color: Colors.blueGrey),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, 'image_icon_page'),
              child: const Text('ImageAndIconRoute'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'switch_checkbox_page');
              },
              child: const Text("Switch And CheckBox route"),
            ),
            Text(
              icons,
              style: const TextStyle(
                  fontFamily: "MaterialIcons",
                  fontSize: 24.0,
                  color: Colors.blue),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_alarm,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.error,
                  color: Colors.green,
                ),
                Icon(
                  Icons.add_alert_rounded,
                  color: Colors.deepPurple,
                ),
              ],
            ),
          ],
        ));
  }
}

class ImageIconRoute extends StatelessWidget {
  const ImageIconRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var img = const AssetImage('assets/images/background.jpg');
    return SingleChildScrollView(
      child: Column(
        children: [
          Image(
            image: img,
            height: 50,
            width: 100,
            fit: BoxFit.fill,
          ),
          Image(
            image: img,
            height: 50,
            width: 50,
            fit: BoxFit.contain,
          ),
          Image(
            image: img,
            width: 100,
            height: 50,
            fit: BoxFit.cover,
          ),
          Image(
            image: img,
            width: 100.0,
            height: 50.0,
            fit: BoxFit.fitWidth,
          ),
          Image(
            image: img,
            width: 100.0,
            height: 50.0,
            fit: BoxFit.fitHeight,
          ),
          Image(
            image: img,
            width: 100.0,
            height: 50.0,
            fit: BoxFit.scaleDown,
          ),
          Image(
            image: img,
            height: 50.0,
            width: 100.0,
            fit: BoxFit.none,
          ),
          Image(
            image: img,
            width: 100.0,
            color: Colors.blue,
            colorBlendMode: BlendMode.difference,
            fit: BoxFit.fill,
          ),
          Image(
            image: img,
            width: 100.0,
            height: 200.0,
            repeat: ImageRepeat.repeatY,
          ),
        ].map((e) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 100,
                  child: e,
                ),
              ),
              Text("${e.fit}  ${e.repeat}")
            ],
          );
        }).toList(),
      ),
    );
  }
}
