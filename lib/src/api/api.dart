import 'package:lead_manager/src/dto/activity_request.dart';
import 'package:lead_manager/src/dto/activity_response.dart';
import 'package:lead_manager/src/dto/lead.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api.g.dart';

@RestApi(baseUrl: "http://mszczesny.com:9001")
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  /// Request for all leads
  @GET("/lead")
  Future<List<Lead>> getAllLeads();

  /// Request for single lead by its id
  @GET("/lead/{id}")
  Future<Lead> getLeadById(@Path("id") int id);

  /// Request for create new activity
  @POST("/activity")
  Future<ActivityResponse> createActivity(@Body() ActivityRequest request);

  /// Request for sync activities
  @GET("/activity/sync")
  Future<void> syncActivities();

  /// Request for single lead by its id
  @GET("/activity/{id}")
  Future<ActivityResponse> getActivityById(@Path("id") int id);

  /// Request for single lead by its id
  @GET("/activity/lead={id}")
  Future<List<ActivityResponse>> getActivitiesByLeadId(@Path("id") int id);
}
