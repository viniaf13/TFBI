import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/repositories/submit_photo_repository.dart';
import 'package:workmanager/workmanager.dart';

const ksubmitPhotoTask = 'com.txfb-ins.txfb1.submitPhoto';

@pragma(
  'vm:entry-point',
)
void workManagerDispatcher() {
  Workmanager().executeTask((task, data) async {
    bool result = false;
    switch (task) {
      case ksubmitPhotoTask:
        result = await SubmitPhotoRepository().importPhoto();
        break;
      default:
    }
    return Future.value(result);
  });
}
