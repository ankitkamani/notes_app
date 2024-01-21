import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/LikedNotesController.dart';

import '../helper/sqlHelper.dart';

class LikedNotesScreen extends StatefulWidget {
  const LikedNotesScreen({super.key});

  @override
  State<LikedNotesScreen> createState() => _LikedNotesScreenState();
}

class _LikedNotesScreenState extends State<LikedNotesScreen> {

  static List<Map<String, dynamic>> Notes = [];

  void _refreshNotes() async {
    final data = await SQLHelper.getItems();
    setState(() {
      Notes = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    Get.snackbar('Liked Note', 'Successfully deleted Liked Note.',
        snackPosition: SnackPosition.BOTTOM);
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade200,
        title: const Text('Liked Notes'),
      ),
      body: Notes.isEmpty?const Center(child: Text('Not Found...')):ListView.builder(
        itemCount: Notes.length,
        itemBuilder: (context, index) => Card(
          color: Colors.orange.shade100,
          margin: const EdgeInsets.all(15).copyWith(bottom: 0),
          child: ListTile(
              title: Text(Notes[index]['title']),
              subtitle: Text(Notes[index]['description']),
              trailing: InkWell(
                  onTap: () {
                    _deleteItem(int.parse(Notes[index]['id']));
                  },
                  child: const Icon(Icons.delete))),
        ),
      ),
    );
  }
}
