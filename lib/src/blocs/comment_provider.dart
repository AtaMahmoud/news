import 'package:flutter/material.dart';
import 'comment_bloc.dart';
export 'comment_bloc.dart';

class CommentProvider extends InheritedWidget {
  final CommentsBloc commentsBloc;

  CommentProvider({Key key, Widget child})
      : commentsBloc = new CommentsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static CommentsBloc of(BuildContext conetxt) {
    return (conetxt.inheritFromWidgetOfExactType(CommentProvider)
            as CommentProvider)
        .commentsBloc;
  }
}
