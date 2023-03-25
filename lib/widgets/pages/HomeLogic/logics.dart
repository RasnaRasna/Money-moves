// import 'package:flutter/material.dart';
// import 'package:money_management2/db/transaction/transaction_db.dart';
// import 'package:money_management2/models/category/category_model.dart';

// import '../../../models/transactions/transaction_model.dart';

// void totalbalance() {
//   ValueListenableBuilder(
//       valueListenable: TransactionDB.instance.transactionListNotifier,
//       builder: (context, List<transactionModel> value, _) {
//         double? totalbalance = 0;
//         double? totalincome = 0;
//         double? totalexpense = 0;
//         for (var element
//             in TransactionDB.instance.transactionListNotifier.value) {
//           if (element.type == CategoryType.income) {
//             totalincome = (totalincome! + element.amount);
//           } else {
//             totalexpense = (totalexpense! + element.amount);
//           }
//           totalbalance = totalincome! - totalexpense!;
//         }
//         return Text('');
//       });
// }



     
  // overViewListNotifier.value =
  //       TransactionDB.instance.transactionListNotifier.value;
  //   return ValueListenableBuilder(
  //     valueListenable: TransactionDB.instance.transactionListNotifier,
  //     builder: (context, List<transactionModel> value, _) {
  //       double? totalbalance = 0;
  //       double? totalincome = 0;
  //       double? totalexpense = 0;
  //       for (var element
  //           in TransactionDB.instance.transactionListNotifier.value) {
  //         if (element.type == CategoryType.income) {
  //           totalincome = (totalincome! + element.amount);
  //         } else {
  //           totalexpense = (totalexpense! + element.amount);
  //         }
  //         totalbalance = totalincome! - totalexpense!;
  //       }

