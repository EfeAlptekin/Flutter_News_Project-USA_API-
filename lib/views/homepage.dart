import 'package:cached_network_image/cached_network_image.dart';
import 'package:food/helper/categorydata.dart';
import 'package:food/helper/newsdata.dart';
import 'package:food/model/newsmodel.dart';
import 'package:food/model/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:food/views/categorypage.dart';
//import 'package:food/views/categorypage.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //get our categories list

  List<CategoryModel> categories = List<CategoryModel>.empty();

  // get our newlists first

  List<ArticleModel> articles = List<ArticleModel>.empty();

  getNews() async {
    News newsdata = News();
    await newsdata.getNews();
    articles = newsdata.datatobesavedin;
  }

  @override
  void initState() {
    super.initState();

    categories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            "Lele",
            style: TextStyle(color: Colors.blueGrey),
          ),
          Text(
            "News",
            style: TextStyle(color: Colors.blueGrey),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        // color: Colors.white,
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                height: 70.0,
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  },
                ),
              ),
              Container(
                child: ListView.builder(
                  itemCount: articles.length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return NewsTemplate(
                      urlToImage: articles[index].urlToImage,
                      title: articles[index].title,
                      description: articles[index].description,
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

class CategoryTile extends StatelessWidget {
  final String categoryName, imageUrl, description;
  CategoryTile(
      {this.categoryName = "", this.imageUrl = "", this.description = ""});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryFragment(
                category: categoryName.toLowerCase(),
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 170,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: const Color.fromARGB(255, 121, 120, 120)),
            ),
            Container(
              alignment: Alignment.center,
              width: 170,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Creating template for news

class NewsTemplate extends StatelessWidget {
  final String title, description, url, urlToImage;
  NewsTemplate(
      {this.title = "",
      this.description = "",
      this.urlToImage = "",
      this.url = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: urlToImage,
                width: 380,
                height: 200,
                fit: BoxFit.cover,
              )),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 15.0, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }
}
