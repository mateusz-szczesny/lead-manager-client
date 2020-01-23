import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lead_manager/src/notifiers/lm_api.dart';
import 'package:lead_manager/src/widgets/lead_tile.dart';
import 'package:lead_manager/src/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sync),
        onPressed: () {
          var notifier =
              Provider.of<LeadManagerNotifier>(context, listen: false);
          notifier.syncActivities().then((value) {
            Fluttertoast.showToast(
                msg: "Activities synched!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }).catchError((error) {
            switch (error.runtimeType) {
              case DioError:
                // Here's the sample to get the failed response error code and message
                final Response res = (error as DioError).response;
                Fluttertoast.showToast(
                    msg: (res.data as Map)['message'],
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
        },
        elevation: 8,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          var notifier =
              Provider.of<LeadManagerNotifier>(context, listen: false);
          return notifier.refreshLeads();
        },
        child: Consumer<LeadManagerNotifier>(
          builder: (BuildContext context, LeadManagerNotifier notifier, _) {
            if (notifier.state == LeadManagerState.Idle) {
              return ListView.separated(
                itemCount: notifier.leads.length,
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(),
                itemBuilder: (BuildContext context, int index) => LeadTile(
                  lead: notifier.leads[index],
                  disableOnTap: false,
                ),
              );
            } else if (notifier.state == LeadManagerState.Loading) {
              return Loading();
            } else {
              return Loading();
            }
          },
        ),
      ),
    );
  }
}
