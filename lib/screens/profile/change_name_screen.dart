import 'package:flutter/material.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});
  @override
  Widget build(BuildContext context) => const _SimpleForm(title: '??i t?n');
}

class _SimpleForm extends StatelessWidget {
  final String title;
  const _SimpleForm({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title)), body: const Padding(padding: EdgeInsets.all(16), child: TextField(decoration: InputDecoration(border: OutlineInputBorder()))));
  }
}
