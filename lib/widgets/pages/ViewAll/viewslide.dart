import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management2/db/transaction/transaction_db.dart';
import 'package:money_management2/widgets/pages/ViewAll/view_all.dart';

import '../../../models/category/category_model.dart';
import '../../../models/transactions/transaction_model.dart';
import '../UpdateTransaction/update_transaction.dart';

Widget viewallTransactionList(
    BuildContext context, List<transactionModel> transactions) {
  return ListView.separated(
    itemBuilder: ((context, index) {
      //values
      final value = transactions[index];

      return Card(
          color: Colors.white,
          elevation: 30,
          child: Slidable(
            key: Key(value.id!),
            endActionPane: ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text(
                              'alert',
                              style: TextStyle(fontSize: 15, color: Colors.red),
                            ),
                            content: const Text('Do you want to delete '),
                            actions: [
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Showlist.value.removeAt(index);
                                        TransactionDB.instance
                                            .deleteTransaction(value.id!);
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text('No'))
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => EditTransaction(
                            id: value.id,
                            amount: value.amount,
                            pupose: value.purpose,
                            date: value.date,
                            type: value.type,
                            category: value.category,
                          )));
                },
                backgroundColor: Colors.white,
                icon: Icons.edit,
                foregroundColor: const Color.fromARGB(255, 5, 67, 96),
              )
            ]),
            child: ListTile(
              leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 10, 92, 130),
                  maxRadius: 40.0,
                  child: Text(
                    parseDate(value.date),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      wordSpacing: 1.0,
                    ),
                  )),
              title: Text(value.category.name),
              subtitle: Text(value.purpose),
              trailing: RichText(
                text: TextSpan(
                  text:
                      value.category.type == CategoryType.income ? "+ " : "- ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: value.category.type == CategoryType.income
                        ? const Color.fromARGB(255, 32, 115, 34)
                        : Colors.red,
                  ),
                  children: [
                    TextSpan(
                      text: "₹  ${value.amount}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: value.category.type == CategoryType.income
                            ? const Color.fromARGB(255, 32, 115, 34)
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    }),
    separatorBuilder: (context, index) => const SizedBox(height: 10),
    itemCount: transactions.length,
  );
}

String parseDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}
