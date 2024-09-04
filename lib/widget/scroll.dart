import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScaffoldRoute extends StatefulWidget {
  const ScaffoldRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ScaffoldRouteState();
  }
}

class _ScaffoldRouteState extends State<ScaffoldRoute> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('滚动组件Demo'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        ],
      ),
      drawer: const MyDrawer(),
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
                  Navigator.pushNamed(
                      context, 'singlechildscrollview_test_route');
                },
                child: const Text('SingleChildScrollView Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'infinite_listview_route');
                },
                child: const Text('ListView Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'scroll_controller_route');
                },
                child: const Text('ScrollController Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'scroll_notification_route');
                },
                child: const Text('Scroll Notification Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'animated_list_route');
                },
                child: const Text('Animated List Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'infinite_gridview_route');
                },
                child: const Text('Grid View Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'page_view_route');
                },
                child: const Text('Page View Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                child: const Text('Keep Alive Route'),
                onPressed: () {
                  Navigator.pushNamed(context, 'keep_alive_test_route');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                child: const Text('Tab View Route1'),
                onPressed: () {
                  Navigator.pushNamed(context, 'tab_view_route1');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                child: const Text('Tab View Route2'),
                onPressed: () {
                  Navigator.pushNamed(context, 'tab_view_route2');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                child: const Text('Custom Scroll View Route'),
                onPressed: () {
                  Navigator.pushNamed(context, 'custom_scroll_view_route');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                child: const Text('Persistend Header Route'),
                onPressed: () =>
                    Navigator.pushNamed(context, 'persistend_header_route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                child: const Text('SnapAppBar Route'),
                onPressed: () =>
                    Navigator.pushNamed(context, 'snap_app_bar_route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                child: const Text('Nested TabBarView Route'),
                onPressed: () =>
                    Navigator.pushNamed(context, 'nested_tab_bar_view_route'),
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

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true, // 移除抽屉菜单顶部默认留白
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 38),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipOval(
                      child: Image.asset(
                        'images/fuyou.jpg',
                        width: 80,
                      ),
                    ),
                  ),
                  const Text(
                    "WangDapeng",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  const ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Add account'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Manage accounts'),
                  ),
                  const Image(
                    image: AssetImage('images/fuyou.png'),
                    width: 50,
                    height: 50,
                  ),
                  SvgPicture.asset(
                    'images/fuyou.svg',
                    semanticsLabel: "蜉蝣",
                    width: 50,
                    height: 50,
                    colorFilter: const ColorFilter.mode(
                        Colors.amber, BlendMode.colorBurn),
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

class SingleChildScrollViewTestRoute extends StatelessWidget {
  const SingleChildScrollViewTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    String str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return Scrollbar(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            // 动态创建一个List<Widget> 每个字母都用一个Text显示，字体为原来的两倍
            children: str
                .split("")
                .map((c) => Text(c, textScaler: const TextScaler.linear(2)))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class InfiniteListView extends StatefulWidget {
  const InfiniteListView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InfiniteListViewState();
  }
}

class _InfiniteListViewState extends State {
  static const loadingTag = '##loading##';
  final _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ListTile(title: Text('列表')),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                // 如果到了末尾
                if (_words[index] == loadingTag) {
                  // 不足100条，继续获取数据
                  if (_words.length - 1 < 100) {
                    // 获取数据
                    _retrieveData();
                    // 加载时显示loading
                    return Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      child: const Text('没有更多了',
                          style: TextStyle(color: Colors.grey)),
                    );
                  }
                }
                return ListTile(title: Text(_words[index]));
              },
              separatorBuilder: (context, index) => const Divider(height: .0),
              itemCount: _words.length,
            ),
          ),
        ],
      ),
    );
  }

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((e) {
      setState(() {
        // 重新构建列表
        _words.insertAll(
          _words.length - 1,
          // 每次生成20个单词
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList(),
        );
      });
    });
  }
}

class ScrollControllerTestRoute extends StatefulWidget {
  const ScrollControllerTestRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return ScrollControllerTestRouteState();
  }
}

class ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {
  final ScrollController _controller = ScrollController();
  bool showToTopBtn = false; // 是否显示“返回到顶部”按钮

  @override
  void initState() {
    super.initState();
    // 监听滚动事件，打印滚动位置
    _controller.addListener(() {
      print(_controller.offset); // 打印滚动位置
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // 为了避免内存泄漏
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('滚动控制')),
      body: Scrollbar(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(title: Text('$index'));
          },
          itemCount: 100,
          itemExtent: 50, // 列表项高度固定时，显式指定高度是一个好习惯（性能消耗小）
          controller: _controller,
        ),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              onPressed: () {
                //返回到顶部时执行动画
                _controller.animateTo(
                  .0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.ease,
                );
              },
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }
}

