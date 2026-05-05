import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryItem({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const CircleAvatar(radius: 24, child: Icon(Icons.category)),
          const SizedBox(height: 6),
          Text(category.name),
        ],
      ),
    );
  }
}
