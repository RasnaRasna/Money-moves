// import 'package:flutter/material.dart';
// import 'package:money_management2/db/transaction/transaction_db.dart';
// import 'package:money_management2/models/transactions/transaction_model.dart';

// class DateRange extends StatefulWidget {
//   const DateRange({super.key});

//   @override
//   State<DateRange> createState() => _DateRangeState();
// }

// class _DateRangeState extends State<DateRange> {
//   DateTime? _startDate; // store the selected start date
//   DateTime? _endDate; // store the selected end date
//   ValueNotifier<List<transactionModel>> allList = ValueNotifier([]);
//   Future<void> _filterTransactions() async {
//     // get all transactions
//     final allTransactions = await TransactionDB.instance.gettAllTransaction();

//     // if start date or end date is null, return all transactions
//     if (_startDate == null || _endDate == null) {
//       allList.value = allTransactions;
//       return;
//     }

//     // filter transactions based on the selected date range
//     final filteredTransactions = allTransactions.where((transaction) {
//       final transactionDate = transaction.date.toLocal();
//       return transactionDate
//               .isAfter(_startDate!.subtract(const Duration(days: 1))) &&
//           transactionDate.isBefore(_endDate!.add(const Duration(days: 1)));
//     }).toList();

//     allList.value = filteredTransactions;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           color: Colors.black,
//           onPressed: () async {
//             // show date range picker
//             final pickedDateRange = await showDateRangePicker(
//               context: context,
//               firstDate: DateTime(2021),
//               lastDate: DateTime.now(),
//               initialDateRange: _startDate != null && _endDate != null
//                   ? DateTimeRange(start: _startDate!, end: _endDate!)
//                   : null,
//             );

//             // update start and end date
//             if (pickedDateRange != null) {
//               _startDate = pickedDateRange.start;
//               _endDate = pickedDateRange.end;
//             }

//             // filter transactions based on the selected date range
//             await _filterTransactions();

//             // show search
//           },
//           icon: const Icon(Icons.fingerprint),
//         ),
//         // ...
//       ),
//       // ...
//     );
//   }
// }
