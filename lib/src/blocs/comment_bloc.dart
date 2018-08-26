import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutPut = BehaviorSubject<Map<int, Future<ItemModel>>>();

  Observable<Map<int, Future<ItemModel>>> get itemsWithComment =>
      _commentsOutPut.stream;

  Function(int) get fetchItemWithComments=>_commentsFetcher.sink.add;

  CommentsBloc(){
    _commentsFetcher.transform(_commentsTransformer()).pipe(_commentsOutPut);
  }

  var _repository=new Repository();
  _commentsTransformer(){
    return ScanStreamTransformer<int,Map<int,Future<ItemModel>>>(
        (cache,int id,index){
          cache[id]=_repository.fetchItem(id);
          cache[id].then((ItemModel item){
            item.kids.forEach((kidId)=>fetchItemWithComments(kidId));
          });
        },
      <int,Future<ItemModel>>{}
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutPut.close();
  }
}
