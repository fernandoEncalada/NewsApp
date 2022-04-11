import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Screen extends StatefulWidget {
  const Tab2Screen({Key? key}) : super(key: key);

  @override
  State<Tab2Screen> createState() => _Tab2ScreenState();
}

class _Tab2ScreenState extends State<Tab2Screen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _CategoriesList(),

            Expanded(
              child: (newsService.getArticlesSelectedCategory!.length == 0) 
              ? Center(child: CircularProgressIndicator())
              : NewsList(newsService.getArticlesSelectedCategory!)
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (_, int index) {
            final cName = categories[index].name;

            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButton(categories[index]),
                  SizedBox(height: 5),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}')
                ],
              ),
            );
          }),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: (() {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      }),
      child: Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Icon(
            category.icon,
            color: (newsService.selectedCategory == category.name)
                ? myTheme.colorScheme.secondary
                : Colors.black54,
          )),
    );
  }
}
