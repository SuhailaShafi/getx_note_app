import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive_project/controller/notes_controller.dart';
import 'package:getx_hive_project/models/notes.dart';

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
        title: const Text('CRUD with hive'),
      ),
      body: GetBuilder<NotesController>(
          builder: (cont) => ListView.builder(
                itemBuilder: (context, index) {
                  if (cont.notesCount > 0) {
                    Note? note = cont.observableBox.getAt(index);
                    return Card(
                      child: ListTile(
                        title: Text(note?.title ?? "N/A"),
                        subtitle: Text(note?.note ?? "Blank"),
                        leading: IconButton(
                            onPressed: () {
                              return addEditNote(index: index, note: note);
                            },
                            icon: Icon(Icons.edit)),
                        /* trailing: IconButton(
                            onPressed: () {
                              return deleteNote();
                            },
                            icon: Icon(Icons.delete)),*/
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('List is Empty'),
                    );
                  }
                },
                itemCount: cont.notesCount,
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addEditNote(),
        child: const Icon(Icons.add),
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
          return Material(
            child: Form(
                key: formkey,
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: ListView(children: [
                    TextFormField_Note(
                        titleController: titleController, hint: "Title"),
                    const SizedBox(height: 20),
                    TextFormField_Note(
                        titleController: noteController, hint: "Note"),
                    SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: () {
                          bool? isValidated = formkey.currentState?.validate();
                          if (isValidated == true) {
                            String titleText = titleController.text;
                            String noteText = noteController.text;
                            if (index != null) {
                              controller.updateNote(
                                  index: index,
                                  note: Note(title: titleText, note: noteText));
                            } else {
                              controller.createNote(
                                  note: Note(title: titleText, note: noteText));
                            }
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Enter valid values")));
                        },
                        child: const Text('Submit'))
                  ]),
                )),
          );
        });
  }
}

class TextFormField_Note extends StatelessWidget {
  const TextFormField_Note({
    super.key,
    required this.titleController,
    required this.hint,
  });

  final TextEditingController titleController;
  final hint;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hint),
      controller: titleController,
      maxLines: 5,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter some Text';
        }
        return null;
      },
    );
  }
}
