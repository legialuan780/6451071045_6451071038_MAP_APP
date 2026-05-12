import 'package:flutter/material.dart';
import '../data/models/onboarding_model.dart';

class OnboardingController extends ChangeNotifier {
  int currentPage = 0;

  final PageController pageController = PageController();

  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      title: 'Mua sắm dễ dàng',
      description: 'Tìm kiếm và mua sản phẩm chỉ với vài thao tác.',
      // Dùng URL để tránh lỗi bundle asset khi hot reload / chưa rebuild
      imagePath:
          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=900&q=85&auto=format&fit=crop&fm=jpg',
    ),
    OnboardingModel(
      title: 'Thanh toán an toàn',
      description: 'Hỗ trợ nhiều phương thức thanh toán bảo mật.',
      imagePath:
          'https://images.unsplash.com/photo-1556742502-ec7c0e9f34b1?w=900&q=85&auto=format&fit=crop&fm=jpg',
    ),
    OnboardingModel(
      title: 'Giao hàng nhanh chóng',
      description: 'Đơn hàng được giao đến tận tay bạn.',
      imagePath:
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=900&q=85&auto=format&fit=crop&fm=jpg',
    ),
  ];

  void onPageChanged(int index) {
    currentPage = index;
    notifyListeners();
  }

  bool isLastPage() {
    return currentPage == onboardingPages.length - 1;
  }
}
