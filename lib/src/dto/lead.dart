import 'package:json_annotation/json_annotation.dart';
import 'package:lead_manager/src/dto/activity_response.dart';

part 'lead.g.dart';

@JsonSerializable()
class Lead {
  int id;
  String firstName;
  String lastName;
  String email;
  List<ActivityResponse> activities;
  bool active;
  DateTime createdDate;
  DateTime updatedDate;

  Lead({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.active,
    this.createdDate,
    this.updatedDate,
  }) : this.activities = List<ActivityResponse>();

  factory Lead.fromJson(Map<String, dynamic> json) => _$LeadFromJson(json);
  Map<String, dynamic> toJson() => _$LeadToJson(this);
}
