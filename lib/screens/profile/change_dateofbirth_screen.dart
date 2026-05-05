import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/login_controller.dart';
import '../../controller/update_account_controller.dart';

class ChangeDateOfBirthScreen extends StatefulWidget {
  const ChangeDateOfBirthScreen({super.key});

  @override
  State<ChangeDateOfBirthScreen> createState() => _ChangeDateOfBirthScreenState();
}

class _ChangeDateOfBirthScreenState extends State<ChangeDateOfBirthScreen> {
  final AuthController authController = Get.find<AuthController>();
  final UpdateAccountController updateController = Get.find<UpdateAccountController>();
  DateTime? _selectedDate;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final dateText = authController.currentUser?.dateOfBirth ?? '';
    if (dateText.isNotEmpty) {
      _selectedDate = DateTime.tryParse(dateText);
    }
  }

  String get _displayDate {
    if (_selectedDate == null) return 'Chưa chọn ngày sinh';
    final d = _selectedDate!;
    final day = d.day.toString().padLeft(2, '0');
    final month = d.month.toString().padLeft(2, '0');
    return '$day/$month/${d.year}';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: now,
      initialDate: _selectedDate ?? DateTime(2000, 1, 1),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _save() async {
    if (_selectedDate == null) return;
    setState(() => _isSaving = true);
    try {
      await updateController.updateField('dateOfBirth', _selectedDate!.toIso8601String());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã cập nhật ngày sinh')),
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
    return Scaffold(
      appBar: AppBar(title: const Text('Đổi ngày sinh')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(_displayDate),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSaving ? null : _save,
              child: Text(_isSaving ? 'Đang lưu...' : 'Lưu thay đổi'),
            ),
          ],
        ),
      ),
    );
  }
}
