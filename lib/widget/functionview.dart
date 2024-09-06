import 'dart:collection';

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
                  Navigator.pushNamed(context, '');
                },
                child: const Text(''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '');
                },
                child: const Text(''),
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