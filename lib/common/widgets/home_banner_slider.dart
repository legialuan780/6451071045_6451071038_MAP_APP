import 'dart:async';

import 'package:flutter/material.dart';

/// Banner carousel with high-fashion photography (remote images).
class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({super.key});

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  static const double _height = 160;

  static const List<String> _fashionBannerUrls = [
    'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=1200&q=85&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=1200&q=85&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1509631179647-0177331693ae?w=1200&q=85&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1445205170230-053b83016050?w=1200&q=85&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1558171813-4c088753af8f?w=1200&q=85&auto=format&fit=crop',
  ];

  late final PageController _pageController;
  Timer? _autoPlayTimer;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || !_pageController.hasClients) return;
      final next = (_page + 1) % _fashionBannerUrls.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: _height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _page = i),
              itemCount: _fashionBannerUrls.length,
              itemBuilder: (context, index) {
                final url = _fashionBannerUrls[index];
                return Image.network(
                  url,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return ColoredBox(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => ColoredBox(
                    color: Colors.grey.shade300,
                    child: Icon(Icons.broken_image_outlined, color: Colors.grey.shade600, size: 40),
                  ),
                );
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_fashionBannerUrls.length, (i) {
                  final active = i == _page;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: active ? 20 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: active
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.45),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
