import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_money_management_app/screens/db_models/transaction_model/transaction_model.dart';
import 'package:personal_money_management_app/screens/models/category/category_db.dart';
import 'package:personal_money_management_app/screens/db_models/category_model/category_model.dart';
import 'package:personal_money_management_app/screens/models/transactions/transactions_db.dart';


class ScreenAddTransaction extends StatefulWidget {

  const ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {


  TextEditingController _purposeController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController transactionDate = TextEditingController();
  DateTime formattedDate = DateTime.now();
  // String  selectedDropdown ;
   String? categoryId;

  CategoryType selectedCategory = CategoryType.income;
  CategoryModel? selectedCategoryModel;

  @override
  void initState() {
    transactionDate.clear(); //set the initial value of text field

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  onChanged: (value) {},
                  controller: _purposeController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Purpose',
                    hintStyle: TextStyle(fontSize: 16),
                    //contentPadding: EdgeInsets.all(8)
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 6),
              child: Container(
                  padding: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  onChanged: (value) {},
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Amount',
                    hintStyle: TextStyle(fontSize: 16),
                    //contentPadding: EdgeInsets.all(8)
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 6),
              child: Container(
                padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  controller: transactionDate,
                  style: TextStyle(fontSize: 13),

                  //editing controller of this TextField
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.black,
                    ),
                    hintText: "Transaction Date",
                    hintStyle:TextStyle(fontSize: 16),
                    border: InputBorder.none,

                    disabledBorder: InputBorder
                        .none, //icon of text field
                    // labelText: "From Date" //label text of field
                  ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate =
                    await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101),
                        helpText :"Select Date");
                    if (pickedDate != null) {


                      //pickedDate output format => 2021-03-10 00:00:00.000
                String  showDate=
                          DateFormat('dd-MM-yyyy')
                              .format(pickedDate);


                      setState(() {
                        formattedDate =pickedDate;
                       transactionDate.text=showDate;
                        //print("transaction date ${transactionDate.text}");
                      });
                      //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement


                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 6),
              child: Row(children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: selectedCategory,
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            print('selected category is $selectedCategory');
                            selectedCategory=CategoryType.income;
                            categoryId=null;
                          });

                        }),
                    Text("Income"),
                  ],
                ),
              Row(children: [
                Radio(
                    value: CategoryType.expense,
                    groupValue: selectedCategory,
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        selectedCategory=CategoryType.expense;
                        categoryId=null;
                        print('selected expense category is $selectedCategory');

                      });

                    }),
                Text("Expense"),

              ],)]),
            ),
            DropdownButton<String>(
                value:categoryId,
              hint:const Text("Select Category"),
                items:
            (selectedCategory == CategoryType.income ?
            CategoryDB.instance.incomeCategoryListListner:
            CategoryDB.instance.expenseCategoryListListner).value.map((e) {
              return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                onTap: (){
                  selectedCategoryModel=e;
                },
                  );
                }).toList(),

                /*      [
              DropdownMenuItem(
                value: 1,
                child: Text("one"),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("two"),
              )
            ],*/
                onChanged: (selectedValue){
                  setState(() {
                    categoryId= selectedValue;
                  });

              print(selectedValue);
            }),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 6),
              child: ElevatedButton(
                  child: const Text(
                    'SUBMIT',
                    style: TextStyle(fontSize: 16,),
                  ),
                  onPressed: () {
                    addTransaction();

                  }),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText= _purposeController.text;
    final _amountText= _amountController.text;
   final _selectedDate= formattedDate;
    DateTime selectedDate;
   if(_purposeText.isEmpty){return;}
    if(_amountText.isEmpty){return;}
   if(categoryId==null){return;}
   final parsedAmount=double.tryParse(_amountText);
    if (parsedAmount == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    if(selectedCategoryModel==null){return;}

   final _model =TransactionModel(
       purpose:_purposeText,
       amount:parsedAmount,
       date:_selectedDate,
       type:selectedCategory,
    category:selectedCategoryModel!,//! shows that the value will not be null

   );

    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}

