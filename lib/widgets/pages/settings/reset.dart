import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management2/OnbordingScreen/splash.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';

import '../../../db/category/category_db.dart';
import '../../../db/transaction/transaction_db.dart';

// Future<void> resetAlldatas(BuildContext context) async {
//   await Hive.deleteBoxFromDisk(
//       TRANSACTION_DB_NAME); // Deletes the transactionModel box from disk
//   await Hive.openBox<transactionModel>(
//       TRANSACTION_DB_NAME); // Reopens the transactionModel box
//   await TransactionDB.instance.refresh();
//   await Hive.deleteBoxFromDisk(CATEGORY_DB_NAME);
//   await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
//   await CategoryDB.instance.refreshUI();
//   Box<Splashscreens> box = Splashscreens.getdata();
//   await box.clear();

//   Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (build) => const HomePage()),
//       (route) => false);
// }
Future<void> resetAllData(BuildContext context) async {
  try {
    // Close and delete transaction database box
    if (Hive.isBoxOpen(TRANSACTION_DB_NAME)) {
      Hive.box<transactionModel>(TRANSACTION_DB_NAME).close();
    }
    await Hive.deleteBoxFromDisk(TRANSACTION_DB_NAME);

    // Open transaction database box
    await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);

    // Refresh transaction database
    await TransactionDB.instance.refresh();

    // Close and delete category database box
    if (Hive.isBoxOpen(CATEGORY_DB_NAME)) {
      Hive.box<CategoryModel>(CATEGORY_DB_NAME).close();
    }
    await Hive.deleteBoxFromDisk(CATEGORY_DB_NAME);

    // Open category database box
    await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);

    // Refresh category database
    await CategoryDB.instance.refreshUI();

    // Clear splash screens data
    Box<Splashscreens> box = Splashscreens.getdata();
    await box.clear();

    // Navigate to home page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (build) => const HomePage()),
      (route) => false,
    );
  } catch (e) {
    print('Error resetting data: $e');
  }
}
