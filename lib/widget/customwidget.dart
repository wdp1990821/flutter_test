import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class CustomWidgetRoute extends StatefulWidget {
  const CustomWidgetRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomWidgetRouteState();
  }
}

class _CustomWidgetRouteState extends State<CustomWidgetRoute> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义组件'),
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
                  Navigator.pushNamed(context, 'gradient_button_route');
                },
                child: const Text('Gradient Button Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'turn_box_route');
                },
                child: const Text('Turn Box Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'custom_paint_route');
                },
                child: const Text('Custom Paint Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'circular_progress_route');
                },
                child: const Text('Circular Progress Route'),
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

// 渐变背景按钮
class GradientButton extends StatelessWidget {
  // 渐变色数组
  final List<Color>? colors;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  // 点击回调
  final GestureTapCallback? onPressed;
  final Widget child;

  const GradientButton(
      {super.key,
      this.colors,
      this.width,
      this.height,
      this.borderRadius,
      this.onPressed,
      required this.child});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // 确保Colors数组不空
    List<Color> _colors =
        colors ?? [theme.primaryColor, theme.primaryColorDark];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: DefaultTextStyle(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientButtonRoute extends StatefulWidget {
  const GradientButtonRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GradientButtonRouteState();
  }
}

class _GradientButtonRouteState extends State<GradientButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GradientButton(
          colors: const [Colors.orange, Colors.red],
          height: 50.0,
          onPressed: onTap,
          child: const Text('Submit'),
        ),
        GradientButton(
          colors: const [Colors.lightGreen, Colors.green],
          height: 50.0,
          onPressed: onTap,
          child: const Text('Submit'),
        ),
        GradientButton(
          height: 50.0,
          onPressed: onTap,
          child: const Text('Submit'),
        ),
      ],
    );
  }

  onTap() {
    print('Button Click');
  }
}

// 组合实例 TurnBox
class TurnBox extends StatefulWidget {
  const TurnBox({
    super.key,
    this.turns = .0, // 旋转的“圈”数，一圈360度，如0.25圈即90度
    this.speed = 200, // 过渡动画执行的总时长
    required this.child,
  });

  final double turns;
  final int speed;
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _TurnBoxState();
  }
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: -double.infinity,
      upperBound: double.infinity,
    );
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(covariant TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed),
        curve: Curves.easeOut,
      );
    }
  }
}

class TurnBoxRoute extends StatefulWidget {
  const TurnBoxRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TurnBoxRouteState();
  }
}

class _TurnBoxRouteState extends State<TurnBoxRoute> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TurnBox(
            turns: _turns,
            speed: 500,
            child: const Icon(
              Icons.refresh,
              size: 40,
            ),
          ),
          TurnBox(
            turns: _turns,
            speed: 1000,
            child: const Icon(
              Icons.refresh,
              size: 150,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _turns += .2;
              });
            },
            child: const Text('顺时针旋转1/5圈'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _turns -= .2;
              });
            },
            child: const Text('逆时针选择1/5圈'),
          ),
        ],
      ),
    );
  }
}

