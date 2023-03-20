import 'dart:developer';

import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';
import 'package:money_management2/widgets/pages/ViewAll/search_deligate.dart';
import 'package:money_management2/widgets/pages/ViewAll/transactionn.dart';

import '../../../db/transaction/transaction_db.dart';
import '../UpdateTransaction/update_transaction.dart';

ValueNotifier<List<transactionModel>> allList = ValueNotifier([]);
ValueNotifier<List<transactionModel>> Showlist = ValueNotifier([]);

class ViewAll extends StatefulWidget {
  const ViewAll({super.key});

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  List<String> alltransaction = ['All Transactions', 'Income', 'Expense'];
  ValueNotifier<String> transactiontype = ValueNotifier('All Transactions');
  DateTime? _startDate; // store the selected start date
  DateTime? _endDate;

  List<transactionModel> listtodisplay =
      TransactionDB.instance.transactionListNotifier.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.black,
            onPressed: () async {
              allList.value = await TransactionDB.instance.gettAllTransaction();
              log("${allList.value.length}");
              showSearch(context: context, delegate: CustomSearch());
            },
            icon: const Icon(Icons.search),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            'search',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showCustomDateRangePicker(context,
                      dismissible: true,
                      minimumDate: DateTime(2010),
                      maximumDate: DateTime.now(),
                      startDate: _startDate,
                      endDate: _endDate, onApplyClick: (strat, end) {
                    setState(() {
                      _endDate = end;
                      _startDate = strat;
                    });
                  }, onCancelClick: (() {
                    setState(() {
                      _endDate = null;
                      _startDate = null;
                    });
                  }),
                      backgroundColor: Colors.white,
                      primaryColor: Color.fromARGB(255, 19, 81, 112));
                },
                icon: Icon(Icons.calendar_month)),
            // show date range picker

            Row(
              children: [
                DropdownButton(
                  value: transactiontype.value,
                  items: alltransaction.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      transactiontype.value = newValue!;
                      transactiontype.notifyListeners();
                    });
                  },
                )
              ],
            )
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                  Color.fromARGB(255, 10, 92, 130),
                  Color.fromARGB(255, 221, 210, 210),
                  Color.fromARGB(255, 10, 92, 130),
                ])),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: transactiontype,
                      builder: (context, value, _) {
                        if (_startDate == null || _endDate == null) {
                          if (transactiontype.value == alltransaction[0]) {
                            Showlist.value = listtodisplay;
                          } else if (transactiontype.value ==
                              alltransaction[1]) {
                            Showlist.value = listtodisplay
                                .where((element) =>
                                    element.type == CategoryType.income)
                                .toList();
                          } else {
                            Showlist.value = listtodisplay
                                .where((element) =>
                                    element.type == CategoryType.expense)
                                .toList();
                          }
                        } else {
                          if (transactiontype.value == alltransaction[0]) {
                            Showlist.value = listtodisplay
                                .where((element) =>
                                    element.date.isBefore(
                                        _endDate!.add(Duration(days: 1))) &&
                                    element.date.isAfter(_startDate!
                                        .subtract(Duration(days: 1))))
                                .toList();
                          } else if (transactiontype.value ==
                              alltransaction[1]) {
                            Showlist.value = listtodisplay
                                .where((element) =>
                                    element.type == CategoryType.income)
                                .where((element) =>
                                    element.date.isBefore(
                                        _endDate!.add(Duration(days: 1))) &&
                                    element.date.isAfter(_startDate!
                                        .subtract(Duration(days: 1))))
                                .toList();
                          } else {
                            Showlist.value = listtodisplay
                                .where((element) =>
                                    element.type == CategoryType.expense)
                                .where((element) =>
                                    element.date.isBefore(
                                        _endDate!.add(Duration(days: 1))) &&
                                    element.date.isAfter(_startDate!
                                        .subtract(Duration(days: 1))))
                                .toList();
                          }
                        }
                        // return Container(child: TransactonTiles());
                        return ValueListenableBuilder(
                            valueListenable: Showlist,
                            builder: ((context,
                                List<transactionModel> transation, _) {
                              return ListView.separated(
                                  itemBuilder: ((context, index) {
                                    //values
                                    final value = transation[index];

                                    return Card(
                                      color: Colors.white,
                                      elevation: 30,
                                      child: Slidable(
                                        key: Key(value.id!),
                                        endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                onPressed: (context) {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (ctx) => AlertDialog(
                                                                title:
                                                                    const Text(
                                                                  'alert',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                                content: const Text(
                                                                    'Do you want to delete '),
                                                                actions: [
                                                                  Row(
                                                                    children: [
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            TransactionDB.instance.deleteTransaction(value.id!);
                                                                            Navigator.of(ctx).pop();
                                                                          },
                                                                          child:
                                                                              const Text('Yes')),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(ctx).pop();
                                                                          },
                                                                          child:
                                                                              const Text('No'))
                                                                    ],
                                                                  ),
                                                                ],
                                                              ));
                                                },
                                                backgroundColor: Colors.white,
                                                icon: Icons.delete,
                                                foregroundColor: Colors.red,
                                              ),
                                              SlidableAction(
                                                onPressed: (context) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              EditTransaction(
                                                                id: value.id,
                                                                amount: value
                                                                    .amount,
                                                                pupose: value
                                                                    .purpose,
                                                                date:
                                                                    value.date,
                                                                type:
                                                                    value.type,
                                                                category: value
                                                                    .category,
                                                              )));
                                                },
                                                backgroundColor: Colors.white,
                                                icon: Icons.edit,
                                                foregroundColor: Colors.blue,
                                              )
                                            ]),
                                        child: ListTile(
                                          leading: Text(parseDate(value.date)),
                                          title: Text(value.category.name),
                                          subtitle: Text(value.purpose),
                                          trailing: RichText(
                                            text: TextSpan(
                                              text: value.category.type ==
                                                      CategoryType.income
                                                  ? "+ "
                                                  : "- ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: value.category.type ==
                                                        CategoryType.income
                                                    ? Color.fromARGB(
                                                        255, 32, 115, 34)
                                                    : Colors.red,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: "${value.amount}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: value.category
                                                                .type ==
                                                            CategoryType.income
                                                        ? Color.fromARGB(
                                                            255, 32, 115, 34)
                                                        : Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  separatorBuilder: ((context, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  }),
                                  itemCount: transation.length);
                            }));
                      }))
            ],
          ),
        ));
  }
}

String parseDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}
