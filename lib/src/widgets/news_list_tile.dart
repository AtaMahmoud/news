import 'package:flutter/material.dart';
import 'loading_card.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'dart:async';

class NewsListTile extends StatelessWidget {
  final int itemId;
  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final storiesBloc=StoriesProvider.of(context);
    storiesBloc.fetchItem(itemId);

    return StreamBuilder(
      stream: storiesBloc.items,
      builder: (context,AsyncSnapshot<Map<int,Future<ItemModel>>>snapShot){
        if(!snapShot.hasData){
          return LoadingCard();
        }

        return FutureBuilder(
          future: snapShot.data[itemId],
          builder: (context,AsyncSnapshot<ItemModel>itemSnapShot){
            if(!itemSnapShot.hasData){
             return LoadingCard();
            }

            return buildTile(context,itemSnapShot.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context,ItemModel item){
    return Card(
      child: ListTile(
        onTap: ()=>Navigator.pushNamed(context, '/${item.id}'),
        title: Text(item.title),
        subtitle: Text('${item.score} votes'),
        trailing: Column(
          children: <Widget>[
            Icon(Icons.comment),
            Text('${item.descendants}')
          ],
        ),
      ),
      margin: EdgeInsets.all(8.0),
    );
  }
}
