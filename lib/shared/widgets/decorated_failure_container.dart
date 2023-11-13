import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container.dart';

class DecoratedFailureContainer extends StatelessWidget {
  const DecoratedFailureContainer({
    required this.errorDescription,
    super.key,
  });

  final String errorDescription;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DecoratedContainer(
            child: Text(
              errorDescription,
              style: context.tfbText.caption.copyWith(
                color: TfbBrandColors.redHigh,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
