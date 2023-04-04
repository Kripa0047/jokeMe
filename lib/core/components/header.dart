import 'package:flutter/material.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({
    super.key,
    required this.text,
    this.icon,
    this.onIconTap,
  });

  final String text;
  final IconData? icon;
  final void Function()? onIconTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade900,
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      child: Row(
        children: [
          if (icon != null)
            GestureDetector(
              onTap: onIconTap,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (icon != null)
            Icon(
              icon,
              color: Colors.transparent,
            ),
        ],
      ),
    );
  }
}
