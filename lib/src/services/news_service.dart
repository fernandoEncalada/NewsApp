import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/news_models.dart';

import 'package:http/http.dart' as http;

import '../models/category_model.dart';

const _NEWS_URL = 'newsapi.org';
const _APIKEY = '253e1dc83fb34a3d8fe5aaab62819bc5';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadLines();

    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    getArticlesByCategory(value);

    notifyListeners();
  }

  List<Article>? get getArticlesSelectedCategory =>
      categoryArticles[selectedCategory];

  getTopHeadLines() async {
    final response = await http.get(Uri.https(
        _NEWS_URL, '/v2/top-headlines', {'apiKey': _APIKEY, 'country': 'us'}));

    final newsResponse = newsResponseFromJson(response.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.length > 0) {
      return categoryArticles[category];
    }

    final response = await http.get(Uri.https(_NEWS_URL, '/v2/top-headlines',
        {'apiKey': _APIKEY, 'country': 'us', 'category': category}));

    final newsResponse = newsResponseFromJson(response.body);

    categoryArticles[category]!.addAll(newsResponse.articles);
    print(categoryArticles[category]);

    notifyListeners();
  }
}
