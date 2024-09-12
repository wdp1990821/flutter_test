import 'dart:collection';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FunctionviewRoute extends StatefulWidget {
  const FunctionviewRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FunctionviewRouteState();
  }
}

class _FunctionviewRouteState extends State<FunctionviewRoute> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('功能型组件'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), label: 'Business'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAdd,
        child: const Icon(Icons.add),
      ),
      body: Scrollbar(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'will_pop_scope_route');
                },
                child: const Text('WillPopScope Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'inherited_widget_test_route');
                },
                child: const Text('InheritedWidget Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'provider_route');
                },
                child: const Text('Provider Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'theme_test_route');
                },
                child: const Text('Theme Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'value_listenable_route');
                },
                child: const Text('Value Listenable Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'future_builder_route');
                },
                child: const Text('Future Builder Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'stream_builder_route');
                },
                child: const Text('Stream Builder Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'dialog_route');
                },
                child: const Text('Dialog Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'pointer_move_route');
                },
                child: const Text('Pointer Move Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'gesture_route');
                },
                child: const Text('Gesture Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  bus.emit('login', 'aaa');
                  Navigator.pushNamed(context, 'drag_route');
                },
                child: const Text('Drag Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  bus.on('gesture', (arg) {
                    print(arg);
                  });
                  Navigator.pushNamed(context, 'gesture_recognizer_route');
                },
                child: const Text('Gesture Recognizer Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'notification_route');
                },
                child: const Text('Notification Route'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}
}

class WillPopScopeRoute extends StatefulWidget {
  const WillPopScopeRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return WillPopScopeRouteState();
  }
}

class WillPopScopeRouteState extends State<WillPopScopeRoute> {
  // DateTime? _lastPressedAt; //上次点击时间
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Container(
        alignment: Alignment.center,
        child: const Text('1秒内连续按两次返回键退出'),
      ),
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({super.key, required super.child, required this.data});

  final int data; // 需要在子树中共享的数据，保存点击次数

  // 定义一个便捷方法，方便子树中的Widget获取共享数据
  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestWidgetState();
  }
}

class _TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    // 使用InheritedWidget中的共享数据
    return Text(ShareDataWidget.of(context)!.data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 父或祖widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    // 如果build中没有依赖InheritedWidget，则此回调不会被调用
    print('Dependencies change');
  }
}

class InheritedWidgetTestRoute extends StatefulWidget {
  const InheritedWidgetTestRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InheritedWidgetTestRouteState();
  }
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _TestWidget(),
            ),
            ElevatedButton(
              onPressed: () => setState(() {
                () => ++count;
              }),
              child: const Text('Increment'),
            ),
            const NavBar(title: '标题', color: Colors.blue),
            const NavBar(title: '标题', color: Colors.white),
          ],
        ),
      ),
    );
  }
}

// 一个通用的InheritedWidget，保存需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  const InheritedProvider(
      {super.key, required this.data, required super.child});

  final T data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // 在此简单返回true，则每次更新都会调用依赖其的子孙节点的‘didChangeDependencies’
    return true;
  }
}

class ChangeNotifier implements Listenable {
  List listeners = [];

  @override
  void addListener(VoidCallback listener) {
    listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    listeners.remove(listener);
  }

  void notifyListeners() {
    // 通知所有监听器，触发监听器回调
    for (var item in listeners) {
      item();
    }
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T data;

  const ChangeNotifierProvider(
      {super.key, required this.child, required this.data});

  static T of<T>(BuildContext context) {
    // final type = _typeOf<InheritedProvider<T>>();
    final provider =
        context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();

    return provider!.data;
  }

  @override
  State<StatefulWidget> createState() {
    return _ChangeNotifierProviderState();
  }
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    // 如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    // 当Provider更新时，如果新旧数据不 "=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(data: widget.data, child: widget.child);
  }
}

// 定义一个Item类，用于表示商品信息
class Item {
  Item(this.price, this.count);

