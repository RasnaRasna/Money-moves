// import 'package:money_management2/models/category/category_model.dart';
// import 'package:money_management2/models/transactions/transaction_model.dart';

// import '../../../db/transaction/transaction_db.dart';

// Map<String, double> calculateTotals(List<transactionModel> transactions) {
//   TransactionDB.instance.transactionListNotifier.notifyListeners();
//   double totalIncome = 0;
//   double totalExpense = 0;
//   for (var transaction in transactions) {
//     if (transaction.type == CategoryType.income) {
//       totalIncome += transaction.amount;
//     } else {
//       totalExpense += transaction.amount;
//     }
//   }
//   double totalBalance = totalIncome - totalExpense;
//   return {
//     'totalIncome': totalIncome,
//     'totalExpense': totalExpense,
//     'totalBalance': totalBalance,
//   };
// }



// import '../../../db/transaction/transaction_db.dart';
// import '../../../models/category/category_model.dart';
// import '../../../models/transactions/transaction_model.dart';

// double totalbalance = 0;
// double totalincome = 0;
// double totalexpense = 0;

// calcuLations(Widget returned) {
//   ValueListenableBuilder(
//       valueListenable: TransactionDB.instance.transactionListNotifier,
//       builder: (context, List<transactionModel> value, _) {
//         for (var element
//             in TransactionDB.instance.transactionListNotifier.value) {
//           if (element.type == CategoryType.income) {
//             totalincome = (totalincome + element.amount);
//           } else {
//             totalexpense = (totalexpense + element.amount);
//           }
//           totalbalance = totalincome - totalexpense;
//         }
//         return returned;
//       });
// }
//  Widget build(BuildContext context) {
//     overViewListNotifier.value =
//         TransactionDB.instance.transactionListNotifier.value;
//     List<transactionModel> transactions =
//         TransactionDB.instance.transactionListNotifier.value;
//     Map<String, double> totals = calculateTotals(transactions);
//     double totalIncome = totals['totalIncome']!;
//     double totalExpense = totals['totalExpense']!;
//     double totalBalance = totals['totalBalance']!;