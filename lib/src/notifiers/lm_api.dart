import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lead_manager/src/api/api.dart';
import 'package:lead_manager/src/dto/activity_request.dart';
import 'package:lead_manager/src/dto/activity_response.dart';
import 'package:lead_manager/src/dto/lead.dart';
import 'package:dio/dio.dart';

enum LeadManagerState { Loading, Idle }

class LeadManagerNotifier extends ChangeNotifier {
  final ApiClient _client;
  LeadManagerState state = LeadManagerState.Idle;
  List<Lead> _leads = List<Lead>();

  UnmodifiableListView<Lead> get leads => UnmodifiableListView(this._leads);

  LeadManagerNotifier({client}) : _client = client {
    scheduleMicrotask(() => fetchLeads());
  }

  Future refreshLeads() {
    return fetchLeads();
  }

  Future syncActivities() {
    return _client.syncActivities();
  }

  Future fetchLeads() {
    this.state = LeadManagerState.Loading;
    notifyListeners();

    return _client
        .getAllLeads()
        .then(
          (leads) {
            this._leads = leads;
            notifyListeners();
          },
        )
        .catchError(
          (error) => print(error.toString()),
        )
        .whenComplete(() => this.state = LeadManagerState.Idle);
  }

  Future<Lead> getSingleLeadById(int id) {
    return _client.getLeadById(id);
  }

  Future<ActivityResponse> recordActivity(int leadId, String activityType) {
    var activityRequest = ActivityRequest(leadId: leadId, type: activityType);
    return _client.createActivity(activityRequest).then(
      (value) {
        notifyListeners();
        return value;
      },
    ).catchError((error) {
      switch (error.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final Response res = (error as DioError).response;
          Fluttertoast.showToast(
              msg: res.toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          break;
        default:
      }
    });
  }

  Future<List<ActivityResponse>> getActivitiesByLeadId(int leadId) {
    return _client.getActivitiesByLeadId(leadId);
  }

  Future<Lead> updateLead(int id) async {
    var newLead = await getSingleLeadById(id);
    for (var i = 0; i < _leads.length; i++) {
      if (_leads[i].id == newLead.id) {
        _leads[i] = newLead;
        break;
      }
    }
    notifyListeners();
    return newLead;
  }
}
