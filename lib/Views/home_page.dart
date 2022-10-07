import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Model/article_model.dart';
import 'package:news_app/Service/category_service.dart';
import 'package:news_app/Service/country_serive.dart';
import 'package:news_app/Service/news_service.dart';
import "package:http/http.dart" as http;
import '../Constants/constants.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<int> getStatus(String url, int index) async {
    var response = await http.get(Uri.parse(articlesList[index].urlToImage!));
    return response.statusCode;
  }

  var articlesList = <Article>[];
  List<Category> categoryList = [];
  bool isLoading = true;
  int countryListIndex = 0;

//gets news
  getNews() async {
    NewsService news = NewsService();
    await news.getNews();
    articlesList = news.getArticles();
    print(articlesList[1].description);
    isLoading = news.getLoading();
    setState(() {});
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("News App"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () async {
                          CategoryNewsService catNews = CategoryNewsService();
                          await catNews.getNewsWithCategory(
                              category: category[index]);
                          articlesList = catNews.getArticles();
                          isLoading = catNews.isLoading;
                          setState(() {});
                        },
                        child: SizedBox(
                          width: 200,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(category[index]),
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  // crossAxisAlignment: WrapCrossAlignment.center,
                  children: countryList.map((element) {
                    return InkWell(
                      onTap: () async {
                        isLoading = true;
                        setState(() {});
                        int index = countryList.indexOf(element);
                        CountryNewsService news = CountryNewsService();
                        await news.getNewsWithCountry(
                            country: countryCodeList[index]);
                        articlesList = news.getArticles();
                        isLoading = false;
                        setState(() {});
                      },
                      child: SizedBox(
                          height: 70,
                          width: 90,
                          child: Card(child: Center(child: Text(element)))),
                    );
                  }).toList(),
                ),
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: 500,
                      child: ListView.builder(
                        itemCount: articlesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              if (articlesList[index].urlToImage != null)
                                Image.network(articlesList[index].urlToImage!),
                              Text(articlesList[index].title!),
                            ],
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
