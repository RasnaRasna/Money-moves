import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:money_management2/models/category/category_model.dart';

// ignore: constant_identifier_names
const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() {
    return instance;
  }

  // ignore: non_constant_identifier_names
  ValueNotifier<List<CategoryModel>> IncomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryList = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.put(value.id, value);
    refreshUI();
  }

  Future<void> refreshUI() async {
    final allCAtegories = await getCategories();
    IncomeCategoryList.value.clear();
    expenseCategoryList.value.clear();
    await Future.forEach(
      allCAtegories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          IncomeCategoryList.value.add(category);
        } else {
          expenseCategoryList.value.add(category);
        }
      },
    );
    IncomeCategoryList.notifyListeners();
    expenseCategoryList.notifyListeners();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDB.values.toList();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.delete(categoryID);
    refreshUI();
  }
}
