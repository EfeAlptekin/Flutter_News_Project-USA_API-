import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavedNews extends StatefulWidget {
  @override
  _SavedNewsState createState() => _SavedNewsState();
}

class _SavedNewsState extends State<SavedNews> {
  late List<Map<String, dynamic>> savedArticles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSavedArticles();
  }

  void fetchSavedArticles() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('savedArticles')
          .get();

      setState(() {
        savedArticles = querySnapshot.docs
            .map<Map<String, dynamic>>(
                (doc) => doc.data()! as Map<String, dynamic>)
            .toList();

        isLoading = false;
      });
    } catch (e) {
      print('Error fetching saved articles: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved News'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : savedArticles.isEmpty
              ? Center(child: Text('No saved articles yet.'))
              : ListView.builder(
                  itemCount: savedArticles.length,
                  itemBuilder: (context, index) {
                    return NewsTemplate(
                      urlToImage: savedArticles[index]['urlToImage'],
                      title: savedArticles[index]['title'],
                      description: savedArticles[index]['description'],
                    );
                  },
                ),
    );
  }
}

class NewsTemplate extends StatefulWidget {
  final String title, description, url, urlToImage;
  NewsTemplate({
    required this.title,
    required this.description,
    required this.urlToImage,
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
              child: Image.network(
                widget.urlToImage,
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
          ],
        ),
      ),
    );
  }
}
