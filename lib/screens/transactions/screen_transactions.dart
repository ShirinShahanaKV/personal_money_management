import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:personal_money_management_app/screens/db_models/category_model/category_model.dart';
import 'package:personal_money_management_app/screens/db_models/transaction_model/transaction_model.dart';
import 'package:personal_money_management_app/screens/models/category/category_db.dart';
import 'package:personal_money_management_app/screens/models/transactions/transactions_db.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (BuildContext context, List<TransactionModel> newList, Widget? _){
          return ListView.separated(
              itemCount: newList.length,
              itemBuilder: (ctx, index){
                final value =newList[index];
                return   Slidable(
                  key: Key(value.id!),
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(onPressed: (ctx){
                        print("id is ${value.id}");
                        TransactionDB.instance.deleteTransaction(value.id!);
                      },
                          icon:Icons.delete,
                      label:"Delete")
                    ],
                  ),
                  child: Card(
                      elevation:0,
                      child: ListTile(
                        leading:CircleAvatar(
                          radius: 50,
                          child:Text(parseDate(value.date),
                            textAlign: TextAlign.center,),
                          backgroundColor: value.type == CategoryType.income? Colors.green: Colors.red,
                        ),
                        title: Text("Rs ${value.amount}"),
                        subtitle: Text(value.category.name),
                      )
                  ),
                );/* Your list item widget here */;
              },
              separatorBuilder: (context, index){
                return Divider(
                  thickness: 1,
                );/* Your separator widget here */;
              }
          );
        });

  }

  String parseDate(DateTime date){
final _date =DateFormat.MMMd().format(date);
final _splitDate= _date.split(" ");//_splitdate will be array
   return  "${_splitDate.last}\n${_splitDate.first}";//first and last is
    //return "${date.day}\n ${date.month}";
  }
}
