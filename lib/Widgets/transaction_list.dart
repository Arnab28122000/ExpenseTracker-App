import 'dart:math';
import 'package:expense/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  
  Color _setColor(){
    Color _bgColor;
    const availableColors =[
      Colors.deepPurple,
      Colors.deepPurpleAccent,
      Colors.purple,
      Colors.purpleAccent,
    ];
    
    _bgColor=availableColors[Random().nextInt(4)];
    return _bgColor;
  }
  

  @override
  Widget build(BuildContext context) {
    return  widget.transactions.isEmpty
          ? LayoutBuilder(builder:(ctx, constraints){
            return Column(
              children: <Widget>[
                
                Text(
                  'No transaction added yet!',
                  // ignore: deprecated_member_use
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height:30,),
                Container(
                  height:constraints.maxHeight * 0.6,
                  child: Image.asset('images/waiting.png', fit: BoxFit.cover)),
              ],
            );

          })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal:5),
                                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _setColor(),
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                                            child: FittedBox(
                          child: Text('\$${widget.transactions[index].amount}')),
                      ),
                      ),
                      title: Text(
                        widget.transactions[index].title,
                        // ignore: deprecated_member_use
                        style : Theme.of(context).textTheme.title,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd().format(widget.transactions[index].date),
                        ),
                        trailing: MediaQuery.of(context).size.width > 460 ?
                        FlatButton.icon(
                          textColor:Theme.of(context).errorColor,
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          onPressed: () => widget.deleteTx(widget.transactions[index].id),
                          ):
                           IconButton(
                          icon: Icon(Icons.delete),
                          color:Theme.of(context).errorColor,
                          onPressed: () => widget.deleteTx(widget.transactions[index].id),
                          ),
                    ),
                );
              },
              itemCount: widget.transactions.length,
    );
  }
}
