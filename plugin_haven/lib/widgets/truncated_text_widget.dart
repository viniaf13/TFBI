import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

///Formats list for shortening
///   Replace 'dynamic' with object type
///   Replace 'name' with object variable you would like a list of
///   (included in file for convenience)
String stringToShortenFromObjects(List<dynamic> objects) {
  var text = '';
  for (var i = 0; i < objects.length; i++) {
    if (i == 0) {
      text += objects[i].name;
    } else {
      text += ', ${objects[i].name}';
    }
  }
  return text;
}

/// This is how we maintain our text shortening
/// Used cubit incase of future additions
class TruncatedTextCubit extends Cubit<String> {
  TruncatedTextCubit() : super('');

  int numTimesTextReduced = 0;
  String originalText = '';

  void setText(String text) => emit(text);
  String updatedOriginal(String text) => originalText = text;

  /// Shorten text and adds n+ for all items that didn't fit
  void shorten() {
    final splitted = state.split(',');

    // if (kDebugMode) {
    //   print(splitted);
    // }

    numTimesTextReduced++;
    setText('');
    for (var i = 0;
        i < splitted.length - ((numTimesTextReduced > 1) ? 2 : 1);
        i++) {
      if (i == 0) {
        setText(splitted[i].trim());
      } else {
        setText('$state, ${splitted[i].trim()}');
      }
    }
    setText('$state, $numTimesTextReduced+');
  }

  /// Start fresh to shorten a whole new (or updated) string
  void reset(String newWidgetText) {
    originalText = newWidgetText;
    numTimesTextReduced = 0;
    emit('');
  }
}

/// Class TruncatedTextWidget
/// Shortens text to fit enough items within the parent
///    all items that do not fit will be replaced by
///    "n+" where n is the number of those items
///    includes an optional loading indicator (default: on)
///
/// Can be further adapted to (for ex.) display the full text on tap
class TruncatedTextWidget extends StatefulWidget {
  const TruncatedTextWidget(
    this.data, {
    Key? key,
    this.loadingIndicator = const CircularProgressIndicator(),
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 16,
    this.maxFontSize = double.infinity,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.wrapWords = true,
    this.overflowReplacement,
    this.textScaleFactor,
    this.maxLines = 1,
    this.semanticsLabel,
    this.hasLoadingIndicator = true,
    this.textSpan,
  }) : super(key: key);

  final Key? textKey;
  final String data;
  final TextSpan? textSpan;
  final TextStyle? style;
  static const double _defaultFontSize = 16;
  final StrutStyle? strutStyle;
  final double minFontSize;
  final double maxFontSize;
  final double stepGranularity;
  final List<double>? presetFontSizes;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final bool wrapWords;
  final Widget? overflowReplacement;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;

  /// loading indicator when shortening lists, defaults to true
  final bool hasLoadingIndicator;

  /// show specific loading widget if hasLoadingIndicator wasn't declared false
  /// defaults to a basic circularprogressindicator
  final Widget loadingIndicator;

  @override
  State<TruncatedTextWidget> createState() => _TruncatedTextWidgetState();
}

class _TruncatedTextWidgetState extends State<TruncatedTextWidget> {
  TruncatedTextCubit textCubit = TruncatedTextCubit();
  bool isShortening = true;

  @override
  Widget build(BuildContext context) {
    //If original text has been updated, reset and shorten again
    if (textCubit.originalText != widget.data) {
      textCubit.reset(widget.data);
    }

    //initial state for our text
    if (textCubit.state == '' && widget.data != '') {
      isShortening = true;
      textCubit.setText(widget.data);
    }

    return LayoutBuilder(
      builder: (context, size) {
        final defaultTextStyle = DefaultTextStyle.of(context);
        var style = widget.style;
        if (widget.style == null || widget.style!.inherit) {
          style = defaultTextStyle.style.merge(widget.style);
        }
        if (style!.fontSize == null) {
          style =
              style.copyWith(fontSize: TruncatedTextWidget._defaultFontSize);
        }
        final maxLines = widget.maxLines ?? defaultTextStyle.maxLines;
        _validateProperties(style, maxLines);
        final result = _calculateFontSize(size, style, maxLines);
        final fontSize = result[0] as double;
        final textFits = result[1] as bool;

        if (!textFits) {
          SchedulerBinding.instance
              .addPostFrameCallback((_) => setState(() => textCubit.shorten()));
        } else {
          isShortening = false;
        }
        //If we are still shortening
        if (isShortening && widget.hasLoadingIndicator) {
          //FittedBox to make sure loadingIndicator conforms to parent constraints
          return FittedBox(
            fit: BoxFit.scaleDown,
            child: widget.loadingIndicator,
          );
        }
        return _buildText(fontSize, style, maxLines);
      },
    );
  }

