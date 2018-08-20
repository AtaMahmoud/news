import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'dart:async';

class NewsListTile extends StatelessWidget {
  final int itemId;
  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final storiesBloc=StoriesProvider.of(context);
    return StreamBuilder(
      stream: storiesBloc.items,
      builder: (context,AsyncSnapshot<Map<int,Future<ItemModel>>>snapShot){
        if(!snapShot.hasData){
          return Text('Stram Still loading');
        }

        return FutureBuilder(
          future: snapShot.data[itemId],
          builder: (context,AsyncSnapshot<ItemModel>itemSnapShot){
            if(!itemSnapShot.hasData){
             return Text('Stram Still loading item $itemId');
            }

            return Text(itemSnapShot.data.title);
          },
        );
      },
    );
  }
}
