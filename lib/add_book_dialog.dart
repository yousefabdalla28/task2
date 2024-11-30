import 'package:flutter/material.dart';

class AddBookDialog extends StatefulWidget {
  final Set<String> existingNames;
  final Function(String name, String genre) onAdd;

  AddBookDialog({required this.existingNames, required this.onAdd});

  @override
  _AddBookDialogState createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedGenre;
  String? _errorMessage;

  void _validateAndAdd() {
    final name = _nameController.text.trim();
    if (name.isEmpty || _selectedGenre == null) {
      setState(() {
        _errorMessage = 'Please fill in all fields.';
      });
      return;
    }
    if (widget.existingNames.contains(name)) {
      setState(() {
        _errorMessage = 'The book name already  added.';
      });
      return;
    }
    widget.onAdd(name, _selectedGenre!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Book'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Book Name',
              errorText: _errorMessage,
            ),
          ),
          DropdownButtonFormField<String>(
            items: ['Fiction', 'Non-Fiction', 'Sci-Fi', 'Biography']
                .map((genre) => DropdownMenuItem(
              value: genre,
              child: Text(genre),
            ))
                .toList(),
            onChanged: (value) {
              _selectedGenre = value;
            },
            decoration: InputDecoration(labelText: 'Genre'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _validateAndAdd,
          child: Text('Add'),
        ),
      ],
    );
  }
}
