import 'dart:convert';

import 'package:get/get.dart';
import 'package:news_app/Constants/api.dart';

import '../Model/article_model.dart';
import "package:http/http.dart" as http;

class NewsService {
  static var articleList = <Article>[];
  static var isLoading = true;

  Future<void> getNews() async {
    isLoading = true;
    var response = await http.get(Uri.parse(API().defalutApi));

    var tempList = articlesFromJson(response.body);

    print(tempList[5].title);
    if (tempList != null) {
      articleList = tempList;
      isLoading = false;
    }
  }

  List<Article> getArticles() {
    return articleList;
  }
}
