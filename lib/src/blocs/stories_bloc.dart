import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:async';

class StoriesBloc {
  final _repository = new Repository();
  final _toIdsController = new PublishSubject<List<int>>();
  final _itemsOutPutController =
      new BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcherController = new PublishSubject<int>();

  Observable<List<int>> get topIdsStream => _toIdsController.stream;

  Observable<Map<int, Future<ItemModel>>> get items =>
      _itemsOutPutController.stream;

  Function(int) get fetchItem => _itemsFetcherController.sink.add;

  StoriesBloc() {
    _itemsFetcherController.stream
        .transform(_itemTransformer())
        .pipe(_itemsOutPutController);
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _toIdsController.sink.add(ids);
  }
  clearCache(){
    return _repository.clearCache();
  }
  _itemTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, int index) {
        cache[id] = _repository.fetchItem(id);
        print('*************$index**************');
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _toIdsController.close();
    _itemsOutPutController.close();
    _itemsFetcherController.close();
  }
}
