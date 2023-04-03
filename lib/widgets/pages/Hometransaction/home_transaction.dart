import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:google_fonts/google_fonts.dart';
import 'package:money_management2/db/category/category_db.dart';
import 'package:money_management2/db/transaction/transaction_db.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';
import 'package:money_management2/widgets/pages/Addtranscation/addtransaction.dart';
import 'package:money_management2/widgets/pages/Hometransaction/cardhome.dart';

import 'package:money_management2/widgets/pages/search/search.dart';
import 'package:money_management2/widgets/pages/Hometransaction/transactionn.dart';

import '../ViewAll/view_all.dart';
import '../settings/menunavbar.dart';

class HomeTransactonn extends StatelessWidget {
  const HomeTransactonn({super.key});

  @override
  Widget build(BuildContext context) {
    overViewListNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;

    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (context, List<transactionModel> value, _) {
        double? totalbalance = 0;
        double? totalincome = 0;
        double? totalexpense = 0;
        for (var element
            in TransactionDB.instance.transactionListNotifier.value) {
          if (element.type == CategoryType.income) {
            totalincome = (totalincome! + element.amount);
          } else {
            totalexpense = (totalexpense! + element.amount);
          }
          totalbalance = totalincome! - totalexpense!;
        }

        return Container(
          // Screen Background color
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 10, 92, 130),
              Color.fromARGB(255, 221, 210, 210),
              Color.fromRGBO(206, 216, 223, 1),
            ]),
          ),
          child: Scaffold(
            drawerScrimColor: Colors.white,

            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                'Money Moves',
                style: GoogleFonts.acme(fontSize: 30, color: Colors.black),
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(vertical: 62),
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 10, 92, 130),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const AddTransaction()));
                },
                child: const Icon(Icons.add),
              ),
            ),
            // side menu
            drawer: const MenuNavbar(),
            //  show incom expense and balance
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  homecard(totalbalance, totalexpense, totalincome),

                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      child: Text(
                        'Recent Transaction',
                        style: GoogleFonts.acme(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    trailing: Visibility(
                      visible: TransactionDB
                          .instance.transactionListNotifier.value.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            CategoryDB.instance.getCategories();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const ViewAll()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 10, 92, 130),
                          ),
                          child: Text(
                            'View All',
                            style: GoogleFonts.acme(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // transactions

                  const Expanded(child: TransactonTiles()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