  double price; //商品单价
  int count; // 商品份数
}

// 定义一个保存购物车内商品数据的类
class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<Item> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 将[item]添加到购物车，这是唯一一种能从外部改变购物车的方法
  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider更新状态
    notifyListeners();
  }
}

class ProviderRoute extends StatefulWidget {
  const ProviderRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProviderRouteState();
  }
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(builder: (context) {
          return Column(
            children: [
              Builder(builder: (context) {
                var cart = ChangeNotifierProvider.of<CartModel>(context);
                return Text('总价：${cart.totalPrice}');
              }),
              Builder(builder: (context) {
                print('ElevatedButton build');
                return ElevatedButton(
                    onPressed: () {
                      // 给购物车中添加商品，添加后总价会更新
                      ChangeNotifierProvider.of<CartModel>(context)
                          .add(Item(20, 1));
                    },
                    child: const Text('添加商品'));
              }),
              const NavBar(title: '标题', color: Colors.blue),
              const NavBar(title: '标题', color: Colors.white),
            ],
          );
        }),
      )),
    );
  }
}

// 颜色和主题
class NavBar extends StatelessWidget {
  final String title;
  final Color color; // 背景色

  const NavBar({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(minHeight: 52, minWidth: double.infinity),
      decoration: BoxDecoration(
        color: color,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          // computeLuminance()返回一个[0-1]值，数字越大颜色越浅
          color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class ThemeTestRoute extends StatefulWidget {
  const ThemeTestRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ThemeTestRouteState();
  }
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {
  var _themeColor = Colors.teal; // 当前路由主题色

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Theme(
      data: ThemeData(
        primarySwatch: _themeColor, // 用于导航栏、FloatingActionButton的背景色等
        iconTheme: IconThemeData(color: _themeColor), // 用于Icon颜色
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('主题测试')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 第一行Icon使用主题中的iconTheme
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                Text('  颜色跟随主题'),
              ],
            ),
            // 第二行Icon自定义颜色（固定为黑色）
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(color: Colors.black),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text('  颜色固定黑色'),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(
            () => _themeColor =
                _themeColor == Colors.teal ? Colors.blue : Colors.teal,
          ),
          child: const Icon(Icons.palette),
        ),
      ),
    );
  }
}

// 按需rebuild（ValueListenableBuilder）
class ValueListenableRoute extends StatefulWidget {
  const ValueListenableRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ValueListenableState();
  }
}

