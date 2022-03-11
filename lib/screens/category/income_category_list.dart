import 'package:flutter/material.dart';
import 'package:personal_money_management_app/screens/models/category/category_db.dart';
import 'package:personal_money_management_app/screens/db_models/category_model/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: CategoryDB().incomeCategoryListListner,
        builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _){
        return ListView.separated(
        itemCount: newList.length,
        itemBuilder: (ctx, index){
          final categoryItem= newList[index];
        return   Card(
        child: ListTile(
          title: Text(categoryItem.name),
          trailing: IconButton(
            onPressed: (){
              CategoryDB.instance.deleteCategory(categoryItem.id);
            },
            icon: const Icon(Icons.delete),
          ),
        ),

        );/* Your list item widget here */;
        },
        separatorBuilder: (ctx, index){
        return const SizedBox(
        height: 10,
        );/* Your separator widget here */;


        });
  });
}
}