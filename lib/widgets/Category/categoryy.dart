import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management2/db/category/category_db.dart';
import 'package:money_management2/widgets/Category/popup_category.dart';
import 'package:money_management2/widgets/pages/Expensecategory/expense_grid.dart';
import 'package:money_management2/widgets/pages/IncomeCategory/income_grid_category.dart';

ValueNotifier<bool> expense = ValueNotifier(false);
ValueNotifier<bool> income = ValueNotifier(false);

class Categoryy extends StatelessWidget {
  const Categoryy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryDB().refreshUI();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromARGB(255, 10, 92, 130),
                  Color.fromARGB(255, 221, 210, 210),
                  Color.fromRGBO(206, 216, 223, 1),
                ]),
            shape: BoxShape.rectangle,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              actions: [
                ValueListenableBuilder<bool>(
                  valueListenable: expense,
                  builder: ((context, value, child) {
                    if (value) {
                      return IconButton(
                        onPressed: () {
                          expense.value = !expense.value;
                          log(expense.value.toString());
                        },
                        icon: const Icon(
                          Icons.grid_view,
                        ),
                      );
                    } else {
                      return IconButton(
                          onPressed: (() {
                            expense.value = !expense.value;
                            log(expense.value.toString());
                          }),
                          icon: const Icon(Icons.list));
                    }
                  }),
                )
              ],
              centerTitle: true,
              title: Text(
                'Money moves',
                style: GoogleFonts.acme(color: Colors.black),
              ),
              backgroundColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                child: Container(
                  height: 50,
                  width: 350,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey),
                    tabs: const [
                      Tab(
                        text: 'income',
                      ),
                      Tab(
                        text: 'Expense',
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: const TabBarView(
                children: [IncomeCategory(), ExpenseCategory()]),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 10, 92, 130),
              onPressed: () {
                showCategoryAddPopup(context);
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
