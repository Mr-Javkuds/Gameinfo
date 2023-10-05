import 'dart:convert';
import 'package:gaminfo/model/gameNoFilter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gaminfo/model/gameFilter.dart';


import 'model/gameGenre.dart';
import 'model/game_detail.dart';
import 'model/game_list.dart';


class API_SERVICE{
  String API_KEY='key=91131b2d0342499dbc6180fbdbc72d3b';
 //https://api.rawg.io/api/games?key=91131b2d0342499dbc6180fbdbc72d3b
  String BASE_URL='https://api.rawg.io/api';

  Future getGamelist () async {
    //https://api.rawg.io/api/developers?key=91131b2d0342499dbc6180fbdbc72d3b
    String url = BASE_URL+'/games?'+API_KEY;
    print(url);
    final response = await http.get(Uri.parse(url));
    print(response.contentLength);
    print(response.body);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print('model test list');

      GameList model = GameList.fromJson(json.decode(response.body));
      print(model?.results?[0].id);
      return model;
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }
  Future getDetail({required id})async{
    //https://api.rawg.io/api/games/123?key=91131b2d0342499dbc6180fbdbc72d3b
    String url2=BASE_URL+'/games/'+id+'?'+API_KEY;

    print(url2.toString());
    final response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200) {
      print(response.statusCode) ;
      print(response.body) ;
      print('model test detail') ;

      Game_detail model = Game_detail.fromJson(json.decode(response.body));
      print(model!.name.toString()??'') ;
      return model;
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }
  Future getGenre()async{
    //https://api.rawg.io/api/genres?key=91131b2d0342499dbc6180fbdbc72d3b
    String url2=BASE_URL+'/genres?'+API_KEY;

    print(url2.toString());
    final response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200) {
      print(response.statusCode) ;
      print(response.body) ;
      print('model test genre') ;

      GameGenre model = GameGenre.fromJson(json.decode(response.body));
      print(model?.results[1].name??0) ;
      return model;
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }
  Future getFilter({required value})async{
    //https://api.rawg.io/api/games?search=g&key=91131b2d0342499dbc6180fbdbc72d3b


      String query = value??"";
    //  https://api.rawg.io/api/games?search=&key=91131b2d0342499dbc6180fbdbc72d3b
    String url2=BASE_URL+'/games?search=$query'+'&'+API_KEY;
    print(url2.toString());
    print('kueri :'+query);
    final response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200) {
      print(response.statusCode) ;
      print(response.body) ;
      print('model test filter') ;
      print(query);
      GameFilter model = GameFilter.fromJson(json.decode(response.body));
      print(query);
      print(response.body);
      print(model!.results?[1].slug.toString()??'null') ;
      return model;
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }
  Future getnoFilter()async{
    //https://api.rawg.io/api/games?search=g&key=91131b2d0342499dbc6180fbdbc72d3b

    //  https://api.rawg.io/api/games?search=&key=91131b2d0342499dbc6180fbdbc72d3b
    String url2=BASE_URL+'/games?search=&'+API_KEY;
    print(url2.toString());
    final response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200) {
      print(response.statusCode) ;
      print(response.body) ;
      print('model test filter') ;
      Gamenofilter model = Gamenofilter.fromJson(json.decode(response.body));
      print(model?.results?[1].slug.toString()??'null') ;
      return model;
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }
}