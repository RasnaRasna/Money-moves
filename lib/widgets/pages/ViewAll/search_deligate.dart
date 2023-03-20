import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management2/db/transaction/transaction_db.dart';
import 'package:money_management2/widgets/pages/UpdateTransaction/update_transaction.dart';
import 'package:money_management2/widgets/pages/ViewAll/transactionn.dart';
import 'package:money_management2/widgets/pages/ViewAll/view_all.dart';
import '../../../db/category/category_db.dart';
import '../../../models/category/category_model.dart';
import '../../../models/transactions/transaction_model.dart';

ValueNotifier<List<transactionModel>> searchResult = ValueNotifier([]);

class CustomSearch extends SearchDelegate {
  @override
  Widget buildSuggestions(BuildContext context) {
    searchResult.value = allList.value
        .where((element) =>
            element.category.name
                .toLowerCase()
                .contains(query.toLowerCase().trim()) ||
            element.purpose.toLowerCase().contains(query.toLowerCase().trim()))
        .toList();

    if (searchResult.value.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/images/output-onlinegiftools (2).gif',
          ),
          const Text('No results found')
        ],
      );
    } else {
      // return const TransactonTiles();

      return ListView.builder(
        itemCount: searchResult.value.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 30,
              child: Slidable(
                endActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: const Text(
                                  'alert',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.red),
                                ),
                                content: const Text('Do you want to delete '),
                                actions: [
                                  Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            TransactionDB.instance
                                                .deleteTransaction(searchResult
                                                    .value[index].id!);
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
                                id: searchResult.value[index].id,
                                amount: searchResult.value[index].amount,
                                pupose: searchResult.value[index].purpose,
                                date: searchResult.value[index].date,
                                type: searchResult.value[index].type,
                                category: searchResult.value[index].category,
                              )));
                    },
                    backgroundColor: Colors.white,
                    icon: Icons.edit,
                    foregroundColor: Colors.blue,
                  )
                ]),
                child: ListTile(
                  leading: Text(parseDate(searchResult.value[index].date)),
                  title: Text(searchResult.value[index].category.name),
                  subtitle: Text(searchResult.value[index].purpose),
                  trailing: RichText(
                    text: TextSpan(
                      text: searchResult.value[index].category.type ==
                              CategoryType.income
                          ? "+ "
                          : "- ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: searchResult.value[index].category.type ==
                                CategoryType.income
                            ? const Color.fromARGB(255, 32, 115, 34)
                            : Colors.red,
                      ),
                      children: [
                        TextSpan(
                          text: "${searchResult.value[index].amount}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: searchResult.value[index].category.type ==
                                    CategoryType.income
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  ValueNotifier<List<transactionModel>> searchResultNotifier =
      ValueNotifier([]);

  @override
  Widget buildResults(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    List<String> matchquery = [];
    for (var item in searchResult.value) {
      if (item.amount.toString().contains(query.trim())) {
        matchquery.add(item.amount.toString());
      }
    }
    return const TransactonTiles();

    //  ListView.builder(
    //     itemCount: searchResult.length,
    //     itemBuilder: (context, index) {
    //       return Card(
    //         elevation: 3,
    //         child: ListTile(
    //           title: Text(searchResult[index].category.name),
    //           subtitle: Text(searchResult[index].purpose),
    //           trailing: Text("${searchResult[index].amount}"),
    //         ),
    //       );
    //     });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          Navigator.pop(context);
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Future<void> showResults(BuildContext context) async {
    super.showResults(context);
  }

  @override
  Future<void> showSuggestions(BuildContext context) async {
    super.showSuggestions(context);
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