class CustomPaintRoute extends StatelessWidget {
  const CustomPaintRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RepaintBoundary(
        child: CustomPaint(
          size: const Size(300, 300),
          painter: MyPainter(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('paint');
    var rect = Offset.zero & size;
    drawChessboard(canvas, rect);
    drawPieces(canvas, rect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void drawChessboard(Canvas canvas, Rect rect) {
    // 棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFDCC48C);
    canvas.drawRect(rect, paint);

    // 画棋盘网格
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black38
      ..strokeWidth = 1.0;

    // 画横线
    for (int i = 0; i <= 15; ++i) {
      double dy = rect.top + rect.height / 15 * i;
      canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = rect.left + rect.width / 15 * i;
      canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
    }
  }

  // 画棋子
  void drawPieces(Canvas canvas, Rect rect) {
    double eWidth = rect.width / 15;
    double eHeight = rect.height / 15;

    // 画一个黑子
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    canvas.drawCircle(
      Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );

    // 画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
  }
}

// 圆形背景渐变进度条
class GradientCircularProgressIndicator extends StatelessWidget {
  const GradientCircularProgressIndicator({
    super.key,
    this.strokeWidth = 2.0,
    required this.radius,
    this.strokeCapRound = false,
    required this.value,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.totalAngle = 2 * pi,
    required this.colors,
  });

  //粗细
  final double strokeWidth;
  // 圆的半径
  final double radius;
  // 两端是否为圆角
  final bool strokeCapRound;
  // 当前进度，取值范围[0.0-1.0]
  final double value;
  // 进度条背景颜色
  final Color backgroundColor;
  // 进度条的总弧度，2*PI为整圆，
  final double totalAngle;
  // 渐变色数组
  final List<Color> colors;
  // 渐变色的终止点，对应colors属性
  // final List<double> stops;

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    // 如果两端为圆角，则需要对起始位置进行调整，否则圆角部分会偏离起始位置
    // 下面调整的角度的计算公式是通过数学几何知识得出。
    if (strokeCapRound) {
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }

    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).colorScheme.secondary;
      _colors = [color, color];
    }

    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
          strokeWidth: strokeWidth,
          strokeCapRound: strokeCapRound,
          backgroundColor: backgroundColor,
          value: value,
          total: totalAngle,
          radius: radius,
          colors: _colors,
          // stops: stops,
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter(
      {this.strokeWidth = 10.0,
      this.strokeCapRound = false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      required this.radius,
      this.total = 2 * pi,
      required this.colors,
      // required this.stops,
      required this.value});

  final double strokeWidth;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double radius;
  // final List<double> stops;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius);
    }

    double _offset = strokeWidth / 2.0;
    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    if (strokeCapRound) {
      _start = asin(strokeWidth / (size.width - strokeWidth));
    }

    Rect rect = Offset(_offset, _offset) &
        Size(
          size.width - strokeWidth,
          size.height - strokeWidth,
        );

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    // 先画背景
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    // 再画前景，应用渐变
    if (_value > 0) {
      paint.shader = SweepGradient(
        colors: colors,
        startAngle: 0.0,
        endAngle: _value,
        // stops: stops,
      ).createShader(rect);

      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  // 简单返回true，实际中根据画笔属性是否变化来确定返回true还是false
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class GradientCircularProgressRoute extends StatefulWidget {
  const GradientCircularProgressRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return GradientCircularProgressRouteState();
  }
}

class GradientCircularProgressRouteState
    extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    bool isForward = true;

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 10,
                        runSpacing: 16,
                        children: [
                          GradientCircularProgressIndicator(
                            radius: 50.0,
                            value: _animationController.value,
                            colors: const [Colors.blue, Colors.blue],
                            strokeWidth: 3.0,
                          ),
                          GradientCircularProgressIndicator(
                            radius: 50.0,
                            value: _animationController.value,
                            colors: const [Colors.red, Colors.orange],
                            strokeWidth: 3.0,
                          ),
                          GradientCircularProgressIndicator(
                            radius: 50.0,
                            value: _animationController.value,
                            colors: const [
                              Colors.red,
                              Colors.orange,
                              Colors.red,
                            ],
                            strokeWidth: 3.0,
                          ),
                          GradientCircularProgressIndicator(
                            radius: 50.0,
                            value: CurvedAnimation(
                              parent: _animationController,
                              curve: Curves.decelerate,
                            ).value,
                            colors: const [Colors.teal, Colors.cyan],
                            strokeWidth: 3.0,
                          ),
                          TurnBox(
                            turns: 1 / 8,
                            child: GradientCircularProgressIndicator(
                              radius: 50.0,
                              value: CurvedAnimation(
                                parent: _animationController,
                                curve: Curves.ease,
                              ).value,
                              colors: const [
                                Colors.red,
                                Colors.orange,
                                Colors.red,
                              ],
                              strokeWidth: 5.0,
                              strokeCapRound: true,
                              backgroundColor: Colors.red.shade50,
                              totalAngle: 1.5 * pi,
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: GradientCircularProgressIndicator(
                              radius: 50.0,
                              strokeWidth: 3.0,
                              value: _animationController.value,
                              colors: [
                                Colors.blue.shade700,
                                Colors.blue.shade200
                              ],
                              strokeCapRound: true,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

