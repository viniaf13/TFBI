//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.

import 'package:equatable/equatable.dart';

/// Abstract class that [AuthBloc] uses to pass user objects.
/// Derive application specific user classes from [HavenUser]
abstract class HavenUser extends Equatable {
  @override
  List<Object?> get props => const [];
}
