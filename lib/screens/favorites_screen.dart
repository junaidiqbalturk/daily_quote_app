import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Center(
        child: Text(
          'Your favorite quotes will appear here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
