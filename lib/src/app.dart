import 'package:flutter/material.dart';
import 'package:lead_manager/src/api/api.dart';
import 'package:lead_manager/src/notifiers/lm_api.dart';
import 'package:lead_manager/src/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Injector(
      key: Key("APP_INJECTOR"),
      child: MaterialApp(
        title: 'Lead Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(title: 'Lead Manager'),
      ),
    );
  }
}

class Injector extends StatelessWidget {
final Widget child;

const Injector({Key key, this.child}) : super(key: key);

@override
Widget build(BuildContext context) {
  return MultiProvider(
    key: super.key,
    providers: [
      ChangeNotifierProvider<LeadManagerNotifier>(
        create: (context) => LeadManagerNotifier(
          client: ApiClient(Dio()),
        ),
      ),
    ],
    child: this.child,
  );
}
}
