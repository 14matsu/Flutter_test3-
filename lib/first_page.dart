import 'package:flutter/material.dart';
import 'package:time_watch_app/second_page.dart';

class FirstPage extends StatelessWidget {
  String nameText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('とおる'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  onChanged: (text) {
                    nameText = text;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '入れてみろ',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondPage(nameText),
                      ));
                },
                child: const Text('次の画面へ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}