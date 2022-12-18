

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../core/extension/context_extension.dart';

void loadingShowDialog(BuildContext context,) {
  showDialog(
    barrierColor: Colors.black26,
    barrierDismissible: false,
    context: context, 
    builder:(context) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.beat(color: context.currentThemeData.colorScheme.primary, size: context.getDynamicWidth(12)),
            ],
          ),
        ),
      );
    },
  );
}
