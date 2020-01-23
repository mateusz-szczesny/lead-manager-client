import 'package:flutter/material.dart';
import 'package:lead_manager/src/dto/activity_response.dart';
import 'package:lead_manager/src/dto/lead.dart';
import 'package:lead_manager/src/notifiers/lm_api.dart';
import 'package:lead_manager/src/utils/activity_utils.dart';
import 'package:lead_manager/src/widgets/activity_tile.dart';
import 'package:lead_manager/src/widgets/lead_tile.dart';
import 'package:lead_manager/src/widgets/loading.dart';
import 'package:provider/provider.dart';

class LeadDetailsPage extends StatelessWidget {
  final int id;

  const LeadDetailsPage({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              child: new AlertDialog(
                title: new Text("Record activity"),
                content: RecordActivity(
                  leadId: id,
                ),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<Lead>(
        initialData: Lead(),
        future: Provider.of<LeadManagerNotifier>(context, listen: true)
            .getSingleLeadById(id),
        builder: (BuildContext context, AsyncSnapshot<Lead> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('No lead to display.');
            case ConnectionState.active:
              return Loading();
            case ConnectionState.waiting:
              return Loading();
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LeadTile(
                        lead: snapshot.data,
                        disableOnTap: true,
                      ),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: snapshot.data.activities.isEmpty
                        ? Center(
                            child: Text(
                                'No activities to display. Add one with button below!'))
                        : ListView.builder(
                            itemCount: snapshot.data.activities.length,
                            itemBuilder: (BuildContext context, int index) =>
                                ActivityTile(
                              activity: snapshot.data.activities[index],
                            ),
                          ),
                  ),
                ],
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}

class RecordActivity extends StatefulWidget {
  final int leadId;

  const RecordActivity({Key key, this.leadId}) : super(key: key);

  @override
  _RecordActivityState createState() => _RecordActivityState();
}

class _RecordActivityState extends State<RecordActivity> {
  String activityType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropdownButton<String>(
          value: activityType,
          onChanged: (value) {
            setState(() {
              this.activityType = value;
            });
          },
          items: ActivityType.values.map(
            (ActivityType activityType) {
              return DropdownMenuItem<String>(
                value: activityType2String(activityType),
                child: Text(
                  activityType2String(activityType),
                ),
              );
            },
          ).toList(),
        ),
        Spacer(),
        RaisedButton(
          onPressed: activityType != null ? submit : null,
          child: Text("Submit"),
        )
      ],
    );
  }

  void submit() async {
    LeadManagerNotifier notifier =
        Provider.of<LeadManagerNotifier>(context, listen: false);
    await notifier.recordActivity(widget.leadId, this.activityType);
  }
}
