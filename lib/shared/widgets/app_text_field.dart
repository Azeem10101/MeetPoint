import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
