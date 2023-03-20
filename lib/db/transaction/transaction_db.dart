import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';
import 'package:money_management2/widgets/pages/ViewAll/search_deligate.dart';
import 'package:money_management2/widgets/pages/ViewAll/view_all.dart';

// ignore: constant_identifier_names
const TRANSACTION_DB_NAME = 'transactio_db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(transactionModel obj);
  Future<List<transactionModel>> gettAllTransaction();
  Future<void> deleteTransaction(String id);
  Future<void> editTransaction(transactionModel obj);
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }
  ValueNotifier<List<transactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(transactionModel obj) async {
    final db = await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);

    await db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final list = await gettAllTransaction();
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();
    Showlist.notifyListeners();
    allList.notifyListeners();
    searchResult.notifyListeners();
  }

  @override
  Future<List<transactionModel>> gettAllTransaction() async {
    final db = await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
    return db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
    await db.delete(id);
    refresh();
  }

  @override
  Future<void> editTransaction(transactionModel obj) async {
    final db = await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
    await db.put(obj.id, obj);
    refresh();
  }
}