  // IGNORE EVERYTHING BEYOND THIS POINT, ALL UTILITY --------------------------
  // DO NOT CHANGE
  void _validateProperties(TextStyle style, int? maxLines) {
    assert(
      maxLines == null || maxLines > 0,
      'MaxLines must be greater than or equal to 1.',
    );
    assert(
      widget.key == null || widget.key != widget.textKey,
      'Key and textKey must not be equal.',
    );

    if (widget.presetFontSizes == null) {
      assert(
          widget.stepGranularity >= 0.1,
          'StepGranularity must be greater than or equal to 0.1. It is not a '
          'good idea to resize the font with a higher accuracy.');
      assert(
        widget.minFontSize >= 0,
        'MinFontSize must be greater than or equal to 0.',
      );
      assert(widget.maxFontSize > 0, 'MaxFontSize has to be greater than 0.');
      assert(
        widget.minFontSize <= widget.maxFontSize,
        'MinFontSize must be smaller or equal than maxFontSize.',
      );
      assert(
        widget.minFontSize / widget.stepGranularity % 1 == 0,
        'MinFontSize must be a multiple of stepGranularity.',
      );
      if (widget.maxFontSize != double.infinity) {
        assert(
          widget.maxFontSize / widget.stepGranularity % 1 == 0,
          'MaxFontSize must be a multiple of stepGranularity.',
        );
      }
    } else {
      assert(
        widget.presetFontSizes!.isNotEmpty,
        'PresetFontSizes must not be empty.',
      );
    }
  }

  List _calculateFontSize(
    BoxConstraints size,
    TextStyle? style,
    int? maxLines,
  ) {
    final span = TextSpan(
      style: widget.textSpan?.style ?? style,
      text: widget.textSpan?.text ?? textCubit.state,
      children: widget.textSpan?.children,
      recognizer: widget.textSpan?.recognizer,
    );

    final userScale =
        widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);

    int left;
    int right;

    final presetFontSizes = widget.presetFontSizes?.reversed.toList();
    if (presetFontSizes == null) {
      final num defaultFontSize =
          style!.fontSize!.clamp(widget.minFontSize, widget.maxFontSize);
      final defaultScale = defaultFontSize * userScale / style.fontSize!;
      if (_checkTextFits(span, defaultScale, maxLines, size)) {
        return <Object>[defaultFontSize * userScale, true];
      }

      left = (widget.minFontSize / widget.stepGranularity).floor();
      right = (defaultFontSize / widget.stepGranularity).ceil();
    } else {
      left = 0;
      right = presetFontSizes.length - 1;
    }

    var lastValueFits = false;
    while (left <= right) {
      final mid = (left + (right - left) / 2).floor();
      double scale;
      if (presetFontSizes == null) {
        scale = mid * userScale * widget.stepGranularity / style!.fontSize!;
      } else {
        scale = presetFontSizes[mid] * userScale / style!.fontSize!;
      }
      if (_checkTextFits(span, scale, maxLines, size)) {
        left = mid + 1;
        lastValueFits = true;
      } else {
        right = mid - 1;
      }
    }

    if (!lastValueFits) {
      right += 1;
    }

    double fontSize;
    if (presetFontSizes == null) {
      fontSize = right * userScale * widget.stepGranularity;
    } else {
      fontSize = presetFontSizes[right] * userScale;
    }

    return <Object>[fontSize, lastValueFits];
  }

  bool _checkTextFits(
    TextSpan text,
    double scale,
    int? maxLines,
    BoxConstraints constraints,
  ) {
    if (!widget.wrapWords) {
      final words = text.toPlainText().split(RegExp('\\s+'));

      final wordWrapTextPainter = TextPainter(
        text: TextSpan(
          style: text.style,
          text: words.join('\n'),
        ),
        textAlign: widget.textAlign ?? TextAlign.left,
        textDirection: widget.textDirection ?? TextDirection.ltr,
        textScaleFactor: scale,
        maxLines: words.length,
        locale: widget.locale,
        strutStyle: widget.strutStyle,
      );

      wordWrapTextPainter.layout(maxWidth: constraints.maxWidth);

      if (wordWrapTextPainter.didExceedMaxLines ||
          wordWrapTextPainter.width > constraints.maxWidth) {
        return false;
      }
    }

    final textPainter = TextPainter(
      text: text,
      textAlign: widget.textAlign ?? TextAlign.left,
      textDirection: widget.textDirection ?? TextDirection.ltr,
      textScaleFactor: scale,
      maxLines: maxLines,
      locale: widget.locale,
      strutStyle: widget.strutStyle,
    );

    textPainter.layout(maxWidth: constraints.maxWidth);

    return !(textPainter.didExceedMaxLines ||
        textPainter.height > constraints.maxHeight ||
        textPainter.width > constraints.maxWidth);
  }

  Widget _buildText(double fontSize, TextStyle style, int? maxLines) {
    return Text(
      textCubit.state,
      key: widget.textKey,
      style: style.copyWith(fontSize: fontSize),
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      locale: widget.locale,
      softWrap: widget.softWrap,
      overflow: null,
      textScaleFactor: 1,
      maxLines: maxLines,
      semanticsLabel: widget.semanticsLabel,
    );
  }
}
