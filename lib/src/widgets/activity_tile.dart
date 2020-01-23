import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_manager/src/dto/activity_response.dart';

class ActivityTile extends StatelessWidget {
  final ActivityResponse activity;

  const ActivityTile({Key key, this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: Icon(iconDataFromActivityType(activity.typeName), size: 48,),
          title: Text(activity.typeName),
          subtitle: Text(DateFormat.yMMMd().add_jm().format(activity.createdDate)),
        ),
      ),
    );
  }
}

IconData iconDataFromActivityType(String activityType) {
  switch(activityType) {
    case "Meeting": {
      return Icons.calendar_today;
    }
    case "Phone": {
      return Icons.phone;
    }
    case "Email": {
      return Icons.email;
    }
    default: {
      return Icons.calendar_today;
    }
  }
}
