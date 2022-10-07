import 'dart:convert';

import 'package:get/get.dart';
import 'package:news_app/Constants/api.dart';
import 'package:news_app/Service/news_service.dart';

import '../Model/article_model.dart';
import "package:http/http.dart" as http;

class CategoryNewsService extends GetxController {
  var articleList = <Article>[];
  var isLoading = true;

  Future<void> getNewsWithCategory({required String category}) async {
    var response = await http
        .get(Uri.parse(API().getNewsWithCategory(category: category)));

    var tempList = articlesFromJson(response.body);

    if (tempList != null) {
      articleList = tempList;
    }
    isLoading = false;
  }

  List<Article> getArticles() {
    return articleList;
  }
}
