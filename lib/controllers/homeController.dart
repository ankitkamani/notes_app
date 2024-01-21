import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/modal/notesModal.dart';

class HomeController extends GetxController {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  //Read Using Reference
  DatabaseReference firebaseRef = FirebaseDatabase.instance.ref('Notes');

  //insert
  addNotes(NotesModal notesModal) {
    DatabaseReference firebaseRef = FirebaseDatabase.instance.ref('Notes');
    firebaseRef.child("${notesModal.id}").set({
      "id": notesModal.id,
      "title": notesModal.title,
      "description": notesModal.description
    }).then((value) {
      Get.back();
      titleController.clear();
      descriptionController.clear();
      update();
    });
  }

  //update
  updateNotes(NotesModal notesModal,int id) {
    firebaseRef.child("$id").update({
      "id": notesModal.id,
      "title": notesModal.title,
      "description": notesModal.description
    }).then((value) {
      Get.back();
      titleController.clear();
      descriptionController.clear();
      update();
    });
  }

  //delete
  deleteNotes(NotesModal notesModal) {
    firebaseRef.child("${notesModal.id}").remove().then((value) {
      Get.snackbar('Notes', "Notes Deleted SuccessFully",
          snackPosition: SnackPosition.BOTTOM);
    });
  }
}
