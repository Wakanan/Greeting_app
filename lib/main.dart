import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ツッコミマシーン',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GreetingMachine(title: 'ツッコミマシーン'),
    );
  }
}

class GreetingMachine extends StatefulWidget {
  const GreetingMachine({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<GreetingMachine> createState() => _GreetingMachineState();
}

class _GreetingMachineState extends State<GreetingMachine> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> _word = [
    'おめでとうございます',
    '合格です',
    'よくできました',
    '残念でした',
    '不合格です',
    '頑張りましょう'
  ];
  final _audio = AudioCache();

  @override
  Widget build(BuildContext context) {
    // アスペクト比を計算する
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: (itemWidth / itemHeight),
          children: List<Widget>.generate(
            6,
            _generator,
          ),
        ),
      ),
    );
  }

  Widget _generator(int index) {
    int num = index + 1;

    return GestureDetector(
      child: GridTile(
        child: Container(
          color: Colors.black.withOpacity(0.1),
          child: Center(
            child: Text(
              _word[index],
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      onTap: () => _audio.play('sound' + num.toString() + '.mp3'),
    );
  }
}
