import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//firebaseの値をとってくるページ

class AddBookModel extends ChangeNotifier {
  String? title;
  String? author;

  Future addBook() async {
    if (title == null || title == "") {
      throw '本のタイトルが入っていません';
    }

    if (author == null || author!.isEmpty) {
      throw '本の著者が入っていません';
    }
    //firestoreに追加
    await FirebaseFirestore.instance.collection('books').add({
      'title': title, // John Doe
      'author': author, // Stokes and Sons
    });
  }
}
