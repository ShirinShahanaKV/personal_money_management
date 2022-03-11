import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_money_management_app/screens/db_models/transaction_model/transaction_model.dart';

const TANSACTION_DB_NAME='transaction_database';

abstract class TransactionDbFunctions{

  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements TransactionDbFunctions{

  //make db singleton so that only single object will be used in full project
  TransactionDB._internal();// internal is named constructor
  static TransactionDB instance= TransactionDB._internal();
  factory TransactionDB(){
    return instance;//when ever object of category db is created the instance(same object) object will be returned.
  }

ValueNotifier<List<TransactionModel>> transactionListNotifier = ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async{

    final _db = await Hive.openBox<TransactionModel>(TANSACTION_DB_NAME);
   await _db.put(obj.id,obj);
  }

  Future<void> refresh() async{
    final _list =await getAllTransactions();
    _list.sort((first,second)=>second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();

  }


  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(TANSACTION_DB_NAME);

    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    print("id inside ${id}");
    final _db = await Hive.openBox<TransactionModel>(TANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }


}