import 'package:flutter/material.dart';
import 'package:personal_money_management_app/screens/models/category/category_db.dart';
import 'package:personal_money_management_app/screens/db_models/category_model/category_model.dart';


ValueNotifier<CategoryType> selectedCategoryNotifier = ValueNotifier(CategoryType.income);
Future<void> showCategoryAddPopup(BuildContext context) async {
  TextEditingController nameController = TextEditingController();
  showDialog(
    context: context,//context of screen
    builder : (ctx){
      return SimpleDialog(
        title: const Text("Add Category"),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
      hintText: "Category Name",
                border: OutlineInputBorder(
                
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              //RadioButton class created by me
              RadioButton(title: "Income", type: CategoryType.income),
              RadioButton(title: "Expense", type: CategoryType.expense),
            ],),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){
              final _name= nameController.text; // trim removes white space
              if(_name.isEmpty){
                return; //the function onPressed will be stopped
              }
              final type =selectedCategoryNotifier.value;
            final _category=  CategoryModel(id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: _name,
              type: type);
            CategoryDB.instance.insertCategory(_category);
            Navigator.of(ctx).pop();//ctx is the context of popup

            }, child: Text("Add")),
          ),
        ],
      );
    }
  );
}


class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
 // final CategoryType selectedType;
  const RadioButton({Key? key,
  required this.title,
  required this.type}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      //Since it is popup we created with notification builder and separate class,
      //either we can use stateful widget or use stateless widget with ValueNotifier.
      ValueListenableBuilder(
        valueListenable: selectedCategoryNotifier ,
        builder: (BuildContext ctx, CategoryType newCategory , Widget? _) {
        return  Radio<CategoryType>(
              value: type,
              groupValue: newCategory,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
                selectedCategoryNotifier.notifyListeners();
                print(value);
              });
        }),

        Text(title),

    ],

    );
  }
}
