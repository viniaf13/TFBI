import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class BillingPageViewPage<T> extends StatelessWidget {
  const BillingPageViewPage({
    required this.items,
    required this.itemBuilder,
    super.key,
  });

  final List<T> items;
  final Widget Function(T item) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kSpacingMedium,
        ),
        child: Column(
          children: items.map(itemBuilder).toList(),
        ),
      ),
    );
  }
}
