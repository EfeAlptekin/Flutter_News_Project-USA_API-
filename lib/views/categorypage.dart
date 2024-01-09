import 'package:cached_network_image/cached_network_image.dart';
//import 'package:food/helper/categorydata.dart';
import 'package:food/helper/newsdata.dart';
//import 'package:food/model/categorymodel.dart';
import 'package:food/model/newsmodel.dart';
import 'package:flutter/material.dart';
import 'package:food/views/authpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryFragment extends StatefulWidget {
  final String category;
  CategoryFragment({this.category = ""});
  @override
  _CategoryFragmentState createState() => _CategoryFragmentState();
}

class _CategoryFragmentState extends State<CategoryFragment> {
  List<ArticleModel> articles = List<ArticleModel>.empty();
  bool _loading = true;

  getNews() async {
    CategoryNews newsdata = CategoryNews();
    await newsdata.getNews(widget.category);
    articles = newsdata.datatobesavedin;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment
              .center, // this is to bring the row text in center
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 50),
              child: Text(
                widget.category.toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),

      // category widgets
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: ListView.builder(
                  itemCount: articles.length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true, // add this otherwise an error
                  itemBuilder: (context, index) {
                    return NewsTemplate(
                      urlToImage: articles[index].urlToImage,
                      title: articles[index].title,
                      description: articles[index].description,
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class NewsTemplate extends StatefulWidget {
  final String title, description, url, urlToImage;
  NewsTemplate({
    this.title = "",
    this.description = "",
    this.urlToImage = "",
    this.url = "",
  });

  @override
  _NewsTemplateState createState() => _NewsTemplateState();
}

class _NewsTemplateState extends State<NewsTemplate> {
  bool _showSaveOption = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showSaveOption = !_showSaveOption;
        });
      },
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: widget.urlToImage,
                width: 380,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.description,
              style: TextStyle(fontSize: 15.0, color: Colors.grey[800]),
            ),
            if (_showSaveOption)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

                    if (isLoggedIn) {
                      String userId = FirebaseAuth.instance.currentUser!.uid;

                      Map<String, dynamic> savedArticle = {
                        'title': widget.title,
                        'description': widget.description,
                        'urlToImage': widget.urlToImage,
                      };

                      try {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('savedArticles')
                            .add(savedArticle);
                      } catch (e) {
                        print('Error occurred while saving the article: $e');
                      }
                    } else {
                      // If user didnt log in , redirect to AuthPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AuthPage()),
                      );
                    }
                  },
                  child: Text('Save'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
