import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String? value) onSubmitted;
  const TextFieldWidget({super.key, required this.controller, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        labelText: 'Task',
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      onSubmitted: (value) {
        controller.text = '';
        onSubmitted(value);
      },
    );
  }
}
