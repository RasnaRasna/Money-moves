import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_management2/db/transaction/transaction_db.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';

ValueNotifier<List<transactionModel>> overViewListNotifier = ValueNotifier([]);

class SearchField extends StatelessWidget {
  SearchField({super.key});
  final TextEditingController _searchQueryController = TextEditingController();
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
            controller: _searchQueryController,
            onChanged: (value) {
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
                      _searchQueryController.clear();
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

  searchResult(String value) {
    if (value.isEmpty) {
      overViewListNotifier.value =
          TransactionDB.instance.transactionListNotifier.value;
      // overViewListNotifier.notifyListeners();
    } else {
      log("else is working");

      overViewListNotifier.value = overViewListNotifier.value
          .where((element) =>
              element.category.name
                  .toLowerCase()
                  .contains(value.trim().toLowerCase()) ||
              element.purpose.contains(value.toLowerCase().trim()))
          .toList();
      // overViewListNotifier.notifyListeners();
      log(overViewListNotifier.value.length.toString());
    }
  }
}
