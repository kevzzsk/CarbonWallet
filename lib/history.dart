import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
class HistoryPage extends StatefulWidget {
  final purchaseState;
  HistoryPage({this.purchaseState});
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.purchaseState.length,
      itemBuilder: (context,index){
        return ExpandablePanel(
          
        );
      },
    );
  }
}