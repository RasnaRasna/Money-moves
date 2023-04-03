import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';
import 'package:money_management2/widgets/pages/ViewAll/viewslide.dart';
import 'package:money_management2/widgets/pages/search/search_root.dart';

import '../../../db/transaction/transaction_db.dart';

ValueNotifier<List<transactionModel>> allList = ValueNotifier([]);
ValueNotifier<List<transactionModel>> Showlist = ValueNotifier([]);
ValueNotifier<String> transactiontype = ValueNotifier('All Transactions');
ValueNotifier<List<transactionModel>> alltransaction = ValueNotifier([]);
ValueNotifier<List<transactionModel>> listtodisplay =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class ViewAll extends StatefulWidget {
  const ViewAll({super.key});

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  List<String> alltransaction = [
    'All Transactions',
    'Income',
    'Expense',
  ];
  DateTime? _startDate; // store the selected start date
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: IconButton(
            color: Colors.black,
            onPressed: () async {
              allList.value = await TransactionDB.instance.gettAllTransaction();

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CustomSearch(),
                ),
              );
            },
            icon: const Icon(Icons.search),
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
                      primaryColor: const Color.fromARGB(255, 19, 81, 112));
                },
                icon: const Icon(Icons.calendar_month)),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: transactiontype,
                      //  without selecting date
                      builder: (context, value, _) {
                        if (_startDate == null || _endDate == null) {
                          if (transactiontype.value == alltransaction[0]) {
                            Showlist.value = listtodisplay.value;
                          } else if (transactiontype.value ==
                              alltransaction[1]) {
                            Showlist.value = listtodisplay.value
                                .where((element) =>
                                    element.type == CategoryType.income)
                                .toList();
                          } else {
                            Showlist.value = listtodisplay.value
                                .where((element) =>
                                    element.type == CategoryType.expense)
                                .toList();
                          }

                          //stratdate and end date is not null
                          //and include all dys
                        } else {
                          if (transactiontype.value == alltransaction[0]) {
                            Showlist.value = listtodisplay.value
                                .where((element) =>
                                    element.date.isBefore(_endDate!
                                        .add(const Duration(days: 1))) &&
                                    element.date.isAfter(_startDate!
                                        .subtract(const Duration(days: 1))))
                                .toList();
                          } else if (transactiontype.value ==
                              alltransaction[1]) {
                            Showlist.value = listtodisplay.value
                                .where((element) =>
                                    element.type == CategoryType.income)
                                .where((element) =>
                                    element.date.isBefore(_endDate!
                                        .add(const Duration(days: 1))) &&
                                    element.date.isAfter(_startDate!
                                        .subtract(const Duration(days: 1))))
                                .toList();
                          } else {
                            Showlist.value = listtodisplay.value
                                .where((element) =>
                                    element.type == CategoryType.expense)
                                .where((element) =>
                                    element.date.isBefore(_endDate!
                                        .add(const Duration(days: 1))) &&
                                    element.date.isAfter(_startDate!
                                        .subtract(const Duration(days: 1))))
                                .toList();
                          }
                        }
                        // return Container(child: TransactonTiles());

                        if (Showlist.value.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: SizedBox(
                              height: 200,
                              width: 250,
                              child: Image.asset(
                                'lib/assets/images/output-onlinegiftools (2).gif',
                              ),
                            ),
                          );
                        } else {
                          return ValueListenableBuilder(
                            valueListenable: Showlist,
                            builder: (context, transactionList, _) {
                              return viewallTransactionList(
                                  context, transactionList);
                            },
                          );
                        }
                      }))
            ],
          ),
        ));
  }
}

String parseDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}
