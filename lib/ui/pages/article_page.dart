import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatefulWidget {
  String blogUrl;

  ArticlePage({required this.blogUrl});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Color(0xFF200505),
        title: Image.asset(
          "assets/images/appbar_logo.png",
          height: 150,
          width: 200,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: WebView(
        initialUrl: widget.blogUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
