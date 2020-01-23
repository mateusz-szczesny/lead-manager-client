import 'package:lead_manager/src/dto/activity_response.dart';

String activityType2String(ActivityType activityType) {
  return activityType.toString().split('.')[1];
}
