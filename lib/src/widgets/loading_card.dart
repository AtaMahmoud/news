import 'package:flutter/material.dart';

class LoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: buildCard(),
        subtitle:buildCard(),
      ),
    );
  }
  Widget buildCard(){
    return Container(
      color: Colors.grey[200],
      height: 24.0,
      width: 150.0,
      margin: EdgeInsets.only(top: 8.0),
    );
  }
}
