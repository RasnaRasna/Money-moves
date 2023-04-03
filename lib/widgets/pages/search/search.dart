import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_management2/db/transaction/transaction_db.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';
import 'package:money_management2/widgets/pages/ViewAll/view_all.dart';

final TextEditingController searchQueryController = TextEditingController();
ValueNotifier<List<transactionModel>> overViewListNotifier = ValueNotifier([]);

class SearchField extends StatelessWidget {
  SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 9,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
            controller: searchQueryController,
            onChanged: (value) async {
              searchResult(value);
            },
            decoration: InputDecoration(
                hintText: 'Search..',
                border: InputBorder.none,
                icon: const Icon(
                  Icons.search,
                  // color: textClr,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      overViewListNotifier.value =
                          TransactionDB.instance.transactionListNotifier.value;
                      searchQueryController.clear();
                      searchResult(searchQueryController.text);
                      Showlist.notifyListeners();
                    },
                    icon: const Icon(
                      Icons.close,
                      // color: Colors.black,
                    ))),
          ),
        ),
      ),
    );
  }

  static void refreshShowlist() {
    searchResult(searchQueryController.text);
    Showlist.notifyListeners();
  }

  static searchResult(String value) {
    if (value.isEmpty) {
      Showlist.value = TransactionDB.instance.transactionListNotifier.value;
    } else {
      // log("log hereeeeeeee${overViewListNotifier.value[0].amount}");
      Showlist.value = TransactionDB.instance.transactionListNotifier.value
          .where((element) =>
              element.category.name
                  .toLowerCase()
                  .contains(value.trim().toLowerCase()) ||
              element.purpose.contains(value.toLowerCase().trim()))
          .toList();
    }
  }
}
