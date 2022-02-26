import 'package:flutter/material.dart';

Color kPrimaryColor = Color(0xFF166DE0);
Color kConfirmedColor = Color(0xFFFF1242);
Color kActiveColor = Color(0xFF017BFF);
Color kRecoveredColor = Color(0xFF29A746);
Color kDeathColor = Color(0xFF6D757D);

LinearGradient kGradientShimmer = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color.fromARGB(255, 224, 224, 224),
    Color.fromARGB(255, 245, 245, 245),
  ],
);

RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]}.';