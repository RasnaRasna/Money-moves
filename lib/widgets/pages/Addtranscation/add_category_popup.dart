import 'package:flutter/material.dart';
import 'package:money_management2/db/category/category_db.dart';
import 'package:money_management2/models/category/category_model.dart';

Future<void> addPopupOnly({context, required selectedCategoryType}) async {
  final nameEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  await showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text("Add Category"),
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: nameEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter category';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Category name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                'SAVE THE DATA';
              }
              final name = nameEditingController.text;
              if (name.isEmpty) {
                return;
              }

              final category = CategoryModel(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: name,
                type: selectedCategoryType,
              );
              CategoryDB.instance.insertCategory(category);
              Navigator.of(ctx).pop();
            },
            child: const Text(
              'Add',
              style: TextStyle(
                color: Color.fromARGB(255, 5, 67, 96),
              ),
            ),
          ),
        ],
      );
    },
  );
}
