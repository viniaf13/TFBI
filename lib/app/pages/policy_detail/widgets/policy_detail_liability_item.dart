import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/dual_color_list/dual_color_list_item.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

final RegExp labelRegex = RegExp(r' [(].*[)]', caseSensitive: false);
final RegExp valueRegex = RegExp(r' [(]\b(each|per)\b ', caseSensitive: false);

class PolicyDetailLiabilityItem extends StatelessWidget {
  const PolicyDetailLiabilityItem({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  String _formatLabel(String label) {
    return label.replaceAll(labelRegex, '');
  }

  String _formatValue(String label, String value) {
    final formattedCurrencyValue = value.formatCurrency();

    if (labelRegex.hasMatch(label)) {
      final match = labelRegex.stringMatch(label)!;

      final replaced =
          match.replaceAll(valueRegex, '').replaceAll(')', '').toLowerCase();

      return '$formattedCurrencyValue/$replaced';
    }

    return formattedCurrencyValue;
  }

  @override
  Widget build(BuildContext context) => DualColorListItem(
        label: _formatLabel(label),
        values: [
          _formatValue(label, value),
        ],
      );
}
