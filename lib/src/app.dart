import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'blocs/comment_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute:routes,
        ),
      ),
    );
  }

  Route routes (RouteSettings settings){
    if(settings.name=='/'){
      return MaterialPageRoute(builder: (context){
        final storiesBloc=StoriesProvider.of(context);
        storiesBloc.fetchTopIds();
        return NewsList();
      });
    }else{
      return MaterialPageRoute(
        builder: (context){
          final int itemId=int.parse(settings.name.replaceFirst('/', ''));
          var commentsBloc=CommentProvider.of(context);
          commentsBloc.fetchItemWithComments(itemId);
          return NewsDetail(itemId: itemId);
        }
      );
    }
  }
}
