import 'package:flutter/material.dart';
import 'package:time_watch_app/third_page.dart';

class SecondPage extends StatelessWidget {
  String nameText = '';
  SecondPage(this.name);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('second'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 50),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                onChanged: (text) {
                  nameText = text;
                },
              ),
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
                      builder: (context) => ThirdPage(name),
                    ));
              },
              child: const Text('次の画面へ'),
            ),
          ],
        ),
      ),
    );
  }
}
