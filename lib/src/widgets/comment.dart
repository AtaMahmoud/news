import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../widgets/loading_card.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: itemMap[itemId],
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (!snapshot.hasData) {
            return LoadingCard();
          }
          final item = snapshot.data;
          final children = <Widget>[
            ListTile(
              contentPadding: EdgeInsets.only(
                right: 16.0,
                left: (depth + 1) * 16.0,
              ),
              title: Text(item.text),
              subtitle: item.by == '' ? Text('Deleted') : Text(item.by),
            ),
            Divider(),
          ];
          snapshot.data.kids.forEach((kidId) {
            children.add(Comment(
              itemId: itemId,
              itemMap: itemMap,
              depth: depth + 1,
            ));
          });
          return Column(
            children: children,
          );
        });
  }
}
