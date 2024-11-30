import 'package:flutter/material.dart';
import 'details_page.dart';
import 'add_book_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> books = [];
  final Set<String> bookNames = {};

  void _addBook(String name, String genre) {
    setState(() {
      books.add({'name': name, 'genre': genre});
      bookNames.add(name);
    });
  }

  void _removeBook(int index) {
    setState(() {
      bookNames.remove(books[index]['name']);
      books.removeAt(index);
    });
  }

  void _navigateToDetails(Map<String, String> book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library Management (${books.length} books)'),
      ),
      body: books.isEmpty
          ? Center(child: Text('No books added yet!'))
          : ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book['name']!),
            subtitle: Text(book['genre']!),
            onTap: () => _navigateToDetails(book),
            onLongPress: () => _removeBook(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddBookDialog(
              existingNames: bookNames,
              onAdd: _addBook,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
