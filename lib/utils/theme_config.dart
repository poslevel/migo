import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData mainTheme = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  cardTheme: const CardTheme(
    color: Color(0xff1F212E),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      side: BorderSide(color: Colors.transparent, width: 2),
    ),
    elevation: 0,
  ),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  scaffoldBackgroundColor: const Color(0xff0C0D16),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Color(0xffffffff)),
    helperStyle: TextStyle(color: Color(0xff656E85)),
    hintStyle: TextStyle(color: Color(0xff656E85)),
    prefixIconColor: Color(0xff656E85),
    filled: true,
    isDense: true,
    fillColor: Color(0xff1F212E),
    hoverColor: Colors.black,
    border: InputBorder.none,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: Color(0xff1F212E)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: Color(0xffFF6900)),
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xFF0E0E0E),
    elevation: 0,
  ),
  //done
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.white,
    backgroundColor: Color(0xFF0E0E0E),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff0C0D16),
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.dark, // For iOS (dark icons)
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  primaryColor: const Color(0xffE5B66A),
  primaryColorDark: const Color(0xffC7984C),
  colorScheme: const ColorScheme(
    background: Color(0xff0C0D16),
    brightness: Brightness.dark,
    onBackground: Colors.white,
    primary: Color(0xffFF6900),
    onPrimary: Colors.white,
    secondary: Color(0xff2561ED),
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xff1a1a1a),
    error: Color(0xffFD4C62),
    onError: Colors.white,
  ),
  fontFamily: "Manrope",
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    elevation: 0,
    backgroundColor: Color(0xffFD4C62),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    foregroundColor: Colors.white,
  ),
  //done
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF0E0E0E),
    elevation: 0,
    selectedItemColor: Color(0xff2dadc2),
  ),
);
