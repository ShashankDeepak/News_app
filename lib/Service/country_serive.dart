import 'dart:convert';

import 'package:get/get.dart';
import 'package:news_app/Constants/api.dart';

import '../Model/article_model.dart';
import '../Service/news_service.dart';
import "package:http/http.dart" as http;

class CountryNewsService extends GetxController {
  var articleList = <Article>[];
  var isLoading = true;

  Future<void> getNewsWithCountry({required String country}) async {
    NewsService.isLoading = true;
    var response = await http
        .get(Uri.parse(API().getNewsFromCountry(countryCode: country)));
    var jsonCode = jsonDecode(response.body);
    var tempList = <Article>[];
    if (jsonCode["status"] == "ok") {
      tempList = articlesFromJson(response.body);
    }
    if (tempList != null) {
      articleList = tempList;
    }
    isLoading = false;
  }

  List<Article> getArticles() {
    return articleList;
  }
}
