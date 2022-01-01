// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:notesapp/database/database.dart';

// ignore: must_be_immutable
class Edit extends StatefulWidget {
  Edit({Key? key, required this.notes, required this.db}) : super(key: key);
  Map notes;
  Database db;
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // initialising the title and description as present values
    titleController.text = widget.notes['title'];
    descriptionController.text = widget.notes['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text('Edit the Notes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              widget.db.delete(widget.notes["id"]);
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: inputDecoration("Notes Title"),
                controller: titleController,
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 10,
                style: const TextStyle(color: Colors.black),
                decoration: inputDecoration("Notes Description"),
                controller: descriptionController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.transparent,
        child: BottomAppBar(
          color: Colors.transparent,
          child: RaisedButton(
            onPressed: () {
              widget.db.update(widget.notes['id'], titleController.text,
                  descriptionController.text);
              Navigator.pop(context, true);
            },
            color: Colors.deepOrange,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.redAccent, fontSize: 20.0),
      labelText: labelText,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.black, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 2.5,
        ),
      ),
    );
  }
}
