import 'package:json_annotation/json_annotation.dart';

part 'activity_request.g.dart';

@JsonSerializable()
class ActivityRequest {
  int leadId;
  String type;

  ActivityRequest({this.leadId, this.type});

  factory ActivityRequest.fromJson(Map<String, dynamic> json) =>
      _$ActivityRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityRequestToJson(this);
}
