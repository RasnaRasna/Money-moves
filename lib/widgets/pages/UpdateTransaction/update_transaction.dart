import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:money_management2/db/transaction/transaction_db.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';
import 'package:money_management2/widgets/pages/ViewAll/view_all.dart';
import 'package:money_management2/widgets/pages/search/search.dart';
import '../../../db/category/category_db.dart';
import '../Addtranscation/add_category_popup.dart';

class EditTransaction extends StatefulWidget {
  String? id;
  CategoryType type;
  double amount;
  String pupose;
  final DateTime date;
  final CategoryModel category;

  EditTransaction(
      {super.key,
      required this.id,
      required this.type,
      required this.amount,
      required this.pupose,
      required this.date,
      required this.category});

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;
  DateTime _selectedDate = DateTime.now();
  late TextEditingController transactionamount;
  late TextEditingController transactionpupose;

  @override
  void initState() {
    _selectedCategorytype = widget.type;
    transactionpupose = TextEditingController(text: widget.pupose);
    transactionamount = TextEditingController(text: widget.amount.toString());
    _selectedCategoryModel = widget.category;
    _selectedDate = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                Color.fromARGB(255, 10, 92, 130),
                Color.fromARGB(255, 221, 210, 210),
                Color.fromARGB(255, 10, 92, 130),
              ])),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Update',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                            activeColor: const Color.fromARGB(255, 10, 92, 130),
                            value: CategoryType.income,
                            groupValue: _selectedCategorytype,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategorytype = CategoryType.income;
                                _categoryID = null;
                              });
                            }),
                        const Text('income'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            activeColor: const Color.fromARGB(255, 10, 92, 130),
                            value: CategoryType.expense,
                            groupValue: _selectedCategorytype,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategorytype = CategoryType.expense;
                                _categoryID = null;
                              });
                            }),
                        const Text('Expense'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFF0A5C82),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(7),
                          child: const Icon(
                            Icons.menu_sharp,
                            size: 18,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ValueListenableBuilder(
                              valueListenable: CategoryDB().expenseCategoryList,
                              builder: (context, value, child) =>
                                  ValueListenableBuilder(
                                // li

                                //     CategoryDB().IncomeCategoryList,
                                valueListenable:
                                    CategoryDB().IncomeCategoryList,
                                builder: (context, value, child) =>
                                    DropdownButton<String>(
                                  hint: Text(widget.category.name),
                                  value: _categoryID,
                                  items: (_selectedCategorytype ==
                                              CategoryType.income
                                          ? CategoryDB().IncomeCategoryList
                                          : CategoryDB().expenseCategoryList)
                                      .value
                                      .map((e) {
                                    return DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.name),
                                      onTap: () {
                                        _selectedCategoryModel = e;
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (selectedValue) {
                                    setState(() {
                                      _categoryID = selectedValue;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            addPopupOnly(
                                context: context,
                                selectedCategoryType: _selectedCategorytype);
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Color.fromARGB(255, 10, 92, 130),
                          )),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 10, 92, 130),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(7),
                              child: const Icon(
                                Icons.attach_money,
                                size: 20,
                                color: Colors.white,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextField(
                              controller: transactionamount,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Amount'),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 10, 92, 130),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(7),
                              child: const Icon(
                                Icons.description,
                                color: Colors.white,
                                size: 20,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextField(
                              controller: transactionpupose,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Note On Transaction'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    //calender

                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton.icon(
                        onPressed: () async {
                          final selectDateTemp = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 10 * 365)),
                            lastDate: DateTime.now(),
                            // Remove extra parenthesis and move Theme widget outside of showDatePicker
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.fromSwatch(
                                    primarySwatch: Colors.blueGrey,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (selectDateTemp == null) {
                            return;
                          } else {
                            setState(() {
                              _selectedDate = selectDateTemp;
                            });
                          }
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 10, 92, 130),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 20,
                              )),
                        ),
                        label: Text(
                          _selectedDate == null
                              ? 'select date'
                              : parseDate(_selectedDate),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 83, 82, 82)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 10, 92, 130),
                          ),
                          onPressed: () {
                            updateTransaction();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future updateTransaction() async {
    widget.amount = double.parse(transactionamount.text);
    widget.pupose = transactionpupose.text;
    final model = transactionModel(
        id: widget.id,
        category: _selectedCategoryModel!,
        type: widget.type,
        date: _selectedDate,
        amount: widget.amount,
        purpose: widget.pupose);

    TransactionDB.instance.editTransaction(model);
    await TransactionDB.instance.refresh();
    SearchField.searchResult(searchQueryController.text);
    Showlist.notifyListeners();
  }
}

String parseDate(DateTime selectedDate) {
  return DateFormat.MMMd().format(selectedDate);
}
