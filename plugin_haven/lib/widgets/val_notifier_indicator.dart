import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

///Value Notifier Indicator
/// takes in a value notifier and returns a percent indicator until
/// the value is finished
/// disposes of notifier when finished
class ValueNotifierIndicator extends StatefulWidget {
  const ValueNotifierIndicator({
    Key? key,
    required this.notifier,
    this.maxValue,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.red,
    this.lineHeight = 10,
    this.barRadius,
  }) : super(key: key);

  ///how we update our indicator
  final ValueNotifier<int> notifier;

  ///background color of the indicator
  final Color backgroundColor;

  ///if the notifier is not in percent format,
  /// input the max possible value here
  final int? maxValue;

  ///indicator color
  final Color progressColor;

  //decoration, default is tall and rounded
  final double lineHeight;
  final Radius? barRadius;

  @override
  State<ValueNotifierIndicator> createState() => _ValueNotifierIndicatorState();
}

class _ValueNotifierIndicatorState extends State<ValueNotifierIndicator> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.notifier,
      builder: (context, val, child) => LinearPercentIndicator(
        percent: widget.maxValue != null ? (val / widget.maxValue!) : val / 100,
        backgroundColor: widget.backgroundColor,
        progressColor: widget.progressColor,
        lineHeight: widget.lineHeight,
        barRadius: widget.barRadius ?? Radius.circular(widget.lineHeight),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.maxValue != null && widget.maxValue! == widget.notifier.value) {
      widget.notifier.dispose();
    } else {
      if (widget.notifier.value == 100) {
        widget.notifier.dispose();
      }
    }
    super.dispose();
  }
}
