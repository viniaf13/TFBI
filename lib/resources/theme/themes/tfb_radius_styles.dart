import 'package:flutter/material.dart';

class TfbRadiusStyles {
  BorderRadius defaultRadius = const BorderRadius.all(Radius.circular(16));
  BorderRadius defaultRadiusTop = const BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
  );
  BorderRadius defaultRadiusBottom = const BorderRadius.vertical(
    bottom: Radius.circular(16),
  );
  BorderRadius largeRadius = const BorderRadius.all(Radius.circular(20));

  BorderRadius small = const BorderRadius.all(Radius.circular(8));
  BorderRadius tiny = const BorderRadius.all(Radius.circular(4));
}
