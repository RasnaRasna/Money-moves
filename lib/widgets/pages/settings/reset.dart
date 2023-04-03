import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management2/OnbordingScreen/splash.dart';
import 'package:money_management2/db/transaction/transaction_db.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';

Future<void> resetAllData(BuildContext context) async {
  // final shared = await Hive.openBox<Splashscreens>("Splashscreens");
  // shared.clear();

  if (Splashscreens.getdata().isEmpty) {
  } else {
    await Splashscreens.getdata().clear();
  }

  final categoryDB = await Hive.openBox<CategoryModel>('category-database');

  categoryDB.clear();

  final TransactionDB =
      await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
  TransactionDB.clear();

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const HomePage(),
    ),
  );
}
