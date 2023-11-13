import 'package:flutter/material.dart';

class TextFieldSemanticsWrapper extends StatelessWidget {
  const TextFieldSemanticsWrapper({
    required this.label,
    required this.child,
    super.key,
  });

  // Label is used for TalkBack/VoiceOver and should be unique. Value is used
  // for QA automated testing and should be the same as the label.
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      value: label,
      container: true,
      textField: true,
      textDirection: TextDirection.ltr,
      child: child,
    );
  }
}
