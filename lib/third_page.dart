import 'package:flutter/material.dart';
import 'package:time_watch_app/book_list/forth_page.dart';

class ThirdPage extends StatelessWidget {
  ThirdPage(this.name);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: const Text(
          'Third',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(Icons.laptop_chromebook),
          SizedBox(width: 24),
          Icon(Icons.search),
          SizedBox(width: 24),
          Icon(Icons.menu),
          SizedBox(width: 24),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _titleArea(),
            _buttonArea(context),
          ],
        ),
      ),
    );
  }
}

Widget _titleArea() {
  final List<String> entries = <String>[
    '今日からぼくはブレイクダンス',
    '技術マウントをとるエンジニアさんへの熱いメッセージをぼくは送る',
    'C'
  ];
  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: entries.length,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 100,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Image.network(
              'https://i.ytimg.com/vi/iMqKxgtaS48/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDkYkqQs-sd2mK8U9BjKoJZP9bMig',
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entries[index],
                    style: TextStyle(
                        color: Colors.green, height: 1.3, fontSize: 16),
                    maxLines: 3,
                  ),
                  Text(
                    '1050回視聴 7日前',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buttonArea(BuildContext context) {
  final String name;

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text('前の画面へ'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForthPage(),
              ),
            );
          },
          child: const Text('次の画面へ'),
        ),
      ],
    ),
  );
}
