import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onToggleFavorite;
  final bool isFavorite;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.onToggleFavorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: SizedBox.expand(
                      child: product.imageUrl == null
                          ? Container(
                              color: Colors.grey.shade200,
                              child: const Center(child: Icon(Icons.image_outlined)),
                            )
                          : Image.network(
                              product.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.grey.shade200,
                                child: const Center(child: Icon(Icons.broken_image_outlined)),
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: IconButton(
                        iconSize: 18,
                        visualDensity: VisualDensity.compact,
                        onPressed: onToggleFavorite,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              child: Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '${product.price.toStringAsFixed(0)} VND',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onAddToCart,
                  icon: const Icon(Icons.add_shopping_cart, size: 18),
                  label: const Text('Thêm giỏ'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
