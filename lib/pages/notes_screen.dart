import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_hive_project/controller/notes_controller.dart';
import 'package:getx_hive_project/pages/widgets/add_note_dialogbox.dart';
import '../models/notes.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final controller = Get.put(NotesController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NOTEAPP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo, // Change the app bar color
      ),
      body: GetBuilder<NotesController>(
        builder: (cont) => ListView.builder(
          itemBuilder: (context, index) {
            if (cont.notesCount > 0) {
              Note? note = cont.observableBox.getAt(index);
              return Card(
                elevation: 4, // Add elevation for a card-like effect
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    note?.title ?? "N/A",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(note?.note ?? "Blank"),
                  leading: IconButton(
                    onPressed: () {
                      return addEditNote(index: index, note: note);
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.blue, // Change the edit icon color
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      return controller.deleteNote(index: index);
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red, // Change the delete icon color
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('List is Empty'),
              );
            }
          },
          itemCount: cont.notesCount,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addEditNote(),
        child: const Icon(Icons.add),
        backgroundColor: Colors.indigo, // Change the FAB background color
      ),
    );
  }

  addEditNote({int? index, Note? note}) {
    showDialog(
      context: context,
      builder: (context) {
        if (note != null) {
          titleController.text = note.title.toString();
          noteController.text = note.note.toString();
        } else {
          titleController.clear();
          noteController.clear();
        }
        return dialogBoxNote(
            index: index,
            formkey: formkey,
            titleController: titleController,
            noteController: noteController,
            controller: controller);
      },
    );
  }
}
