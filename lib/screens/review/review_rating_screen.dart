import 'package:flutter/material.dart';

class ReviewRatingScreen extends StatelessWidget {
  const ReviewRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('??nh gi?')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, i) => const ListTile(
          leading: Icon(Icons.person),
          title: Text('User'),
          subtitle: Text('S?n ph?m t?t'),
          trailing: Icon(Icons.star, color: Colors.amber),
        ),
      ),
    );
  }
}