class _ValueListenableState extends State<ValueListenableRoute> {
  // 定义一个ValueNotifier，当数字变化时会通知ValueListenableBuilder
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  static const double textScaleFactor = 1.5;

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(title: const Text('ValueListenableBuilder 测试')),
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: _counter,
            builder: (BuildContext context, int value, Widget? child) {
              // build 方法只会在_counter变化时被调用
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  child!,
                  // ignore: deprecated_member_use
                  Text('$value 次', textScaleFactor: textScaleFactor),
                ],
              );
            },
            child: const Text(
              '点击了 ',
              // ignore: deprecated_member_use
              textScaleFactor: textScaleFactor,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _counter.value += 1,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// 异步UI更新（FutureBuilder、StreamBuilder）
class FutureBuilderRoute extends StatelessWidget {
  const FutureBuilderRoute({super.key});

  Future<String> mockNetworkData() async {
    // Future.delayed(Duration(seconds: 2), () {
    //   return 'hi';
    // }).then((data) {}, onError: (e) {});
    return Future.delayed(const Duration(seconds: 2), () => '我是从互联网上获取的数据');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: FutureBuilder(
          future: mockNetworkData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Contents: ${snapshot.data}');
              }
            } else {
              // 请求未结束，显示loading
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class StreamBuilderRoute extends StatelessWidget {
  const StreamBuilderRoute({super.key});

  // void sssss() {
  //   Stream.fromFuture([
  //     Future.delayed(const Duration(seconds: 1), () {
  //       return 'Hello';
  //     }),
  //     Future.delayed(const Duration(seconds: 2), () {
  //       throw AssertionError('Error');
  //     })
  //   ] as Future)
  //       .listen((data) {
  //     print('data');
  //   }, onError: (e) {}, onDone: () {});
  // }

  Stream<int> counter() {
    return Stream.periodic(const Duration(seconds: 1), (i) {
      return i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<int>(
        stream: counter(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('没有Stream');
            case ConnectionState.waiting:
              return const Text('等待数据...');
            case ConnectionState.active:
              return Text('active: ${snapshot.data}');
            case ConnectionState.done:
              return const Text("Stream 已关闭");
            default:
              return const Text('');
          }
        },
      ),
    );
  }
}

// 对话框详解
class DialogTestRoute extends StatefulWidget {
  const DialogTestRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return DialogRouteState();
  }
}

class DialogRouteState extends State<DialogTestRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("对话框")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              bool? delete = await showDeleteConfirmDialog1();
              if (delete == null) {
                print('取消删除');
              } else {
                print('已确认删除');
              }
            },
            child: const Text('Alert Dialog'),
          ),
          ElevatedButton(
            onPressed: () {
              changeLanguage();
            },
            child: const Text('Simple Dialog'),
          ),
          ElevatedButton(
            onPressed: () {
              showListDialog();
            },
            child: const Text('List Dialog'),
          ),
          ElevatedButton(
            onPressed: () async {
              int? type = await _showModalBottomSheet();
              if (type != null) {
                print(type);
              }
            },
            child: const Text('Bottom Sheet Dialog'),
          ),
          ElevatedButton(
            onPressed: () async {
              showLoadingDialog();
            },
            child: const Text('Loading Dialog'),
          ),
          ElevatedButton(
            onPressed: () async {
              DateTime? date = await _showDatePicker1();
              if (date != null) {
                print('${date.toString()}');
              }
            },
            child: const Text('DatePicker Dialog'),
          ),
        ],
      ),
    );
  }

  // AlertDialog
  Future<bool?> showDeleteConfirmDialog1() {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('提示'),
            content: const SingleChildScrollView(child: Text('您确定删除当前文件吗？')),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  // 执行删除操作
                  Navigator.of(context).pop(true);
                },
                child: const Text('删除'),
              )
            ],
          );
        });
  }

  // SimpleDialog
  Future<void> changeLanguage() async {
    int? i = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('请选择语言'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 1);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('简体中文'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 2);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('英文'),
              ),
            ),
          ],
        );
      },
    );
    if (i != null) {
      print('选择了:${i == 1 ? "中文" : "英文"}');
    }
  }

  // Dialog
  Future<void> showListDialog() async {
    int? index = await showDialog(
        context: context,
        builder: (context) {
          var child = Column(
            children: [
              const ListTile(title: Text('请选择')),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('$index'),
                      onTap: () => Navigator.of(context).pop(index),
                    );
                  },
                  itemCount: 30,
                ),
              ),
            ],
          );
          return Dialog(child: child);
        });
    if (index != null) {
      print('点击了：$index');
    }
  }

  // 底部菜单列表
  Future<int?> _showModalBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('$index'),
              onTap: () {
                Navigator.of(context).pop(index);
              },
            );
          },
        );
      },
    );
  }

  // loading dialog
  Future<void> showLoadingDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('正在加载，请稍后...'),
              ),
            ],
          ),
        );
      },
    );
  }

  // 日期选择器
  Future<DateTime?> _showDatePicker1() {
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      firstDate: date.subtract(const Duration(days: 300)),
      lastDate: date.add(const Duration(days: 300)),
    );
  }
}

// 事件处理与通知
class PointerMoveIndicatorRoute extends StatefulWidget {
  const PointerMoveIndicatorRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PointerMoveIndicatorState();
  }
}

