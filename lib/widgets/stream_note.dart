import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/widgets/task_widgets.dart';

import '../data/firestor.dart';

class Stream_note extends StatelessWidget {
  bool done;
  Stream_note(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore_Datasource().stream(done),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final noteslist = Firestore_Datasource().getNotes(snapshot);
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final note = noteslist[index];
              return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    Firestore_Datasource().delet_note(note.id);
                  },
                  child: Task_Widget(note));
            },
            itemCount: noteslist.length,
          );
        });
  }
}
