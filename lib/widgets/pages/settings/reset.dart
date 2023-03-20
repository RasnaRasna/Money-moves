import 'package:hive/hive.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';

import '../../../db/category/category_db.dart';
import '../../../db/transaction/transaction_db.dart';

void resetAlldatas() async {
  await Hive.deleteBoxFromDisk(
      TRANSACTION_DB_NAME); // Deletes the transactionModel box from disk
  await Hive.openBox<transactionModel>(
      TRANSACTION_DB_NAME); // Reopens the transactionModel box
  await TransactionDB.instance.refresh();
  Hive.deleteBoxFromDisk(CATEGORY_DB_NAME);
  await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
  await CategoryDB.instance.refreshUI();
}
