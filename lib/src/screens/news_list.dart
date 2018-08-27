import '../blocs/stories_provider.dart';
import 'package:flutter/material.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';


class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storiesBloc = StoriesProvider.of(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: buildList(storiesBloc),
    );
  }

  Widget buildList(StoriesBloc storiesBloc) {
    return StreamBuilder(
      stream: storiesBloc.topIdsStream,
      builder: (context,AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return Refresh(
          child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                print('${snapshot.data[index]}');
                return NewsListTile(itemId:snapshot.data[index]);
              },),
        );
      },
    );
  }
}
