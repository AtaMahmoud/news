import 'news_api_provider.dart';
import 'news_db_provider.dart';
import 'dart:async';
import '../models/item_model.dart';

class Repository{

  List<Source> sources=<Source>[
    newsDbProvider,
    new NewsApiProvider()
  ];

  List<Cache> caches=<Cache>[
    newsDbProvider
  ];

  Future<List<int>> fetchTopIds(){
    //TODO : iterate over sources when dbprovider implemented it
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async{
    ItemModel item;
    Source source;

    for(source in sources){
      item= await source.fetchItem(id);
      if(item!=null){
        break;
      }

      for(var cache in caches){
        cache.addItem(item);
      }

      return item;
    }
  }
}

abstract class Source{
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache{
  Future<int> addItem(ItemModel item);
}