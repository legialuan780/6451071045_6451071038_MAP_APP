import 'package:flutter/material.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({super.key});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vi?t ??nh gi?')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: controller, maxLines: 5, decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Nh?p ??nh gi?...')),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('G?i')),
          ],
        ),
      ),
    );
  }
}
