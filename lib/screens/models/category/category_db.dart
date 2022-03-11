import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_money_management_app/screens/db_models/category_model/category_model.dart';

const CATEGORY_DB_NAME='category_database';
abstract class CategoryDBFunctions {

  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel model);//insert will be time consuming so use future
  Future<void> deleteCategory(String id);
}
class CategoryDB implements CategoryDBFunctions {

  //make db singleton so that only single object will be used in full project
  CategoryDB._internal();// internal is named constructor
  static CategoryDB instance= CategoryDB._internal();
  factory CategoryDB(){
    return instance;//when ever object of category db is created the instance(same object) object will be returned.
  }



  ValueNotifier<List<CategoryModel>> incomeCategoryListListner =ValueNotifier([]); // the widgets which all are listening this list will get rebuild
  ValueNotifier<List<CategoryModel>> expenseCategoryListListner =ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel model) async {

   final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
   await _categoryDB.put(model.id , model);// add wil enter autoincrement id

   refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories () async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async{
    final _allCategories =await getCategories();
    incomeCategoryListListner.value.clear();
    expenseCategoryListListner.value.clear();
    await Future.forEach(_allCategories, (CategoryModel category)  {

      if(category.type ==CategoryType.income){
        incomeCategoryListListner.value.add(category);
      } else {
        expenseCategoryListListner.value.add(category);
      }
    });

    incomeCategoryListListner.notifyListeners();
    expenseCategoryListListner.notifyListeners();

  }

  @override
  Future<void> deleteCategory(String id) async{
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.delete(id);
    refreshUI();
  }



}