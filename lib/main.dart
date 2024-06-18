import 'package:flutter/material.dart';
import 'package:new_tracker/Widgets/expenses.dart';

var kcolorscheme= ColorScheme.fromSeed(seedColor: Color.fromARGB(255,96,59,181));
var kdarkcoloscheme=ColorScheme.fromSeed(seedColor: Color.fromARGB(155,5,99,125),);
void main(){
  runApp(
     MaterialApp(
       darkTheme: ThemeData.dark().copyWith(useMaterial3: true,colorScheme: kdarkcoloscheme ,brightness: Brightness.dark),
      theme: ThemeData()
          .copyWith(useMaterial3: true,
          colorScheme: kcolorscheme,
          appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kcolorscheme.onPrimaryContainer,
          foregroundColor: kcolorscheme.onSecondary
      ),
          cardTheme: CardTheme().copyWith(color: kcolorscheme.secondaryContainer,
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10)
          ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kcolorscheme.primaryContainer)),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20))
      ),
      themeMode: ThemeMode.light,//default
      home:Expenses(),
    ),
  );
}