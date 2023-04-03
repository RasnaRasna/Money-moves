import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/widgets/pages/static/all_statics.dart';
import 'package:money_management2/widgets/pages/static/expense_income_statics.dart';

class Statics extends StatelessWidget {
  const Statics({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 3,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 10, 92, 130),
                Color.fromARGB(255, 221, 210, 210),
                Color.fromRGBO(206, 216, 223, 1),
              ]),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Center(
                    child: Text(
                  'Money moves',
                  style: GoogleFonts.acme(color: Colors.black),
                )),
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
                          text: 'All',
                        ),
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
                // bottom: TabBar(tabs: [Tab(text: "Income"), Tab(text: "Expense")]),
              ),
              body: TabBarView(children: [
                const Allstatics(),
                ExpenseStatics(incomeOrExpense: CategoryType.income),
                ExpenseStatics(incomeOrExpense: CategoryType.expense),
              ]),
            ),
          )),
    );
  }
}
