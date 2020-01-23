import 'package:json_annotation/json_annotation.dart';

part 'activity_response.g.dart';

@JsonSerializable()
class ActivityResponse {
  int id;
  int leadId;
  int type;
  String typeName;
  DateTime createdDate;
  DateTime updatedDate;

  ActivityResponse({
    this.id,
    this.leadId,
    this.type,
    this.createdDate,
    this.updatedDate,
    this.typeName,
  });

  factory ActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityResponseToJson(this);
}

enum ActivityType { Meeting, Phone, Email }
