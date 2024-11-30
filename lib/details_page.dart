import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, String> book;

  DetailsPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['name']!),
      ),
      body: Center(
        child: Column(
          children: [
            Text(book['name']!,style: TextStyle(fontSize: 36)),
            Text('Genre: ${book['genre']}',style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
