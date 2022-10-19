

import 'package:flutter/material.dart';
import 'package:sqfliteapp/model/note_model.dart';

class NoteWidget extends StatelessWidget {
 
 final Note note;
 final VoidCallback onTap;
 final VoidCallback onLongpress;

  const NoteWidget({super.key, required this.note, required this.onTap, required this.onLongpress});
 
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongpress,
      onTap: onTap,
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 24,vertical: 6),
      child: Card(
        elevation: 2,
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(note.title,
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 6,horizontal: 12),
            child: Divider(
              thickness: 1,
            ),
            ),
            Text(note.description,
            style: TextStyle(
              fontSize: 12,fontWeight: FontWeight.w400
            ),
            )
          ],
        ),),
      ),
      
      
      ),
    );
  }
}