import 'package:flutter/material.dart';
import 'package:personal_money_management_app/screens/category/expense_category_list.dart';
import 'package:personal_money_management_app/screens/category/income_category_list.dart';
import 'package:personal_money_management_app/screens/models/category/category_db.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({Key? key}) : super(key: key);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    _tabController=TabController(length:2, vsync: this);
    CategoryDB().refreshUI ();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            tabs: [
          Tab(text: "Income",),
          Tab(text: "Expense",)
        ]
        ),

        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: [
                IncomeCategoryList(),
                ExpenseCategoryList(),
          ]),
        )
      ],
    );
  }
}
