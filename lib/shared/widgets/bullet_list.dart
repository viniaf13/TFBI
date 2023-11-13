import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class BulletList extends StatelessWidget {
  const BulletList(this.strings, {super.key});
  final List<String> strings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: strings.map((str) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\u2022',
                style: context.tfbText.bodyRegularSmall,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  str,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: context.tfbText.bodyRegularSmall,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
