// ignore_for_file: public_member_api_docs, sort_constructors_first
class API {
  final String _apiKey = "a1c2531426a4465f855c1269ddb920c7";
  final String defalutApi =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a1c2531426a4465f855c1269ddb920c7";

  String? countryCode = "";
  String? category = "";
  String? language = "";

  API({
    this.countryCode,
    this.category,
    this.language,
  });

  String getApiAddress() {
    if (countryCode != "" && category != "" && language != "") {
      return "https://newsapi.org/v2/everything?country=$countryCode&category=$category&language=$language&apiKey=a1c2531426a4465f855c1269ddb920c7";
    } else {
      return defalutApi;
    }
  }

  String getNewsFromCountry({required String countryCode}) {
    return "https://newsapi.org/v2/top-headlines?country=$countryCode&category=business&apiKey=a1c2531426a4465f855c1269ddb920c7";
  }

  String getNewsWithCategory({required String category}) {
    return "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=a1c2531426a4465f855c1269ddb920c7";
  }
}
