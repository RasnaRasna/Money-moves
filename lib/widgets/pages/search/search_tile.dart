import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:money_management2/models/transactions/transaction_model.dart';

import 'package:money_management2/widgets/pages/search/search.dart';
import 'package:money_management2/widgets/pages/search/slidable_list_tile.dart';

class SearchTiles extends StatelessWidget {
  const SearchTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: overViewListNotifier,
      builder: (context, newList, child) {
        log("${overViewListNotifier.value.length.toString()} is the overview count");
        return newList.isEmpty
            ? Center(
                child: Image.asset(
                'lib/assets/images/output-onlinegiftools (2).gif',
                height: 300,
                width: 300,
              ))
            : Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    transactionModel transaction = newList[index];
                    return SlidableTransaction(transaction: transaction);
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.transparent,
                  ),
                  itemCount: overViewListNotifier.value.length,
                ),
              );
      },
    );
  }
}

String parseDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}
