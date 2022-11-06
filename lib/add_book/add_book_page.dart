import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_watch_app/add_book/add_book_model.dart';

//firebaseは考えずコード処理をするページ

class AddBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 245, 5, 105),
          title: const Text(
            '本を追加',
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
        body: Center(
          child: Consumer<AddBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: '本のタイトル',
                    ),
                    onChanged: (text) {
                      //ToDo:ここで取得したtext使う
                      model.title = text;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '本の著者',
                    ),
                    onChanged: (text) {
                      //ToDo:ここで取得したtext使う
                      model.author = text;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        //追加の処理
                        try {
                          await model.addBook();
                          Navigator.of(context).pop(true);
                        } catch (e) {
                          //追加するを押したときに下に出てくるやる
                          final snackBar = SnackBar(
                            backgroundColor: Color.fromARGB(255, 246, 93, 113),
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text('追加する'))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
