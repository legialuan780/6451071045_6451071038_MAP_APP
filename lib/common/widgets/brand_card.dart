import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  final String brandName;
  final String? imageUrl;
  final int productCount;

  const BrandCard({super.key, required this.brandName, this.imageUrl, required this.productCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(radius: 28, child: Icon(Icons.store)),
          const SizedBox(height: 8),
          Text(brandName, maxLines: 1, overflow: TextOverflow.ellipsis),
          Text('$productCount sản phẩm', style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
