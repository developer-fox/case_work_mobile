
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/extension/context_extension.dart';
import '../../core/extension/string_extension.dart';

import '../../../core/init/language/locale_keys.g.dart';

class LoginInvalidInformationsDialog extends StatefulWidget {
  final String message;
  const LoginInvalidInformationsDialog({Key? key, required this.message}) : super(key: key);

  @override
  State<LoginInvalidInformationsDialog> createState() => _LoginInvalidInformationsDialogState();
}

class _LoginInvalidInformationsDialogState extends State<LoginInvalidInformationsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:   FaIcon(FontAwesomeIcons.xmark, color: context.currentThemeData.colorScheme.error),
      content: Text(widget.message, style: context.currentThemeData.textTheme.titleSmall),
      actions: [
        TextButton(
          onPressed: ()=> Navigator.of(context).pop(),
          child: Text(LocaleKeys.okey.locale, style: context.currentThemeData.textTheme.caption?.copyWith(color: context.currentThemeData.colorScheme.error)),
        )
      ],
    );
  }
}
