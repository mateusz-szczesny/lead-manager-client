import 'package:flutter/material.dart';
import 'package:lead_manager/src/app.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() =>
    initializeDateFormatting("pl_PL", null).then((_) => runApp(App()));