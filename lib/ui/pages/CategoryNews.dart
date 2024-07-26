import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash360_news/models/show_category.dart';
import 'package:flash360_news/sevices/data.dart';
import 'package:flash360_news/sevices/show_category_news.dart';
import 'package:flash360_news/ui/pages/article_page.dart';
import 'package:flutter/material.dart';

class CategoryNewsPage extends StatefulWidget {
  String name;

  CategoryNewsPage({required this.name});

  @override
  State<CategoryNewsPage> createState() => _CategoryNewsPageState();
}

class _CategoryNewsPageState extends State<CategoryNewsPage> {
  List<ShowCategoryModel> categories = [];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    getNews();
    super.initState();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.white
          ),
        backgroundColor: Color(0xFF200505),
        title: Text(
              widget.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
        ),
      body: Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ShowCategory(
                title: categories[index].title!,
                desc: categories[index].description!,
                Image: categories[index].image!,
                url: categories[index].url!,
              );
            }),
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String Image, title, desc, url;

  ShowCategory({required this.title, required this.desc, required this.Image, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticlePage(blogUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 2.0,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: Image,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  )
                  ,),

                Text(desc, maxLines: 3,),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
