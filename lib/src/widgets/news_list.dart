import 'package:flutter/material.dart';
import 'package:news_app/src/theme/theme.dart';

import '../models/news_models.dart';

class NewsList extends StatelessWidget {
  final List<Article> articles;

  const NewsList(this.articles);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (_, int index) {
          return _News(
            news: articles[index],
            index: index,
          );
        });
  }
}

class _News extends StatelessWidget {
  final Article news;
  final int index;

  const _News({required this.news, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardTopBar(news, index),
        _CardTitle(news),
        _CardImage(news),
        _CardBody(news),

        _CardButtons(),

        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final Article news;
  final int index;

  const _CardTopBar(this.news, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${index + 1}',
            style: TextStyle(color: myTheme.colorScheme.secondary),
          ),
          Text('${news.source.name}'),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article news;

  const _CardTitle(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(news.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article news;

  const _CardImage(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
        child: Container(
          child: (news.urlToImage != null)
              ? FadeInImage(
                  placeholder: AssetImage('assets/img/giphy.gif'),
                  image: NetworkImage(news.urlToImage),
                )
              : Image(
                  image: AssetImage('assets/img/no-image.png'),
                ),
        ),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article news;

  const _CardBody(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text((news.description) != null ? news.description : ''),
    );
  }
}

class _CardButtons extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: (){},
            fillColor: myTheme.colorScheme.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.star_border),
          ),

          SizedBox(width: 10),

          RawMaterialButton(
            onPressed: (){},
            fillColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.more),
          ),

        ],
      ),
    );
  }
}