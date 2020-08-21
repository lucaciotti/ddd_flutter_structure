import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:ddd_flutter_structure/code/injectable/injection.dart';
import 'package:ddd_flutter_structure/ui/app_main_widget.dart';

void main() {
  configureInjection(Environment.prod);
  runApp(const AppMainWidget());
}
