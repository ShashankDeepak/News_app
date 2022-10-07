import 'dart:convert';

List<Article> articlesFromJson(String str) => List<Article>.from(
      json.decode(str)['articles'].map(
            (x) => Article.fromJson(
              Map<String, dynamic>.from(x),
            ),
          ),
    );

class Article {
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? date;

  Article({
    this.title,
    this.description,
    this.date,
    this.url,
    this.urlToImage,
  });

  Article.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
  }
}
