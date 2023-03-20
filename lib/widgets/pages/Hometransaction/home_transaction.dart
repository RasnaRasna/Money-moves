import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:money_management2/db/category/category_db.dart';
import 'package:money_management2/db/transaction/transaction_db.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';
import 'package:money_management2/widgets/pages/Addtranscation/addtransaction.dart';
import 'package:money_management2/widgets/pages/Menunavbar.dart';
import 'package:money_management2/widgets/pages/ViewAll/transactionn.dart';

import '../ViewAll/view_all.dart';

class HomeTransactonn extends StatelessWidget {
  const HomeTransactonn({super.key});

  @override
  Widget build(BuildContext context) {
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
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 10, 92, 130),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const AddTransaction()));
              },
              child: const Icon(Icons.add),
            ),
            // side menu
            drawer: const MenuNavbar(),
            //  show incom expense and balance
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    width: 410,
                    child: Card(
                      color: const Color.fromARGB(255, 255, 242, 242),
                      elevation: 20,
                      child: Stack(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                height: 30,
                                child: Text(
                                  'Current Balance',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.currency_rupee_sharp,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                Text(
                                  totalbalance.toString(),
                                  style: const TextStyle(
                                      fontSize: 25, color: Colors.black),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 30),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 14),
                                    child: Text(
                                      'Income',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 34, 150, 38),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee,
                                        color: Color.fromARGB(255, 34, 150, 38),
                                      ),
                                      Text(
                                        totalincome.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 34, 150, 38),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          //
                          // money
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 20, bottom: 30),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 14),
                                    child: Text(
                                      "Expense",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 154, 20, 10),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(Icons.currency_rupee,
                                          color:
                                              Color.fromARGB(255, 154, 20, 10)),
                                      Text(
                                        totalexpense.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 154, 20, 10)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // recent and view all
                  ListTile(
                    leading: const Padding(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      child: Text(
                        'Recent Transaction',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          CategoryDB.instance.getCategories();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const ViewAll()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 10, 92, 130),
                        ),
                        child: const Text(
                          'View All',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // transactions

                  Expanded(child: TransactonTiles()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
