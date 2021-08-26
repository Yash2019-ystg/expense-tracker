import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class textField extends StatefulWidget {

  final Function uTransaction ;

  textField(this.uTransaction);

  @override
  _textFieldState createState() => _textFieldState();
}

class _textFieldState extends State<textField> {
  final itemController = new TextEditingController();
  final amountController = new TextEditingController();
  DateTime selectedDate ;

  void submitData() {
    var amountEntered = double.parse(amountController.text);
    var itemEntered = itemController.text;

    if(amountEntered <=0 || itemEntered.isEmpty || selectedDate == null){
      return;
    }
    widget.uTransaction(itemController.text, double.parse(amountController.text) , selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(context: context,
        initialDate: DateTime.now() ,
        firstDate: DateTime(2019) ,
        lastDate:DateTime.now()
    ).then((pickedDate) {
          if (pickedDate == null){
            return ;
          }
          setState(() {
            selectedDate = pickedDate ;
          });

    }); // DateTime(2019)+
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      // margin: EdgeInsets.all(5.0),
      child: Container(
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(decoration: InputDecoration(labelText: "Item"),
                controller: itemController,),
              TextField(decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number ,
                onSubmitted: (_) => submitData(),
              ),

              Container(
                height: 70.0,
                child: Row(
                  children: [
                    Text(selectedDate == null ? "No date chosen" : DateFormat.yMMMd().format(selectedDate)),
                    FlatButton(
                      textColor:Theme.of(context).primaryColor ,
                      child: Text("Choose date" , style: new TextStyle(fontWeight: FontWeight.bold ),),
                      onPressed: _presentDatePicker ,
                    ),
                  ],
                ),
              ),

              FlatButton(onPressed:submitData,
                child: new Text("Add Transaction"),
               textColor: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

