import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flash360_news/sevices/data.dart';
import 'package:flash360_news/sevices/news.dart';
import 'package:flash360_news/sevices/slider_data.dart';
import 'package:flash360_news/ui/pages/CategoryNews.dart';
import 'package:flash360_news/ui/pages/article_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/article_model.dart';
import '../../models/category_model.dart';
import '../../models/slider_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];
  int activeIndex = 1;
  bool _loading = true;
  bool  _loadingSliders = true;

  @override
  void initState() {
    // TODO: implement initState
    categories = getCategories();
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
     sliders = slider.sliders;
     setState(() {
       sliders =slider.sliders;
       _loadingSliders = false;
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF200505),
        title: Image.asset(
            "assets/images/appbar_logo.png",
            height: 150,
          width: 200,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Column(
              children: [
               Center(child: CircularProgressIndicator(),)
              ],
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        height: 70,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              categoryName: categories[index].categoryName,
                            );
                          },
                        ),
                      ),
                     const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  " Breaking News ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              height: 35,
                              decoration: BoxDecoration(
                                  color: Color(0xFF200505),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ],
                        ),
                      ),
                     const SizedBox(
                        height: 20,
                      ),
                      _loadingSliders
                      ? const Center(child: CircularProgressIndicator(),)
                      : CarouselSlider.builder(
                        itemCount: sliders.length,
                        itemBuilder: (context, index, realIndex) {
                          String? res = sliders[index].image;
                          String? res1 = sliders[index].title;

                          return buildImage(res!, index, res1!);
                        },
                        options: CarouselOptions(
                            height: 200,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            }),
                      ),
                     const SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: buildIndicator(),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  " Trending News ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              height: 35,
                              decoration: BoxDecoration(
                                  color: Color(0xFF200505),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                  title: articles[index].title!,
                                  url: articles[index].url!,
                                  desc: articles[index].description!,
                                  imageUrl: articles[index].image!);
                            }),
                      )
                    ]),
              ),
            ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              height: 250,
              padding: const EdgeInsets.only(left: 10.0),
              margin: const EdgeInsets.only(top: 130.0),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Text(
                name,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          ],
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: const ExpandingDotsEffect(
            dotWidth: 15, dotHeight: 15, activeDotColor: Color(0xFF200505)),
      );
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;

  const CategoryTile({this.image, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryNewsPage(name: categoryName)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child:
            Container(
                width: 110,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  shape: BoxShape.rectangle,
                  color: Color(0xFF200505),
                ),
                child: Center(
                  child: Text(
                    categoryName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;

  BlogTile({required this.title, required this.desc, required this.url, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticlePage(blogUrl: url )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Text(
                        title,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Text(
                        desc,
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