class ScrollNotificationRoute extends StatefulWidget {
  const ScrollNotificationRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ScrollNotificationRouteState();
  }
}

class _ScrollNotificationRouteState extends State {
  String _progress = '0%';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            double progress = notification.metrics.pixels /
                notification.metrics.maxScrollExtent;
            setState(() {
              _progress = '${(progress * 100).toInt()}%';
            });
            print('BottomEgde: ${notification.metrics.extentAfter == 0}');
            return false;
            // return true; // 放开此行注释后，进度条将消失
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(title: Text('$index'));
                },
                itemCount: 100,
                itemExtent: 50,
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.tealAccent,
                child: Text(_progress),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedListRoute extends StatefulWidget {
  const AnimatedListRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AnimatedListRouteState();
  }
}

class _AnimatedListRouteState extends State {
  var data = <String>[];
  int counter = 5;

  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    for (var i = 0; i < counter; i++) {
      data.add('${i + 1}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedList(
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              // 添加列表项会执行渐显动画
              return FadeTransition(
                opacity: animation,
                child: buildItem(context, index),
              );
            },
            key: globalKey,
            initialItemCount: data.length,
          ),
          buildAddBtn(),
        ],
      ),
    );
  }

  // 创建一个 + 按钮，点击后会向列表插入一项
  Widget buildAddBtn() {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: FloatingActionButton(
        onPressed: () {
          // 添加一个列表项
          data.add('${++counter}');
          // 告诉列表项有新添加的列表项
          globalKey.currentState!.insertItem(data.length - 1);
          print('添加 $counter');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // 构建列表项
  Widget buildItem(context, index) {
    String char = data[index];
    return ListTile(
      //数字不会重复，所以作为Key
      key: ValueKey(char),
      title: Text(char),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          return onDelete(context, index);
        },
      ),
    );
  }

  void onDelete(context, index) {
    setState(() {
      globalKey.currentState!.removeItem(
        index,
        (context, animation) {
          // 删除过程执行的是反向动画，animation.value会从1变为0
          var item = buildItem(context, index);
          print('删除 ${data[index]}');
          data.removeAt(index);
          // 删除动画是一个合成动画：渐隐 + 收纳列表项
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: const Interval(0.5, 1),
            ),
            child: SizeTransition(
              sizeFactor: animation,
              axisAlignment: 0.0,
              child: item,
            ),
          );
        },
        // 动画时间200ms
        duration: const Duration(milliseconds: 200),
      );
    });
  }
}

class InfiniteGridView extends StatefulWidget {
  const InfiniteGridView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InfiniteGridViewState();
  }
}

class _InfiniteGridViewState extends State<InfiniteGridView> {
  List<IconData> _icons = [];

  @override
  void initState() {
    super.initState();
    _retrieveIcons();
  }

  void _retrieveIcons() {
    Future.delayed(const Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast,
        ]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          // 如果显示到最后一个并且Icon总数小于200时继续获取数据
          if (index == _icons.length - 1 && _icons.length < 50) {
            _retrieveIcons();
          }
          return Icon(_icons[index]);
        },
        itemCount: _icons.length,
      ),
    );
  }
}

// tab页面
class Page extends StatefulWidget {
  const Page({super.key, required this.text});

  final String text;

  @override
  State<StatefulWidget> createState() {
    return _PageState();
  }
}

class _PageState extends State<Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('build ${widget.text}');
    return Center(
      child: Text(widget.text, textScaler: const TextScaler.linear(5)),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PageViewRoute extends StatelessWidget {
  const PageViewRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (int i = 0; i < 6; i++) {
      children.add(Page(text: '$i'));
    }
    return PageView(
      allowImplicitScrolling: true,
      scrollDirection: Axis.horizontal,
      children: children,
    );
  }
}

class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper(
      {super.key, this.keepAlive = true, required this.child});

  final bool keepAlive;
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _KeepAliveWrapperState();
  }
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive状态需要更新，实现在AutomaticKeepAliveClientMixin中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}

class KeepAliveTestRoute extends StatelessWidget {
  const KeepAliveTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return KeepAliveWrapper(
        // 为true后会缓存所有的列表项，列表项不会销毁
        // 使用时一定要注意是否必要，因为对所有列表都缓存会导致更多的内存消耗
        keepAlive: true,
        child: ListItem(
          index: index,
        ),
      );
    });
  }
}

class ListItem extends StatefulWidget {
  const ListItem({super.key, required this.index});

