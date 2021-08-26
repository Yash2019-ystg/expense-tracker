import 'package:flutter/material.dart';

import './widgets/Transactions_list.dart';

import './widgets/textField.dart';

import './model/transaction.dart';

import './widgets/chart.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense App",
      theme: new ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.redAccent,
        // textTheme: ThemeData.light().textTheme.copyWith(
         //  title: TextStyle(
        //  fontWeight: FontWeight.bold,
           //   fontSize: 18,
           // ),
           //  button: TextStyle(color: Colors.white) ,
       //   ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransaction = [];

  void _addTransaction(String ptitle ,double pamount , DateTime chosenDate) {
    final newtx =Transaction(
        title: ptitle,
        amount: pamount,
        id: DateTime.now().toString(),
        date: chosenDate ,
    );
    setState(() {
      _userTransaction.add(newtx);
    });
  }


  void startAddtransactionPanel(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_) {
      return textField(_addTransaction);
    });
  }

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
          DateTime.now().subtract(
              Duration(days: 7),
          ),
      );
    });
  }

  void deleteTrasaction(String id){
    setState(() {
      _userTransaction.removeWhere((uid) => uid.id == id);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title:new Text("Expense Tracker") ,
        elevation: 20.0,
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () => startAddtransactionPanel(context))
        ],
      ),
      body:  SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center ,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Chart(_userTransaction),
              transactionList(_userTransaction , deleteTrasaction),
            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => startAddtransactionPanel(context) ,
        child: Icon(Icons.add),) ,
    );
  }
}

