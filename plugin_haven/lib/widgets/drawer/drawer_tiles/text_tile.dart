import 'package:flutter/material.dart';

///TextTile
/// one or more text buttons with optional indent
class TextTile extends StatelessWidget {
  const TextTile({
    Key? key,
    required this.textItems,
    this.indent = false,
  }) : super(key: key);

  //lines of text with associated functions/navigations
  final Map<String, Function()> textItems;
  //left indent
  final bool indent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: indent ? 15.0 : 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...textItems.entries
              .map(
                (mapEntry) => Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: TextButton(
                    style: TextButton.styleFrom(),
                    onPressed: () {
                      mapEntry.value();
                    },
                    child: Text(
                      mapEntry.key,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF111111),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
