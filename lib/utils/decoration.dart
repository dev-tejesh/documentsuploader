import 'package:flutter/material.dart';

InputDecoration inputDecoration(
    {required String hintText,
      
    // String? helperText,
    Widget? prefixIcon}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    hintText: hintText,
    filled: true, //<-- SEE HERE
    fillColor: Colors.grey[100],
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25)),
    hintStyle: const TextStyle(color: Colors.black26),
  );
  // return InputDecoration(
  //   label: Text(label),
  //   hintText: hintText,
  //   prefixIcon: prefixIcon,
  // );
}
