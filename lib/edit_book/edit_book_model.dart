import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_watch_app/domain/book.dart';

//firebaseの値をとってくるページ

class EditBookModel extends ChangeNotifier {
  //create: (_) => EditBookModel(book)の引数bookをいれるための2行
  final Book book;
  EditBookModel(this.book) {
    title_controller.text = book.title;
    author_controller.text = book.author;
  }
  //編集画面でタイトルと著者を最初から残す
  final title_controller = TextEditingController();
  final author_controller = TextEditingController();

  String? title;
  String? author;

//編集画面で更新ボタンを活性化させるためのset
  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setAuthor(String author) {
    this.author = author;
    notifyListeners();
  }

  //更新がなければボタン押せない
  bool isUpdated() {
    return title != null || author != null;
  }

  Future updateBook() async {
    title = title_controller.text;
    author = author_controller.text;

    if (title == null || title == "") {
      throw '本のタイトルが入っていません';
    }

    if (author == null || author!.isEmpty) {
      throw '本の著者が入っていません';
    }

    //firestoreに追加
    await FirebaseFirestore.instance.collection('books').doc(book.id).update({
      'title': title, // John Doe
      'author': author, // Stokes and Sons
    });
  }
}
