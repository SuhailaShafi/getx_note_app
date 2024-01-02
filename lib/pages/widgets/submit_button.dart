import 'package:flutter/material.dart';
import 'package:getx_hive_project/controller/notes_controller.dart';
import 'package:getx_hive_project/models/notes.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.index,
    required this.formkey,
    required this.titleController,
    required this.noteController,
    required this.controller,
  });

  final GlobalKey<FormState> formkey;
  final TextEditingController titleController;
  final TextEditingController noteController;
  final NotesController controller;
  final index;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        bool? isValidated = formkey.currentState?.validate();
        if (isValidated == true) {
          String titleText = titleController.text;
          String noteText = noteController.text;
          if (index != null) {
            controller.updateNote(
              index: index,
              note: Note(
                title: titleText,
                note: noteText,
              ),
            );
          } else {
            controller.createNote(
              note: Note(
                title: titleText,
                note: noteText,
              ),
            );
          }
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Enter valid values"),
          ),
        );
      },
      child: const Text(
        'Submit',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.indigo, // Change the button color
      ),
    );
  }
}
