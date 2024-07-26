import 'dart:convert';

import 'package:flash360_news/Global/map_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class News{
List<ArticleModel> news = [];
Future<void> getNews() async {
 String url = "https://gnews.io/api/v4/top-headlines?country=pk&category=general&apikey=$mapKey";
 var response = await http.get(Uri.parse(url));
 var jsonData = jsonDecode(response.body);

    jsonData["articles"].forEach((value){
      if(value["image"] != null && value["description"] != null){
      ArticleModel articleModel = ArticleModel(
        title: value['title'],
        description: value['description'],
        author: value['author'],
        url: value['url'],
        image: value['image'],
        content: value['content'],
      );
      news.add(articleModel);
      }
    }
    );
  // } else {
  //   print("The api is not getting the result");

}

}
