import 'package:flutter/material.dart';

class TextFormField_Note extends StatelessWidget {
  const TextFormField_Note(
      {super.key,
      required this.titleController,
      required this.hint,
      required this.lines});

  final TextEditingController titleController;
  final hint;
  final lines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(10),
      ),
      controller: titleController,
      maxLines: lines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter some Text';
        }
        return null;
      },
    );
  }
}
