import 'news_api_provider.dart';
import 'news_db_provider.dart';
import 'dart:async';
import '../models/item_model.dart';

class Repository{
  var dpProvider=new NewsDbProvider();
  var apiProvider=new NewsApiProvider();

  fetchTopIds(){
    return apiProvider.fetchTopIds();
  }

  fetchItem(int id) async{
    var item=await dpProvider.fetchItem(id);
    if(item!=null){
      return item;
    }

    item=await apiProvider.fetchItem(id);
    dpProvider.addItem(item);

    return item;
  }
}