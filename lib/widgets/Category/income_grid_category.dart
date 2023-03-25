import 'package:flutter/material.dart';
import 'package:money_management2/widgets/Category/categoryy.dart';

import '../../db/category/category_db.dart';
import '../../models/category/category_model.dart';

class IncomeCategory extends StatefulWidget {
  const IncomeCategory({Key? key}) : super(key: key);

  @override
  State<IncomeCategory> createState() => _IncomeCategoryState();
}

class _IncomeCategoryState extends State<IncomeCategory> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<CategoryModel>>(
      valueListenable: CategoryDB.instance.IncomeCategoryList,
      builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
        if (newlist.isEmpty) {
          return Center(
            child: Image.asset(
              'lib/assets/images/output-onlinegiftools (2).gif',
              height: 300,
              width: 300,
            ),
          );
        } else {
          return ValueListenableBuilder(
              valueListenable: expense,
              builder: ((context, value, child) {
                if (value) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.9,
                    ),
                    itemBuilder: (ctx, index) {
                      final category = newlist[index];
                      return Card(
                        elevation: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListTile(
                          title: Text(category.name),
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text(
                                    'Delete Category',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.red,
                                    ),
                                  ),
                                  content: Text(
                                      'Do you want to delete ${category.name}?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        CategoryDB.instance
                                            .deleteCategory(category.id);
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text('No'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: newlist.length,
                  );
                } else {
                  return ListView.separated(
                    itemBuilder: (ctx, index) {
                      final category = newlist[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 30,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ListTile(
                            title: Text(category.name),
                            trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text(
                                      'Delete Category',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                      ),
                                    ),
                                    content: Text(
                                        'Do you want to delete ${category.name}?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          CategoryDB.instance
                                              .deleteCategory(category.id);
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text('No'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount: newlist.length,
                  );
                }
              }));
        }
      },
    );
  }
}
