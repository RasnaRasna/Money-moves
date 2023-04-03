import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:money_management2/db/transaction/transaction_db.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpenseStatics extends StatelessWidget {
  CategoryType incomeOrExpense;
  ExpenseStatics({required this.incomeOrExpense, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<transactionModel>>(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder:
            (BuildContext context, List<transactionModel> incomeorexpense, _) {
          var allExpenseOrincome = incomeorexpense
              .where((element) => element.type == incomeOrExpense)
              .toList();
          var groupedExpensorIncome = groupBy<transactionModel, String>(
            allExpenseOrincome,
            (expenseorIncome) => expenseorIncome.category.name,
          );
          var data = groupedExpensorIncome.entries
              .map((e) => MapEntry<String, double>(
                  e.key,
                  e.value.fold(
                      0,
                      (total, expenseOrIncome) =>
                          total + expenseOrIncome.amount)))
              .toList();
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 10, 92, 130),
                          Color.fromARGB(255, 221, 210, 210),
                          Color.fromRGBO(206, 216, 223, 1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: data.isNotEmpty
                        ? SfCircularChart(
                            series: <CircularSeries>[
                              DoughnutSeries(
                                  dataSource: data,
                                  xValueMapper: (entry, _) => entry.key,
                                  yValueMapper: (entry, _) => entry.value,
                                  dataLabelSettings:
                                      const DataLabelSettings(isVisible: true)),
                            ],
                            legend: Legend(
                                isVisible: true,
                                // position: LegendPosition.left,
                                textStyle: const TextStyle(fontSize: 20)),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'lib/assets/images/output-onlinegiftools (2).gif',
                                  width: 200,
                                  height: 200,
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
