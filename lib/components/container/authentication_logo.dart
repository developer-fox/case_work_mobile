
import 'package:flutter/material.dart';
import '../../core/extension/context_extension.dart';

class AuthenticationPageLogo extends StatelessWidget {
  const AuthenticationPageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.sunny_snowing, size: context.getDynamicWidth(14));
  }
}


