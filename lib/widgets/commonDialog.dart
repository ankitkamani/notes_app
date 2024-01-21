import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/homeController.dart';

Future commonDialog(
    String title, String buttonTitle, HomeController c, Function click) {
  return Get.defaultDialog(
      cancel: ElevatedButton(
          onPressed: () {
            Get.back();
            c.titleController.clear();
            c.descriptionController.clear();
          },
          child: const Text('Cancel')),
      confirm: OutlinedButton(
        onPressed: () {
          click.call();
        },
        child: Text(buttonTitle),
      ),
      barrierDismissible: false,
      title: title,
      content: Container(
        padding: const EdgeInsets.only(
          top: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: c.titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: c.descriptionController,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ));
}

Future commonDeleteDialog(
    String title, String buttonTitle, Function click) {
  return Get.defaultDialog(
    cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('No')),
    confirm: OutlinedButton(
      onPressed: () {
        click.call();
        Get.back();
      },
      child: Text(buttonTitle),
    ),
    content: Text(title),
    barrierDismissible: false,
    title: 'Delete?',
  );
}
