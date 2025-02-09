import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/quote_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _quote = '"The best way to predict the future is to create it."';
  String _author = '- Abraham Lincoln';
  List<String> _favorites = [];

  Future<void> _fetchQuote() async {
    try {
      final quoteData = await QuoteService.fetchRandomQuote();
      setState(() {
        _quote = quoteData['content'];
        _author = '- ${quoteData['author']}';
      });
    } catch (e) {
      print('Error fetching quote: $e');
    }
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  Future<void> _addToFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final quote = '$_quote $_author';
    if (!_favorites.contains(quote)) {
      _favorites.add(quote);
      await prefs.setStringList('favorites', _favorites);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added to favorites!')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchQuote();
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Quote'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _quote,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              _author,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: _addToFavorites,
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    // Share quote
                  },
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: _fetchQuote,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
