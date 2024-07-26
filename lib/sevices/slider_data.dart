import 'package:flash360_news/models/slider_model.dart';
import 'dart:convert';
import 'package:flash360_news/Global/map_key.dart';
import 'package:flash360_news/sevices/slider_data.dart';
import 'package:http/http.dart' as http;

import '../models/slider_model.dart';


class Sliders{
  List<sliderModel> sliders = [];
  Future<void> getSlider() async {
    String url = "https://gnews.io/api/v4/top-headlines?country=pk&category=general&apikey=$mapKey";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    jsonData["articles"].forEach((value){
      if(value["image"] != null && value["description"] != null){
        sliderModel slidermodel = sliderModel(
          title: value['title'],
          description: value['description'],
          author: value['author'],
          url: value['url'],
          image: value['image'],
          content: value['content'],
        );
        sliders.add(slidermodel);
      }
    }
    );
    // } else {
    //   print("The api is not getting the result");

  }

}
