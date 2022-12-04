import 'package:flutter/material.dart';

Widget primaryActionButton({
  void Function()? onTap,
  required String text,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 45,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xff9c27B0),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
