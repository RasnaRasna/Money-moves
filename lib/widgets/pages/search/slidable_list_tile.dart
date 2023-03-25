import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_management2/db/transaction/transaction_db.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';
import 'package:money_management2/widgets/pages/UpdateTransaction/update_transaction.dart';

class SlidableTransaction extends StatelessWidget {
  const SlidableTransaction({super.key, required this.transaction});

  // final TransactionModel transaction;
  final transactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: ((context) {
            showDialog(
                context: context,
                builder: ((context) {
                  return AlertDialog(
                    title: const Text(
                      'alert',
                      style: TextStyle(fontSize: 15, color: Colors.red),
                    ),
                    content: const Text('Do you want to delete '),
                    actions: [
                      TextButton(
                          onPressed: (() {
                            TransactionDB.instance
                                .deleteTransaction(transaction.id.toString());
                            Navigator.of(context).pop();
                          }),
                          child: const Text(
                            'yes',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )),
                      TextButton(
                        onPressed: (() {
                          Navigator.of(context).pop();
                        }),
                        child: const Text(
                          'no',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  );
                }));
          }),
          icon: Icons.delete,
          foregroundColor: Colors.red,
        ),
        SlidableAction(
          onPressed: ((context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) {
                  return EditTransaction(
                    id: transaction.id,
                    type: transaction.type,
                    amount: transaction.amount,
                    pupose: transaction.purpose,
                    date: transaction.date,
                    category: transaction.category,
                  );
                }),
              ),
            );
          }),
          icon: Icons.edit,
          foregroundColor: Colors.blue,
        ),
      ]),
      child: Card(
        elevation: 30,
        shape: RoundedRectangleBorder(
          //<-- SEE HERE
          // side: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 10, 92, 130),
              maxRadius: 40.0,
              child: Text(
                parseDate(transaction.date),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  wordSpacing: 1.0,
                ),
              )),
          title: Text(transaction.category.name),
          subtitle: Text(transaction.purpose),
          trailing: RichText(
            text: TextSpan(
              text: transaction.category.type == CategoryType.income
                  ? "+ "
                  : "- ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: transaction.category.type == CategoryType.income
                    ? const Color.fromARGB(255, 32, 115, 34)
                    : Colors.red,
              ),
              children: [
                TextSpan(
                  text: "₹  ${transaction.amount}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: transaction.category.type == CategoryType.income
                        ? const Color.fromARGB(255, 32, 115, 34)
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
