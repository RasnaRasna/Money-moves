import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management2/db/transaction/transaction_db.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Allstatics extends StatelessWidget {
  const Allstatics({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueListenableBuilder(
            valueListenable: TransactionDB.instance.transactionListNotifier,
            builder:
                (BuildContext context, List<transactionModel> transactions, _) {
              double expense = 0;
              double income = 0;
              transactions.forEach((transaction) {
                if (transaction.type == CategoryType.expense) {
                  expense = expense + transaction.amount;
                } else {
                  income = income + transaction.amount;
                }
              });

              Map incomeMap = {'Name': 'income', 'Amount': income};
              Map expenseMap = {'Name': 'expense', 'Amount': expense};

              List<Map> transactionMap = [incomeMap, expenseMap];
              return TransactionDB
                      .instance.transactionListNotifier.value.isNotEmpty
                  ? SizedBox(
                      height: 600,
                      width: 400,
                      child: SfCircularChart(
                        series: <CircularSeries>[
                          DoughnutSeries<Map, String>(
                            dataSource: transactionMap,
                            xValueMapper: (Map data, _) => data['Name'],
                            yValueMapper: (Map data, _) => data['Amount'],
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          ),
                        ],
                        legend: Legend(
                          isVisible: true,
                          position: LegendPosition.bottom,
                          textStyle: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  : Center(child: Text('No data found'));
            },
          ),
        ),
      ),
    );
  }
}
