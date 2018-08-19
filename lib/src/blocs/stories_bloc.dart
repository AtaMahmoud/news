import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:async';

class StoriesBloc {
  final _repository = new Repository();
  final _toIdsController = new PublishSubject<List<int>>();
  final _itemsController=new BehaviorSubject<int>();

  Observable<Map<int,Future<ItemModel>>> items;

  Observable<List<int>> get topIdsStream => _toIdsController.stream;
  Function(int) get fetchItem=>_itemsController.sink.add;

  StoriesBloc(){
    items=_itemsController.stream.transform(_itemTransformer());
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _toIdsController.sink.add(ids);
  }

  _itemTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id]=_repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _toIdsController.close();
    _itemsController.close();
  }
}
