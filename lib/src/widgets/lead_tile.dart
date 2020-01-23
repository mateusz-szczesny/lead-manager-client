import 'package:flutter/material.dart';
import 'package:lead_manager/src/dto/lead.dart';
import 'package:lead_manager/src/pages/lead_details.dart';

class LeadTile extends StatelessWidget {
  final Lead lead;
  final bool disableOnTap;

  const LeadTile({Key key, this.lead, this.disableOnTap = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: Icon(Icons.people, size: 48,),
          title: Text(lead.firstName + " " + lead.lastName),
          subtitle: Text(lead.email),
          onTap: disableOnTap ? null : () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LeadDetailsPage(id: lead.id)),
            );
          },
        ),
      ),
    );
  }
}
