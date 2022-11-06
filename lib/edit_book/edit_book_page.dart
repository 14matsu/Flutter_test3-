import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_watch_app/domain/book.dart';
import 'package:time_watch_app/edit_book/edit_book_model.dart';

//firebaseは考えずコード処理をするページ

class EditBookPage extends StatelessWidget {
  final Book book;
  EditBookPage(this.book);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditBookModel>(
      create: (_) => EditBookModel(book),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 245, 5, 105),
          title: const Text(
            '本を編集',
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
          child: Consumer<EditBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: model.title_controller, //編集画面でタイトルと著者を最初から残す
                    decoration: InputDecoration(
                      hintText: '本のタイトル',
                    ),
                    onChanged: (text) {
                      //ToDo:ここで取得したtext使う
                      model.title = text;
                      model.setTitle(text);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: model.author_controller,
                    decoration: InputDecoration(
                      hintText: '本の著者',
                    ),
                    onChanged: (text) {
                      //ToDo:ここで取得したtext使う
                      model.author = text;
                      model.setAuthor(text);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: model.isUpdated()
                          ? () async {
                              //更新の処理
                              try {
                                await model.updateBook();
                                Navigator.of(context).pop(true);
                              } catch (e) {
                                //更新するを押したときに下に出てくるやる
                                final snackBar = SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(255, 246, 93, 113),
                                  content: Text(e.toString()),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          : null,
                      child: Text('更新する'))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
