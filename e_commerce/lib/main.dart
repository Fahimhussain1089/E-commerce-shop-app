import 'package:e_commerce/screens/home.dart';
import 'package:e_commerce/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main()=> runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.appTheme,
    home: const Home(),
  )
);
