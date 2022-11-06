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
                            label: '編集',
                          ),
                          SlidableAction(
                            onPressed: null,
                            backgroundColor: Color.fromARGB(255, 211, 63, 63),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: '削除',
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
}
