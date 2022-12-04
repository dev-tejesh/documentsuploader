import 'package:flutter/material.dart';

AppBar appbar(String title){
  return AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(title),
        backgroundColor: const Color(0xff00796B),
      );
}