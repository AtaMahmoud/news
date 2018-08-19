import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc{
  final _repository=new Repository();
  final _toIdsController=new PublishSubject<List<int>>();

  Observable<List<int>> get topIdsStream=>_toIdsController.stream;

  fetchTopIds()async{
    final ids=await _repository.fetchTopIds();
    _toIdsController.sink.add(ids);
  }

  dispose(){
    _toIdsController.close();
  }

}