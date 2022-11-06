import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:time_watch_app/add_book/add_book_page.dart';
import 'package:time_watch_app/domain/book.dart';
import 'package:time_watch_app/edit_book/edit_book_page.dart';
import 'forth_page_model.dart';

//firebaseは考えずコード処理をするページ

class ForthPage extends StatelessWidget {
  ForthPage({Key? key}) : super(key: key);
  //更新をsnackbarに通知したい時に必要
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForthpageModel>(
      create: (_) => ForthpageModel()..fetchBooklist(),
      child: ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 236, 124, 5),
            title: const Text(
              'Forth',
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
            child: Consumer<ForthpageModel>(builder: (context, model, child) {
              final List<Book>? books = model.books;

              if (books == null) {
                return CircularProgressIndicator();
              }

              final List<Widget> widgets = books
                  .map(
                    (book) => Slidable(
                      child: ListTile(
                        title: Text(book.title),
                        subtitle: Text(book.author),
                      ),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            label: '編集',
                            flex: 1,
                            onPressed: (BuildContext context) async {
                              final bool? added = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditBookPage(book),
                                  //編集画面でタイトルと著者を最初から残したいから引数book
                                ),
                              );
                              if (added != null && added) {
                                final snackBar = SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(255, 93, 246, 111),
                                  content: Text('本を更新しました'),
                                );
                                _scaffoldKey.currentState
                                    ?.showSnackBar(snackBar);
                              }
                            },
                            backgroundColor: Color.fromARGB(255, 126, 126, 126),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                          ),
                          SlidableAction(
                            label: '削除',
                            onPressed: (BuildContext context) async {
                              await showMyDialog(context, book, model);
                            },
                            backgroundColor: Color.fromARGB(255, 211, 63, 63),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList();
              return ListView(
                children: widgets,
              );
            }),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );
              if (added != null && added) {
                final snackBar = SnackBar(
                  backgroundColor: Color.fromARGB(255, 93, 246, 111),
                  content: Text('本を追加しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Future<void> showMyDialog(
    BuildContext context,
    Book book,
    ForthpageModel model,
  ) async {
    return showDialog<void>(
      // `showDialog`メソッドでダイアログを呼び出す!
      context: context, //必須の引数 ここでエラー出たら_showMyDialogの引数をいれる
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        //必須の引数
        return AlertDialog(
          //`showDialog`メソッドの必須の引数であるbuilder:の戻り値としてAlertDialog()を返す！
          title: const Text('削除の確認'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("『${book.title}』を削除しますか?"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('いいえ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('はい'),
              onPressed: () async {
                await model.delete(book);
                Navigator.of(context).pop();
                final snackBar = SnackBar(
                  backgroundColor: Color.fromARGB(255, 246, 93, 93),
                  content: Text('『${book.title}』を削除しました'),
                );
                _scaffoldKey.currentState?.showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }
}
