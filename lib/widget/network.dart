import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_test0715/widget/functionview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class NetworkRoute extends StatefulWidget {
  const NetworkRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NetworkRouteState();
  }
}

class _NetworkRouteState extends State<NetworkRoute> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文件操作与网络请求'),
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
                  Navigator.pushNamed(context, 'file_operation_route');
                },
                child: const Text('File Operation Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'shared_preferences_route');
                },
                child: const Text('Shared Preferences Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'http_test_route');
                },
                child: const Text('Http Test Route'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'future_builder_route1');
                },
                child: const Text('Future Builder Route'),
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

// 文件操作
class FileOperationRoute extends StatefulWidget {
  const FileOperationRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FileOperationRouteState();
  }
}

class _FileOperationRouteState extends State<FileOperationRoute> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // 从文件读取点击次数
    _readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _getLocalFile() async {
    // 获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    print('path:$dir');
    return File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      // 读取点击次数
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  _incrementCounter() async {
    setState(() {
      _counter++;
    });
    // 将点击次数以字符串类型写到文件中
    await (await _getLocalFile()).writeAsString('$_counter');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('文件操作')),
      body: Center(
        child: Text('点击了$_counter次'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

// shared_preferences: 存储简单数据插件Demo
class SharedPreferencesDemo extends StatefulWidget {
  const SharedPreferencesDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return SharedPreferencesDemoState();
  }
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  final Future<SharedPreferencesWithCache> _prefs =
      SharedPreferencesWithCache.create(
          cacheOptions: const SharedPreferencesWithCacheOptions(
              // This cache will only accept the key 'counter'.
              allowList: <String>{'counter'}));

  late Future<int> _counter;
  int _externalCounter = 0;

  Future<void> _incrementCounter() async {
    final SharedPreferencesWithCache prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {
      _counter = prefs.setInt('counter', counter).then((value) {
        return counter;
      });
    });
  }

  /// Gets external button presses that could occur in another instance,thread
  /// or via some native system.
  Future<void> _getExternalCounter() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();

    setState(() async {
      _externalCounter = (await prefs.getInt('externalCounter')) ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferencesWithCache prefs) {
      return prefs.getInt('counter') ?? 0;
    });
    _getExternalCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferencesWithCaceh Demo'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _counter,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(
                      'Button tapped ${snapshot.data ?? 0 + _externalCounter} time ${(snapshot.data ?? 0 + _externalCounter) == 1 ? '' : 's'}.\n\n'
                      'This should persist across restarts.');
                }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// 通过HttpClient发起HTTP请求
class HttpTestRoute extends StatefulWidget {
  const HttpTestRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return HttpTestRouteState();
  }
}

class HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _loading ? null : request,
              child: const Text('获取百度首页'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(_text.replaceAll(RegExp(r"\s"), "")),
            ),
          ],
        ),
      ),
    );
  }

  request() async {
    setState(() {
      _loading = true;
      _text = '正在请求...';
    });

    try {
      // 创建一个HttpClient
      HttpClient httpClient = HttpClient();
      // 打开Http连接
      HttpClientRequest request =
          await httpClient.getUrl(Uri.parse('https://www.baidu.com'));
      // 使用iPhone的UA
      request.headers.add(
        'user-agent',
        "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1",
      );
      // 等待连接服务器（会将请求信息发送给服务器）
      HttpClientResponse response = await request.close();
      // 读取响应内容
      _text = await response.transform(utf8.decoder).join();
      // 输出响应头
      print(response.headers);
      // 关闭client后，通过该client发起的所有请求都会终止
      httpClient.close();
    } catch (e) {
      _text = '请求失败：$e';
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}

// Http请求库-dio
class FutureBuilderRoute1 extends StatefulWidget {
  const FutureBuilderRoute1({super.key});

  @override
  State<StatefulWidget> createState() {
    return FutureBuilderRouteState();
  }
}

class FutureBuilderRouteState extends State<FutureBuilderRoute1> {
  Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: dio.get('https://api.github.com/orgs/flutterchina/repos'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //请求完成
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              //发生错误
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              // 请求成功，通过项目信息构建用于显示项目名称的ListView
              return ListView(
                children: response.data
                    .map<Widget>((e) => ListTile(title: Text(e['full_name'])))
                    .toList(),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
