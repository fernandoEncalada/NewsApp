// To parse this JSON data, do
//
//     final newsResponse = newsResponseFromJson(jsonString);

import 'dart:convert';

NewsResponse newsResponseFromJson(String str) => NewsResponse.fromJson(json.decode(str));

class NewsResponse {
    NewsResponse({
        required this.status,
        required this.totalResults,
        required this.articles,
    });

    String status;
    int totalResults;
    List<Article> articles;

    factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );
}

class Article {
    Article({
        required this.source,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.publishedAt,
        required this.content,
    });

    Source source;
    String author;
    String title;
    String description;
    String url;
    String urlToImage;
    String publishedAt;
    String content;

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] == null ? '' : json["author"],
        title: json["title"] == null ? '' : json["title"],
        description: json["description"] == null ? '' : json["description"],
        url: json["url"] == null ? '' : json["url"],
        urlToImage: json["urlToImage"] == null ? '' : json["urlToImage"],
        publishedAt: json["publishedAt"] == null ? '' : json["publishedAt"],
        content: json["content"] == null ? '' : json["content"] ,
    );
}

class Source {
    Source({
        required this.id,
        required this.name,
    });

    String id;
    String name;

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] == null ? '' : json["id"],
        name: json["name"] == null ? '' : json["name"],
    );
}