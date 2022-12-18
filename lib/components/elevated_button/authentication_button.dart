
import 'package:flutter/material.dart';
import '../../core/base/state/base_state.dart';
import '../../core/extension/context_extension.dart';
import '../../core/extension/themedata_extension.dart';

class AuthenticationButton extends StatefulWidget {
  final String title;
  final void Function()? onPressed;
  const AuthenticationButton({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  State<AuthenticationButton> createState() => _AuthenticationButtonState();
}

class _AuthenticationButtonState extends BaseState<AuthenticationButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       width: double.maxFinite,
       height: context.getDynamicWidth(11.2),
       child: ElevatedButton(
         onPressed: widget.onPressed,
         style: ElevatedButton.styleFrom(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(30),
           ),
           elevation: 2
          ),
          child: Text(widget.title, style: currentThemeData.currentAppFonts.elevatedButtonTextStyle,),
        ),
    );
  }
}

