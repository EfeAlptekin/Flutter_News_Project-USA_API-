import 'package:cached_network_image/cached_network_image.dart';
import 'package:food/helper/categorydata.dart';
import 'package:food/helper/newsdata.dart';
import 'package:food/model/newsmodel.dart';
import 'package:food/model/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:food/views/categorypage.dart';
import 'package:food/views/authpage.dart';
import 'package:food/views/savednewspage.dart';
import 'package:food/views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/views/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<CategoryModel> categories = List<CategoryModel>.empty();
  List<ArticleModel> articles = List<ArticleModel>.empty();
  bool _loading = true;
  //bool isLoggedIn = false;

  void authpage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthPage()),
    );
  }

  void signup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  void navigateToProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  void navigateToSavedNews() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SavedNews()),
    );
  }

  getNews() async {
    News newsdata = News();
    await newsdata.getNews();
    articles = newsdata.datatobesavedin;
    setState(() {
      _loading = false;
    });
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter ",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ],
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthPage()),
                );
              },
              label: Text('Sign In'),
              icon: Icon(Icons.login),
              backgroundColor: Colors.blue,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              label: Text('Sign Up'),
              icon: Icon(Icons.person_add),
              backgroundColor: Colors.green,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'User Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                navigateToProfilePage();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Saved News'),
              onTap: () {
                navigateToSavedNews();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log Out'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
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
                  onPressed: () async {
                    bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

                    if (isLoggedIn) {
                      String userId = FirebaseAuth.instance.currentUser!.uid;

                      Map<String, dynamic> savedArticle = {
                        'title': widget.title,
                        'description': widget.description,
                        'urlToImage': widget.urlToImage,
                        // Other news details can be added here
                      };

                      try {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('savedArticles')
                            .add(savedArticle);
                      } catch (e) {
                        print('Error occurred while saving the article: $e');
                        // You can inform the user in case of an error
                      }
                    } else {
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
