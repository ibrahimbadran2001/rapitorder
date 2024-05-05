import 'package:flutter/material.dart';
import 'package:proj1/shared/style/color.dart';

final lightTheme = ThemeData.light().copyWith(
  dialogTheme: DialogTheme(
    backgroundColor: Color.fromRGBO(248, 251, 255, 1),
    surfaceTintColor: Color.fromRGBO(248, 251, 255, 1),
  ),
  appBarTheme: AppBarTheme(
    color: Color.fromRGBO(248, 251, 255, 1),
  ),
  scaffoldBackgroundColor: Color.fromRGBO(248, 251, 255, 1),
  cardColor: Colors.white,
  shadowColor: Colors.grey.withOpacity(0.5),
  textButtonTheme:TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all<Color>(Color.fromRGBO(249, 136, 31, 200)),
    )
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.all<Color>(Colors.grey[700]!),
      overlayColor: MaterialStateProperty.all<Color>(Color.fromRGBO(249, 136, 31, 200)),
    ),
  ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: defaultColor.withOpacity(0.3),
      selectionHandleColor:defaultColor.withOpacity(0.7),
    ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black,
      fontFamily: 'DmSans',
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontFamily: 'DmSans',
      fontSize: 16,
    ),
    bodySmall: TextStyle(
      color: Colors.black,
      fontFamily: 'sk',
      fontSize: 12,
    ),
    titleSmall: TextStyle(
      color: Color.fromRGBO(50, 150, 0, 1),
      fontFamily: 'DmSans',
      fontSize: 16,
    ),
  ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
     selectedItemColor: Colors.grey[800],
    )
  // Add more colors as needed
);
final darkTheme = ThemeData.dark().copyWith(
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFF212121),
      surfaceTintColor: Color(0xFF212121),
    ),
  appBarTheme: AppBarTheme(
    color: Color(0xFF424242),
  ),
  scaffoldBackgroundColor: Color(0xFF212121),
  cardColor: Color(0xFF424242),
  shadowColor: Color(0xFF0F0F0F),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.all<Color>(Colors.grey[400]!),
      overlayColor:
      MaterialStateProperty.all<Color>(Color.fromRGBO(249, 136, 31, 200)),
    ),
  ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: defaultColor.withOpacity(0.3),
      selectionHandleColor:defaultColor.withOpacity(0.7),
    ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.grey[50],
      fontFamily: 'DmSans',
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey[50],
      fontFamily: 'DmSans',
      fontSize: 16,
    ),
    bodySmall: TextStyle(
      color: Colors.grey[50],
      fontFamily: 'sk',
      fontSize: 12,
    ),
    titleSmall: TextStyle(
      color: Color.fromRGBO(120, 220, 0, 0.7),
      fontFamily: 'DmSans',
      fontSize: 16,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF424242),
    selectedItemColor: Colors.white70,
  )
  // Add more colors as needed
);
