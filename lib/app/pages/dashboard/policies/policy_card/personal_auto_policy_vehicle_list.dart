import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class PersonalAutoPolicyVehicleList extends StatelessWidget {
  const PersonalAutoPolicyVehicleList(this.autoPolicyDetail, {super.key});

  final AutoPolicyDetail autoPolicyDetail;

  bool _hasExtraVehicles() => (autoPolicyDetail.vehicles.length - 3) > 0;

  int _maxVehicles() =>
      _hasExtraVehicles() ? 3 : autoPolicyDetail.vehicles.length;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.getLocalizationOf.vehicle,
          style: context.tfbText.caption,
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _maxVehicles(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: kSpacingSmall),
                child: Text(
                  autoPolicyDetail.vehicles[index].yearMakeModel,
                  style: context.tfbText.bodyRegularLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
        ),
        if (_hasExtraVehicles())
          Text(
            '+${autoPolicyDetail.vehicles.length - 3} more',
            style: context.tfbText.bodyRegularLarge,
          ),
      ],
    );
  }
}
