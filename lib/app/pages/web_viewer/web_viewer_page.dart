import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewerPage extends StatefulWidget {
  const WebViewerPage({required this.uri, super.key});

  final Uri uri;

  @override
  State<WebViewerPage> createState() => _WebViewerPageState();
}

class _WebViewerPageState extends State<WebViewerPage> {
  void open(Uri uri) {
    final ChromeSafariBrowser browser = ChromeSafariBrowser();
    if (Platform.isAndroid || Platform.isIOS) {
      browser.open(
        url: uri,
        options: ChromeSafariBrowserClassOptions(
          ios: IOSSafariOptions(
            barCollapsingEnabled: true,
          ),
        ),
      );
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => open(widget.uri));
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
