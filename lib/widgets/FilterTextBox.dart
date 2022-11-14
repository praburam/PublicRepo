import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FilterTextBox extends HookWidget {
  FilterTextBox({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  final textController = useTextEditingController();
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: textController,
      onChanged: (text) => onChange(text),
      decoration: const InputDecoration(hintText: 'Filter Todo'),
    );
  }
}
