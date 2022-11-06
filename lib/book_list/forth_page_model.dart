import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_watch_app/domain/book.dart';

//firebaseの値をとってくるページ
class ForthpageModel extends ChangeNotifier {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('books').snapshots();

  List<Book>? books;

  void fetchBooklist() {
    _usersStream.listen((QuerySnapshot snapshot) {
      final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        final String id = document.id; //idはランダムに割り振っているのでこれが必要
        final String title = data['title'];
        final String author = data['author'];
        return Book(id, title, author);
      }).toList();

      this.books = books;
      notifyListeners();
    });
  }
}
