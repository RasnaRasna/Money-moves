import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:money_management2/db/category/category_db.dart';
import 'package:money_management2/db/transaction/transaction_db.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';

import 'package:money_management2/widgets/pages/Addtranscation/add_category_popup.dart';
import 'package:money_management2/widgets/pages/Addtranscation/transactionform.dart';
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

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  void _updateDate(DateTime? newDate) {
    setState(() {
      _selectedDate = newDate;
    });
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
                                activeColor:
                                    const Color.fromARGB(255, 10, 92, 130),
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
                                activeColor:
                                    const Color.fromARGB(255, 10, 92, 130),
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
                                  color: const Color.fromARGB(255, 10, 92, 130),
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
                                  valueListenable:
                                      CategoryDB().expenseCategoryList,
                                  builder: (context, value, child) =>
                                      ValueListenableBuilder(
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
                    buildTransactionForm(
                        _amountEditinfController,
                        _purpposeEditinfController,
                        context,
                        _selectedDate,
                        _updateDate)
                    // Column(
                    //   children: [
                    //     const SizedBox(
                    //       height: 20,
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 7),
                    //       child: Row(
                    //         children: [
                    //           Container(
                    //               decoration: BoxDecoration(
                    //                   color: const Color.fromARGB(
                    //                       255, 10, 92, 130),
                    //                   borderRadius: BorderRadius.circular(10)),
                    //               padding: const EdgeInsets.all(7),
                    //               child: const Icon(
                    //                 Icons.attach_money,
                    //                 size: 20,
                    //                 color: Colors.white,
                    //               )),
                    //           const SizedBox(
                    //             width: 20,
                    //           ),
                    //           Expanded(
                    //             child: TextFormField(
                    //               maxLength: 10,
                    //               controller: _amountEditinfController,
                    //               decoration: const InputDecoration(
                    //                   border: InputBorder.none,
                    //                   hintText: 'Enter Amount'),
                    //               inputFormatters: [
                    //                 FilteringTextInputFormatter.digitsOnly
                    //               ],
                    //               keyboardType: TextInputType.number,
                    //               validator: ((value) {
                    //                 if (value?.isEmpty ?? true) {
                    //                   return 'Amount is Required';
                    //                 }
                    //                 return null;
                    //               }),
                    //               buildCounter: (BuildContext context,
                    //                       {int? currentLength,
                    //                       int? maxLength,
                    //                       bool? isFocused}) =>
                    //                   null,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       height: 25,
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 7),
                    //       child: Row(
                    //         children: [
                    //           Container(
                    //               decoration: BoxDecoration(
                    //                   color: const Color.fromARGB(
                    //                       255, 10, 92, 130),
                    //                   borderRadius: BorderRadius.circular(10)),
                    //               padding: const EdgeInsets.all(7),
                    //               child: const Icon(
                    //                 Icons.description,
                    //                 color: Colors.white,
                    //                 size: 20,
                    //               )),
                    //           const SizedBox(
                    //             width: 20,
                    //           ),
                    //           Expanded(
                    //             child: TextFormField(
                    //               controller: _purpposeEditinfController,
                    //               decoration: const InputDecoration(
                    //                   border: InputBorder.none,
                    //                   hintText: 'Note On Transaction'),
                    //               validator: (value) {
                    //                 if (value?.isEmpty ?? true) {
                    //                   return " purpose is Requuired";
                    //                 }
                    //                 return null;
                    //               },
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    ,

                    // //calender

                    // Align(
                    //   alignment: Alignment.bottomLeft,
                    //   child: Form(
                    //     child: TextButton.icon(
                    //       onPressed: () async {
                    //         final selectDateTemp = await showDatePicker(
                    //           context: context,
                    //           initialDate: DateTime.now(),
                    //           firstDate: DateTime.now()
                    //               .subtract(const Duration(days: 10 * 365)),
                    //           lastDate: DateTime.now(),
                    //           // set the initial colorScheme
                    //           builder: (BuildContext context, Widget? child) {
                    //             return Theme(
                    //               data: ThemeData.light().copyWith(
                    //                 colorScheme: ColorScheme.fromSwatch(
                    //                   primarySwatch: Colors.blueGrey,
                    //                   // set the primary color
                    //                   // set other colors as desired
                    //                 ),
                    //               ),
                    //               child: child!,
                    //             );
                    //           },
                    //         );
                    //         if (selectDateTemp == null) {
                    //           return;
                    //         } else {
                    //           setState(() {
                    //             _selectedDate = selectDateTemp;
                    //           });
                    //         }
                    //       },
                    //       icon: Padding(
                    //         padding: const EdgeInsets.only(right: 10),
                    //         child: Container(
                    //             decoration: BoxDecoration(
                    //                 color:
                    //                     const Color.fromARGB(255, 10, 92, 130),
                    //                 borderRadius: BorderRadius.circular(10)),
                    //             padding: const EdgeInsets.all(8),
                    //             child: const Icon(
                    //               Icons.calendar_month,
                    //               color: Colors.white,
                    //               size: 20,
                    //             )),
                    //       ),
                    //       label: Text(
                    //         _selectedDate == null
                    //             ? 'select date'
                    //             : parseDate(_selectedDate!),
                    //         style: const TextStyle(
                    //             color: Color.fromARGB(255, 83, 82, 82)),
                    //       ),
                    //     ),
                    //   ),
                    // ),

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
      duration: const Duration(seconds: 4),
    ).show(context);
  }
}

String parseDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}
