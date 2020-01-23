// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityRequest _$ActivityRequestFromJson(Map<String, dynamic> json) {
  return ActivityRequest(
    leadId: json['leadId'] as int,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$ActivityRequestToJson(ActivityRequest instance) =>
    <String, dynamic>{
      'leadId': instance.leadId,
      'type': instance.type,
    };
