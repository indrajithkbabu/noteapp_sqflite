import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqfliteapp/model/note_model.dart';
import 'package:sqfliteapp/screens/note_screen.dart';
import 'package:sqfliteapp/sql_helper.dart';
import 'package:sqfliteapp/widgets/note_widgets.dart';

class NoteScreenList extends StatefulWidget {
  const NoteScreenList({Key? key}) : super(key: key);

  @override
  State<NoteScreenList> createState() => _NoteScreenListState();
}

class _NoteScreenListState extends State<NoteScreenList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: ((context) => NoteScreen())));
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Note>?>(
        future: DatabaseHelper.getAllNote(),
        builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ListView.builder(
                itemBuilder: (context, index) => NoteWidget(
                    note: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteScreen(
                              note: snapshot.data![index],
                            ),
                          )
                          );
                      setState(() {});
                    },
                    onLongpress: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                'Are you sure you want to delete this note?'),
                            actions: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)
                                              ),
                                  onPressed: () async {
                                    await DatabaseHelper.deleteNote(
                                        snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: Text("Yes")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('No'))
                            ],
                          );
                        },
                      );
                    }
                    ),
                itemCount: snapshot.data!.length,
              );
            }
            return Center(
              child: Text('No notes yet!'),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
