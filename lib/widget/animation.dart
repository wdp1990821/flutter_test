import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimationRoute extends StatefulWidget {
  const AnimationRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AnimationRouteState();
  }
}

class _AnimationRouteState extends State<AnimationRoute> {
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
                  Navigator.pushNamed(context, 'scale_animation_route');
                },
                child: const Text('Scale Animation Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'hero_animation_route_a');
                },
                child: const Text('Hero Route A'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'stagger_route');
                },
                child: const Text('Stagger Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, 'animated_switcher_counter_route');
                },
                child: const Text('Animated Switcher Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'animated_widget_route');
                },
                child: const Text('Animated Wiget Route'),
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

class ScaleAnimationRoute extends StatefulWidget {
  const ScaleAnimationRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ScaleAnimationRouteState();
  }
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // 使用弹性曲线
    // animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);

    // 匀速 图片宽高从0变到300
    // animation = Tween(begin: 0.0, end: 300.0).animate(animation);
    // ..addListener(() {
    //   setState(() {});
    // });

    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    // 启动
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Image.asset(
    //     'images/fuyou.jpg',
    //     width: animation.value,
    //     height: animation.value,
    //   ),
    // );

    // return AnimatedImage(listenable: animation);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Center(
          child: SizedBox(
            width: animation.value,
            height: animation.value,
            child: child,
          ),
        );
      },
      child: Image.asset('images/fuyou.jpg'),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// 使用AnimatedWidget简化
class AnimatedImage extends AnimatedWidget {
  const AnimatedImage({super.key, required super.listenable});

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Image.asset(
        'images/fuyou.jpg',
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

// Hero动画
class HeroAnimationRouteA extends StatelessWidget {
  const HeroAnimationRouteA({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            InkWell(
              child: Hero(
                tag: 'avatar',
                child: ClipOval(
                  child: Image.asset(
                    'images/fuyou.jpg',
                    width: 50,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context, PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: Scaffold(
                      appBar: AppBar(
                        title: const Text('原图'),
                      ),
                      body: const HeroAnimationRouteB(),
                    ),
                  );
                }));
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text('点击头像'),
            ),
          ],
        ),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  const HeroAnimationRouteB({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Hero(
          tag: 'avatar', // 唯一标记，前后两个路由页Hero的tag必须相同
          child: Image.asset('images/fuyou.jpg'),
        ),
      ),
    );
  }
}

// 交织动画
class StaggerAnimation extends StatelessWidget {
  late final Animation<double> controller;
  late final Animation<double> height;
  late final Animation<EdgeInsets> padding;
  late final Animation<Color?> color;

  StaggerAnimation({
    Key? key,
    required this.controller,
  }) : super(key: key) {
    // 高度动画
    height = Tween<double>(begin: .0, end: 300.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.6, // 间隔 ： 前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.6,
          curve: Curves.ease,
        ),
      ),
    );

    padding = Tween<EdgeInsets>(
      begin: const EdgeInsets.only(left: .0),
      end: const EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.6,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }
}

class StaggerRoute extends StatefulWidget {
  const StaggerRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StaggerRouteState();
  }
}

class _StaggerRouteState extends State<StaggerRoute>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
  }

  _playAnimation() async {
    try {
      // 先正向执行动画
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // 捕获异常，可能发生在组件销毁时，计时器会被取消
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => _playAnimation(),
            child: const Text('start animation'),
          ),
          Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(color: Colors.black.withOpacity(0.5)),
            ),
            child: StaggerAnimation(controller: _controller),
          ),
        ],
      ),
    );
  }
}

// 动画切换组件（AnimatedSwitcher）
class AnimatedSwitcherCounterRoute extends StatefulWidget {
  const AnimatedSwitcherCounterRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AnimatedSwitcherCounterRouteState();
  }
}

class _AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              // return ScaleTransition(scale: animation, child: child);
              return SlideTransitionX(
                position: animation,
                direction: AxisDirection.left,
                child: child,
              );
            },
            child: Text(
              '$_count',
              // 显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
              // AnimatedSwitcher的新旧child，如果类型相同，则key必须不相等
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() {
              _count += 1;
            }),
            child: const Text('+1'),
          ),
        ],
      ),
    );
  }
}

class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    super.key,
    required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    required this.child,
  }) : super(listenable: position) {
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: const Offset(0, -1), end: const Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: const Offset(1, 0), end: const Offset(0, 0));
        break;
    }
  }

  final bool transformHitTests;
  final Widget child;
  final AxisDirection direction;
  late final Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<double>;
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }

    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

// 动画过渡组件
class AnimatedWidgetTest extends StatefulWidget {
  const AnimatedWidgetTest({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AnimatedWidgetTestState();
  }
}

class _AnimatedWidgetTestState extends State<AnimatedWidgetTest> {
  double _padding = 10;
  var _align = Alignment.topRight;
  double _height = 100;
  double _left = 0;
  Color _color = Colors.red;
  TextStyle _style = const TextStyle(color: Colors.black);
  Color _decorationColor = Colors.blue;
  double _opacity = 1;

  @override
  Widget build(BuildContext context) {
    var duration = const Duration(microseconds: 400);
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _padding = 20;
              });
            },
            child: AnimatedPadding(
              duration: duration,
              padding: EdgeInsets.all(_padding),
              child: const Text('AnimatedPadding'),
            ),
          ),
          SizedBox(
            height: 50,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: duration,
                  left: _left,
                  child: ElevatedButton(
                    onPressed: () => setState(() {
                      _left = 100;
                    }),
                    child: const Text('AnimatedPositioned'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey,
            child: AnimatedAlign(
              alignment: _align,
              duration: duration,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _align = Alignment.center;
                  });
                },
                child: const Text('AnimatedAlign'),
              ),
            ),
          ),
          AnimatedContainer(
            duration: duration,
            height: _height,
            color: _color,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _height = 150;
                  _color = Colors.blue;
                });
              },
              child: const Text(
                'AnimatedContainer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          AnimatedDefaultTextStyle(
            style: _style,
            duration: duration,
            child: GestureDetector(
              child: const Text('hello world'),
              onTap: () {
                setState(() {
                  _style = const TextStyle(
                    color: Colors.blue,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.blue,
                  );
                });
              },
            ),
          ),
          AnimatedOpacity(
            opacity: _opacity,
            duration: duration,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue)),
              onPressed: () {
                setState(() {
                  _opacity = 0.2;
                });
              },
              child: const Text(
                'AnimatedOpacity',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


