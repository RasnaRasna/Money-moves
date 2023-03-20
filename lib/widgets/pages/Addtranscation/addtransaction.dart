import 'dart:developer';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:money_management2/db/category/category_db.dart';
import 'package:money_management2/db/transaction/transaction_db.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';

import 'package:money_management2/widgets/pages/Addtranscation/add_category_popup.dart';
// TextEditingController addcategorycontroller=TextEditingController();

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;

  final _purpposeEditinfController = TextEditingController();
  final _amountEditinfController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  String? _validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a category';
    }
    return null;
  }

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
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
        title: const Text(
          'Add transaction',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                                activeColor: Color.fromARGB(255, 10, 92, 130),
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
                                activeColor: Color.fromARGB(255, 10, 92, 130),
                                value: CategoryType.expense,
                                groupValue: _selectedCategorytype,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedCategorytype =
                                        CategoryType.expense;
                                    _categoryID = null;
                                  });
                                }),
                            const Text('Expense'),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 10, 92, 130),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(7),
                              child: Icon(
                                Icons.menu_sharp,
                                size: 18,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ValueListenableBuilder(
                                  valueListenable:
                                      CategoryDB().expenseCategoryList,
                                  builder: (context, value, child) =>
                                      ValueListenableBuilder(
                                    // li

                                    //     CategoryDB().IncomeCategoryList,
                                    valueListenable:
                                        CategoryDB().IncomeCategoryList,
                                    builder: (context, value, child) =>
                                        DropdownButton<String>(
                                      hint: const Text('Select category'),
                                      value: _categoryID,
                                      items: (_selectedCategorytype ==
                                                  CategoryType.income
                                              ? CategoryDB().IncomeCategoryList
                                              : CategoryDB()
                                                  .expenseCategoryList)
                                          .value
                                          .map((e) {
                                        return DropdownMenuItem(
                                          value: e.id,
                                          child: Text(e.name),
                                          onTap: () {
                                            log(" fff ${CategoryDB().IncomeCategoryList.value.length}");
                                            _selectedCategoryModel = e;
                                          },
                                        );
                                      }).toList(),
                                      onChanged: (selectedValue) {
                                        setState(() {
                                          _categoryID = selectedValue;
                                        });
                                        // String? validationMessage =
                                        //     _validateCategory(selectedValue);
                                        // if (validationMessage != null) {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(SnackBar(
                                        //           content:
                                        //               Text(validationMessage)));
                                        // }
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
                                    selectedCategoryType:
                                        _selectedCategorytype);
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                color: Color.fromARGB(255, 10, 92, 130),
                              ))
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 10, 92, 130),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.all(7),
                                  child: Icon(
                                    Icons.attach_money,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _amountEditinfController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter Amonut'),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                  validator: ((value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Amount is Required';
                                    }
                                    return null;
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 10, 92, 130),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.all(7),
                                  child: Icon(
                                    Icons.description,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _purpposeEditinfController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Note On Transaction'),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return " purpose is Requuired";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                            // set the initial colorScheme
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.fromSwatch(
                                    primarySwatch: Colors
                                        .blueGrey, // set the primary color
                                    // set other colors as desired
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (selectDateTemp == null) {
                            return;
                          } else {
                            print(selectDateTemp.toString());
                            setState(() {
                              _selectedDate = selectDateTemp;
                            });
                          }
                        },
                        icon: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 10, 92, 130),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 20,
                              )),
                        ),
                        label: Text(
                          _selectedDate == null
                              ? 'select date'
                              : parseDate(_selectedDate!),
                          style:
                              TextStyle(color: Color.fromARGB(255, 83, 82, 82)),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 10, 92, 130),
                          ),
                          onPressed: () {
                            addTransaction();

                            if (_formkey.currentState!.validate()) {
                              'SAVE THE DATA';
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final purposetext = _purpposeEditinfController.text;
    final amounttext = _amountEditinfController.text;
    if (purposetext.isEmpty) {
      return;
    }
    if (amounttext.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }
    final parseAmount = double.tryParse(amounttext);
    if (parseAmount == null) {
      return;
    }
    final model = transactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        purpose: purposetext,
        amount: parseAmount,
        date: _selectedDate!,
        type: _selectedCategorytype!,
        category: _selectedCategoryModel!);
    await TransactionDB.instance.addTransaction(model);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();

    AnimatedSnackBar.rectangle(
      'Success',
      'Transaction Added Successfully',
      type: AnimatedSnackBarType.success,
      brightness: Brightness.light,
      duration: Duration(seconds: 4),
    ).show(context);
  }
}

String parseDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}
