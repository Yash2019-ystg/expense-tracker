import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label ;
  final double spendingAmount ;
  final double percentage ;

  ChartBar(this.label , this.spendingAmount , this.percentage);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20.0,
          child: FittedBox(
              child: Text('Rs ${spendingAmount.toStringAsFixed(1)}')),
        ),
        SizedBox(height: 4,),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(decoration:  BoxDecoration(
                  border:  Border.all(color: Colors.grey ,width: 1.0),
              color: Color.fromRGBO(220, 220, 220, 1.0),
              borderRadius: BorderRadius.circular(20.0),
              ),
              ),
              FractionallySizedBox(
              heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4,),
        Text(label),
      ],
    );
  }
}
