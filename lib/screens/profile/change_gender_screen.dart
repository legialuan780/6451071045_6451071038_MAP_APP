import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/login_controller.dart';
import '../../controller/update_account_controller.dart';

class ChangeGenderScreen extends StatefulWidget {
  const ChangeGenderScreen({super.key});

  @override
  State<ChangeGenderScreen> createState() => _ChangeGenderScreenState();
}

class _ChangeGenderScreenState extends State<ChangeGenderScreen> {
  final AuthController authController = Get.find<AuthController>();
  final UpdateAccountController updateController = Get.find<UpdateAccountController>();
  late String _selectedGender;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedGender = authController.currentUser?.gender.isNotEmpty == true
        ? authController.currentUser!.gender
        : 'Nam';
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      await updateController.updateField('gender', _selectedGender);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã cập nhật giới tính')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cập nhật thất bại: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const options = <String>['Nam', 'Nữ', 'Khác'];
    return Scaffold(
      appBar: AppBar(title: const Text('Đổi giới tính')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: const InputDecoration(
                labelText: 'Giới tính',
                border: OutlineInputBorder(),
              ),
              items: options
                  .map((value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedGender = value);
                }
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _save,
                child: Text(_isSaving ? 'Đang lưu...' : 'Lưu thay đổi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