  final int index;
  @override
  State<StatefulWidget> createState() {
    return _ListItemState();
  }
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${widget.index}'),
    );
  }

  @override
  void dispose() {
    print('dispose ${widget.index}');
    super.dispose();
  }
}

class TabViewRoute1 extends StatefulWidget {
  const TabViewRoute1({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabViewRoute1State();
  }
}

class _TabViewRoute1State extends State<TabViewRoute1>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List tabs = ['新闻', '历史', '图片'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Name'),
        bottom: TabBar(
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return KeepAliveWrapper(
            child: Container(
              alignment: Alignment.center,
              child: Text(e, textScaler: const TextScaler.linear(5)),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class TabViewRoute2 extends StatelessWidget {
  const TabViewRoute2({super.key});

  @override
  Widget build(BuildContext context) {
    List tabs = ['图片', '历史', '设置', '新闻'];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('App Name'),
          bottom: TabBar(
            tabs: tabs.map((e) => Text(e)).toList(),
          ),
        ),
        body: TabBarView(
          children: tabs.map((e) {
            return Container(
              alignment: Alignment.center,
              child: Text(e, textScaler: const TextScaler.linear(8)),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CustomScrollViewRoute extends StatefulWidget {
  const CustomScrollViewRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomScrollViewRouteState();
  }
}

class _CustomScrollViewRouteState extends State<CustomScrollViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true, // 滑动到顶端会固定住
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset(
                'images/background.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 4,
              ),
            ),
          ),
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('list item $index'),
                  );
                },
                childCount: 20,
              ),
              itemExtent: 50),
        ],
      ),
    );
  }
}

typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDeleate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  // child 为header
  SliverHeaderDeleate({
    required this.maxHeight,
    this.minHeight = 0,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  // 最大和最小高度相同
  SliverHeaderDeleate.fixedHeight({
    required double height,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  SliverHeaderDeleate.builder({
    required this.maxHeight,
    this.minHeight = 0,
    required this.builder,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Widget child = builder(context, shrinkOffset, overlapsContent);
    assert(() {
      if (child.key != null) {
        print(
            '${child.key}: shrink: $shrinkOffset. overlaps: $overlapsContent');
      }
      return true;
    }());
    // 让header尽可能充满限制的空间，宽度为Viewport宽度，高度随着用户滑动在[minHeight, maxHeight]之间变化
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent;
  }
}

class PersistentHeaderRoute extends StatelessWidget {
  const PersistentHeaderRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          buildSliverList(),
          SliverPersistentHeader(
            delegate: SliverHeaderDeleate(
                maxHeight: 80, minHeight: 50, child: buidlHeader(1)),
            pinned: true,
          ),
          buildSliverList(),
          SliverPersistentHeader(
            delegate: SliverHeaderDeleate.fixedHeight(
                height: 50, child: buidlHeader(2)),
            pinned: true,
          ),
          buildSliverList(20),
        ],
      ),
    );
  }

  // 构建固定高度的SliverList count为列表项属性
  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(title: Text('$index')),
        childCount: count,
      ),
      itemExtent: 50,
    );
  }

  // 构建header
  Widget buidlHeader(int i) {
    return Container(
      color: Colors.lightBlue.shade200,
      alignment: Alignment.centerLeft,
      child: Text("PersistentHeader $i"),
    );
  }
}

class SnapAppBar extends StatelessWidget {
  const SnapAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                floating: true,
                snap: true,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'images/background.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                forceElevated: innerBoxIsScrolled,
              ),
            ),
          ];
        },
        body: Builder(builder: (context) {
          return CustomScrollView(
            slivers: [
              SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
              buildSliverList(40),
            ],
          );
        }),
      ),
    );
  }

  // 构建固定高度的SliverList count为列表项属性
  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(title: Text('$index')),
        childCount: count,
      ),
      itemExtent: 50,
    );
  }
}

class NestedTabBarView extends StatelessWidget {
  const NestedTabBarView({super.key});

  // 构建固定高度的SliverList count为列表项属性
  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(title: Text('$index')),
        childCount: count,
      ),
      itemExtent: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _tabs = <String>['猜你喜欢', '今日特价', '发现更多'];
    return Material(
      child: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: const Text('商城'),
                  floating: true,
                  snap: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                      tabs: _tabs.map((name) => Tab(text: name)).toList()),
                ),
              ),
            ];
          },
          body: TabBarView(
              children: _tabs.map((name) {
            return Builder(
              builder: (context) {
                return CustomScrollView(
                  key: PageStorageKey<String>(name),
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8),
                      sliver: buildSliverList(50),
                    )
                  ],
                );
              },
            );
          }).toList()),
        ),
      ),
    );
  }
}
