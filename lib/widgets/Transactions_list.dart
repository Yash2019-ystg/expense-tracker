import 'package:flutter/material.dart';
import 'package:flutter_app/model/transaction.dart';                    //fixedbox lagana hai isme
import 'package:intl/intl.dart';


class transactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deletetrans ;

  transactionList(this.transactions,this.deletetrans);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      child: transactions.isNotEmpty? SingleChildScrollView(
        child: Column(
          children: transactions.map((tx) {
        return Card(                              // can also be use: return ListTile(leading : CircleAvatar()
          child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15) ,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple,width: 5.0 ,),
              ),
              padding: EdgeInsets.all(5.0) ,
              child: new Text("Rs ${tx.amount.toStringAsFixed(2)}",            //amount
                style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0 ),),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                new Text(tx.title,style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),), //title
                new Text(DateFormat.yMMMd().format(tx.date),
                  style: new TextStyle(color: Colors.brown),)   //date
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    icon:  Icon(Icons.delete , color: Colors.redAccent,),
                    onPressed:  () => deletetrans(tx.id)  ),
              ],
            )
          ],
        ),
        );
    }).toList(),
        ),
      ) : new Text("There is no Transactions" , style: TextStyle(fontSize:25.0 ),),

    );
  }
}
