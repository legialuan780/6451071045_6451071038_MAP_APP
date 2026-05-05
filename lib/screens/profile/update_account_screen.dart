import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class UpdateAccountScreen extends StatelessWidget {
  const UpdateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cập nhật tài khoản')),
      body: ListView(
        children: [
          ListTile(title: const Text('Đổi tên'), onTap: () => Navigator.pushNamed(context, AppRoutes.changeName)),
          ListTile(title: const Text('Đổi username'), onTap: () => Navigator.pushNamed(context, AppRoutes.changeUsername)),
          ListTile(title: const Text('Đổi email'), onTap: () => Navigator.pushNamed(context, AppRoutes.changeEmail)),
          ListTile(title: const Text('Đổi số điện thoại'), onTap: () => Navigator.pushNamed(context, AppRoutes.changePhoneNumber)),
          ListTile(title: const Text('Đổi giới tính'), onTap: () => Navigator.pushNamed(context, AppRoutes.changeGender)),
          ListTile(title: const Text('Đổi ngày sinh'), onTap: () => Navigator.pushNamed(context, AppRoutes.changeDateofBirth)),
        ],
      ),
    );
  }
}
