import 'package:flutter/material.dart';
import 'package:personal_money_management_app/screens/category/category_add_popup.dart';
import 'package:personal_money_management_app/screens/category/screen_category.dart';
import 'package:personal_money_management_app/screens/models/category/category_db.dart';
import 'package:personal_money_management_app/screens/home/widgets/bottom_navigation.dart';
import 'package:personal_money_management_app/screens/db_models/category_model/category_model.dart';
import 'package:personal_money_management_app/screens/transactions/screen_add_transaction.dart';
import 'package:personal_money_management_app/screens/transactions/screen_transactions.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

final pages= const[
  ScreenTransaction(),
  ScreenCategory()
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          title: const Text("Money Manager"),
      ),
      floatingActionButton: FloatingActionButton(
       child:const Icon(Icons.add),
        onPressed: () {
         if(selectedIndexNotifier.value==0){
           Navigator.push(
               context, MaterialPageRoute(builder: (context) => const ScreenAddTransaction()));
           //or we can add in routes in main.dart with pushNamed
         }else {

           showCategoryAddPopup(context);

         /*  final _sample= CategoryModel(
               id: DateTime.now().millisecondsSinceEpoch.toString(),
               name: "Travel",
               type: CategoryType.income);
           CategoryDB().insertCategory(_sample);*/
         }

         print("pressed floating button"); },) ,
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(child:  ValueListenableBuilder(
          valueListenable :selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _){
            return pages[updatedIndex];
          },
         ),),
    );
  }
}
