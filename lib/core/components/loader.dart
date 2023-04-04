import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    final Color indicatorColor = Colors.grey.shade900;
    return Platform.isIOS
        ? CupertinoActivityIndicator(
            color: indicatorColor,
          )
        : CircularProgressIndicator(
            color: indicatorColor,
          );
  }
}
