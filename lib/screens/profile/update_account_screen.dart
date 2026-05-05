import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class UpdateAccountScreen extends StatelessWidget {
  const UpdateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('C?p nh?t t?i kho?n')),
      body: ListView(
        children: [
          ListTile(title: const Text('??i t?n'), onTap: () => Navigator.pushNamed(context, AppRoutes.changeName)),
          ListTile(title: const Text('??i username'), onTap: () => Navigator.pushNamed(context, AppRoutes.changeUsername)),
          ListTile(title: const Text('??i email'), onTap: () => Navigator.pushNamed(context, AppRoutes.changeEmail)),
          ListTile(title: const Text('Đổi số điện thoại'), onTap: () => Navigator.pushNamed(context, AppRoutes.changePhoneNumber)),
          ListTile(title: const Text('??i gi?i t?nh'), onTap: () => Navigator.pushNamed(context, AppRoutes.changeGender)),
          ListTile(title: const Text('??i ng?y sinh'), onTap: () => Navigator.pushNamed(context, AppRoutes.changeDateofBirth)),
        ],
      ),
    );
  }
}
