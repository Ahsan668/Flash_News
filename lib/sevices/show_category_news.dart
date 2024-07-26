import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flash360_news/models/show_category.dart';

import '../Global/map_key.dart';

class ShowCategoryNews{
  List<ShowCategoryModel> categories = [];
  Future<void> getCategoriesNews(String category) async {
    String url = "https://gnews.io/api/v4/top-headlines?country=pk&category=$category&apikey=$mapKey";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    jsonData["articles"].forEach((value){
      if(value["image"] != null && value["description"] != null){
        ShowCategoryModel showCategoryModel = ShowCategoryModel(
          title: value['title'],
          description: value['description'],
          author: value['author'],
          url: value['url'],
          image: value['image'],
          content: value['content'],
        );
        categories.add(showCategoryModel);
      }
    }
    );
    // } else {
    //   print("The api is not getting the result");

  }

}
