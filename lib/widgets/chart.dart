import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

import './chartBar.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransaction ;

  Chart(this.recentTransaction);

  List<Map<String,Object>> get  groupedTrasactionValues{
    return List.generate( 7 , (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index)) ;
      var totalsum = 0.0 ;

      for( var i=0 ; i< recentTransaction.length ; i++) {
        if(recentTransaction[i].date.day == weekDay.day
        && recentTransaction[i].date.month == weekDay.month
        && recentTransaction[i].date.year == weekDay.year)
          {
            totalsum += recentTransaction[i].amount ; 
          }
      }

      return {'day' : DateFormat.E().format(weekDay).substring(0 , 1) , 'amount' : totalsum};
    }).reversed.toList();
  }

  double get totalspending {
    return groupedTrasactionValues.fold(0.0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children : groupedTrasactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                   totalspending == 0.0 ? 0.0 : (data['amount'] as double) / totalspending ),
              );
            } ).toList(),
        ),
      ),
    );
  }
}
