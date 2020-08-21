import 'package:flutter/material.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    primaryColor: Colors.teal[700],
    primaryColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[100],
    accentColor: Colors.black,
    floatingActionButtonTheme: Theme.of(context)
        .floatingActionButtonTheme
        .copyWith(backgroundColor: Colors.teal[700]),
    accentColorBrightness: Brightness.dark,
    buttonColor: Colors.teal[700],
    hintColor: Colors.teal[700],
    backgroundColor: Colors.grey[100],
    disabledColor: Colors.blueGrey[400],
    cursorColor: Colors.teal[700],
    // primarySwatch: Colors.teal[700],
    // fontFamily: 'PT_Sans_Narrow',
    // primaryColor: Colors.white,
    // accentColor: Colors.orange,
    // hintColor: Colors.white,
    // dividerColor: Colors.white,
    // buttonColor: Colors.white,
    // scaffoldBackgroundColor: Colors.black,
    // canvasColor: Colors.black,
    // brightness: Brightness.dark,
    // secondaryHeaderColor: Colors.black,
    // canvasColor: Colors.teal[700],
    // primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
    //       color: Colors.black,
    //     ),
  );
}

ThemeData appTheme2(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: Colors.green[800],
    accentColor: Colors.blueAccent,
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          brightness: Brightness.dark,
          color: Colors.green[800],
          iconTheme: ThemeData.dark().iconTheme,
        ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue[900],
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
