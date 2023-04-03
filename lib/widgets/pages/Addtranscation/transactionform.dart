// Define a new function to encapsulate the form code
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_management2/widgets/pages/Addtranscation/addtransaction.dart';

//  UpdateDateCallback is a type alias or typedef in Dart. It defines a new type that represents a function that
//takes a single parameter of type DateTime? and returns void.
typedef UpdateDateCallback = void Function(DateTime?);

Widget buildTransactionForm(
    TextEditingController _amountEditinfController,
    TextEditingController _purpposeEditinfController,
    BuildContext context,
    DateTime? _selectedDate,
    void Function(DateTime? newDate) updateDate) {
  return Column(children: [
    const SizedBox(height: 20),
    Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 10, 92, 130),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(7),
            child: const Icon(
              Icons.attach_money,
              size: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              maxLength: 10,
              controller: _amountEditinfController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Amount',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              validator: ((value) {
                if (value?.isEmpty ?? true) {
                  return 'Amount is Required';
                }
                return null;
              }),
              buildCounter: (
                BuildContext context, {
                int? currentLength,
                int? maxLength,
                bool? isFocused,
              }) =>
                  null,
            ),
          ),
        ],
      ),
    ),
    const SizedBox(height: 25),
    Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 10, 92, 130),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(7),
            child: const Icon(
              Icons.description,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              controller: _purpposeEditinfController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note On Transaction',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Purpose is Required';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    ),
    const SizedBox(height: 25),
    // calendar/
    Align(
      alignment: Alignment.bottomLeft,
      child: Form(
        child: TextButton.icon(
          onPressed: () async {
            final selectDateTemp = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate:
                  DateTime.now().subtract(const Duration(days: 10 * 365)),
              lastDate: DateTime.now(),
              // set the initial colorScheme
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: Colors.blueGrey,
                      // set the primary color
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
              updateDate(selectDateTemp);
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
            _selectedDate == null ? 'select date' : parseDate(_selectedDate),
            style: const TextStyle(color: Color.fromARGB(255, 83, 82, 82)),
          ),
        ),
      ),
    ),

    const SizedBox(height: 20),
  ]);
}
