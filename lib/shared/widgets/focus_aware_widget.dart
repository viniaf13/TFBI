import 'package:flutter/material.dart';

abstract class FocusAwareWidgetState<T extends StatefulWidget>
    extends State<T> {
  late final FocusNode focusNode;
  late final formFieldKey = GlobalKey<FormFieldState<dynamic>>();
  bool hasLostFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          hasLostFocus = true;
        });

        validateOnNextFrame();
      }
    });
  }

  void validateOnNextFrame() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      formFieldKey.currentState?.validate();
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