class _PointerMoveIndicatorState extends State<PointerMoveIndicatorRoute> {
  PointerEvent? _event;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: 300,
        height: 150,
        child: Text(
          '${_event?.localPosition ?? ''}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onPointerDown: (event) => setState(() {
        _event = event;
      }),
      onPointerMove: (event) => setState(() {
        _event = event;
      }),
      onPointerUp: (event) => setState(() {
        _event = event;
      }),
    );
  }
}

// 手势识别
class GestureTestRoute extends StatefulWidget {
  const GestureTestRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GestureTestState();
  }
}

class _GestureTestState extends State<GestureTestRoute> {
  String _operation = 'No Gesture detected!';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 400,
          height: 200,
          child: Text(_operation, style: const TextStyle(color: Colors.white)),
        ),
        onTap: () => updateText("Tap"), // 点击
        onDoubleTap: () => updateText('DoubleTap'), // 双击
        onLongPress: () => updateText('LongPress'), // 长按
      ),
    );
  }

  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }
}

// 拖动、滑动
class DragTestRoute extends StatefulWidget {
  const DragTestRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DragTestRouteState();
  }
}

class _DragTestRouteState extends State<DragTestRoute>
    with SingleTickerProviderStateMixin {
  double _top = 0; //
  double _left = 0;

  @override
  Widget build(BuildContext context) {
    // bus.on('login', (arg) {
    //   print(arg);
    // });
    return Stack(
      children: [
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: const CircleAvatar(child: Text('A')),
            // 手指按下会的位置
            onPanDown: (details) {
              // 打印手指按下的位置（相对于屏幕）
              print('用户手指按下：${details.globalPosition}');
            },
            // 手指滑动时会触发此回调
            onPanUpdate: (details) {
              // 用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += details.delta.dx;
                _top += details.delta.dy;
              });
            },
            onPanEnd: (details) {
              // 滑动结束时在X/y轴上的速度
              print(details.velocity.toString());
            },
          ),
        ),
      ],
    );
  }
}

class GestureRecognizerRoute extends StatefulWidget {
  const GestureRecognizerRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GestureRecognizerState();
  }
}

class _GestureRecognizerState extends State<GestureRecognizerRoute> {
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();

  bool _toggle = false; // 变色开关

  @override
  void dispose() {
    // 用到GestureRecognizer一定要调用其dispose方法释放资源(主要是取消内部计时器)
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: '你好世界'),
            TextSpan(
              text: '点我变色',
              style: TextStyle(
                fontSize: 20,
                color: _toggle ? Colors.blue : Colors.red,
              ),
              recognizer: _tapGestureRecognizer
                ..onTap = () {
                  bus.emit('gesture', 'sss');
                  setState(() {
                    _toggle = !_toggle;
                  });
                },
            ),
            const TextSpan(text: '你好世界'),
          ],
        ),
      ),
    );
  }
}

// 事件总线
typedef void EventCallback(arg);

class EventBus {
  // 私有构造函数
  EventBus._internal();

  // 保存单例
  static final EventBus _singleton = EventBus._internal();

  // 工厂构造函数
  factory EventBus() => _singleton;

  // 保存事件订阅者队列，key:事件名(id), value:对应事件的订阅者队列
  final _emap = <Object, List<EventCallback>?>{};

  // 添加订阅者
  void on(eventName, EventCallback f) {
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName]!.add(f);
  }

  // 移除订阅者
  void off(eventName, [EventCallback? f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) {
      return;
    }
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  // 触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) {
      return;
    }

    int len = list.length - 1;
    // 反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

var bus = EventBus();

// 通知 Notification
class NotificationRoute extends StatefulWidget {
  const NotificationRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return NotificationRouteState();
  }
}

class NotificationRouteState extends State<NotificationRoute> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _msg += "${notification.msg}  ";
        });
        return true;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => MyNotification('Hi').dispatch(context),
                  child: const Text('Send Notification'),
                );
              },
            ),
            Text(_msg),
          ],
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  final String msg;
  MyNotification(this.msg);
}
