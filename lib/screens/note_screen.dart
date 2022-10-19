import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqfliteapp/model/note_model.dart';
import 'package:sqfliteapp/sql_helper.dart';

class NoteScreen extends StatelessWidget {
  final Note? note;

  const NoteScreen({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    if (note != null) {
      titleController.text = note!.title;
      descriptionController.text = note!.description;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add a note' : 'Edit note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Center(
                  child: Text("Note it..",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: TextFormField(
                  controller: titleController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      hintText: 'Title',
                      labelText: 'Note title',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.75),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )))),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  hintText: 'Type here the notes',
                  labelText: 'Note description',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.75),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ))),
              keyboardType: TextInputType.multiline,
              onChanged: (value) {},
              maxLength: 50,
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final title = titleController.value.text;
                      final description = descriptionController.value.text;
                      if (title.isEmpty || description.isEmpty) {
                        return null;
                      }
                      final Note model = Note(
                          title: title, description: description, id: note?.id);

                      if (note == null) {
                        await DatabaseHelper.addNote(model);
                      } else {
                        await DatabaseHelper.updateNote(model);
                      }

                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: .75),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                    child: Text(
                      note == null ? 'Save' : 'Edit',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
