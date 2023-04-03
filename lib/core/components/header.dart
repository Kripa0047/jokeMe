import 'package:flutter/material.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade900,
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
