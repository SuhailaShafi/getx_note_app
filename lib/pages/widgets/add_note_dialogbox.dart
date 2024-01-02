import 'package:flutter/material.dart';
import 'package:getx_hive_project/controller/notes_controller.dart';
import 'package:getx_hive_project/pages/widgets/submit_button.dart';
import 'package:getx_hive_project/pages/widgets/textfield.dart';

class dialogBoxNote extends StatelessWidget {
  const dialogBoxNote(
      {super.key,
      required this.formkey,
      required this.titleController,
      required this.noteController,
      required this.controller,
      required this.index});

  final GlobalKey<FormState> formkey;
  final TextEditingController titleController;
  final TextEditingController noteController;
  final NotesController controller;
  final index;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: ListView(
            children: [
              TextFormField_Note(
                titleController: titleController,
                hint: "Title",
                lines: 1,
              ),
              const SizedBox(height: 20),
              TextFormField_Note(
                titleController: noteController,
                hint: "Note",
                lines: 5,
              ),
              const SizedBox(height: 20),
              SubmitButton(
                  index: index,
                  formkey: formkey,
                  titleController: titleController,
                  noteController: noteController,
                  controller: controller)
            ],
          ),
        ),
      ),
    );
  }
}
