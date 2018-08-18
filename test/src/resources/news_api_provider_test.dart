import 'package:http/http.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/testing.dart';

void main(){

  test('fetchTopIds  return alist of ids', () async{
    final newsApi=new NewsApiProvider();
   newsApi.client= MockClient((request) async{
      return Response(json.encode([100,200,300,400]),200);
    });
   final ids=await newsApi.fetchTopIds();

   expect(ids, [100,200,300,400]);
  });

  test('FetchItem returns a item model', ()async{
    final newsApi=new NewsApiProvider();
    newsApi.client=MockClient((request)async{
      final resMap={'id':123};
      return Response(json.encode(resMap),200);
    });

    final item=await newsApi.fetchItem(999);

    expect(item.id, 123);
  });
}