
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/base/state/base_state.dart';
import '../../core/extension/context_extension.dart';
import '../../core/extension/themedata_extension.dart';

class _WidgetForBlocProvider extends StatefulWidget {
  final double borderRadius;
  final int? minLength;
  final String labelText;
  final String? errorText;
  final IconData? suffixIcon;
  final bool? obscureText;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? suffixIconsize;
  final void Function()? onSuffix;
  final EdgeInsets? contentPadding;
  const _WidgetForBlocProvider({
    Key? key,
    required this.borderRadius,
    this.minLength,
    required this.labelText,
    this.errorText,
    this.suffixIcon,
    this.obscureText,
    this.onChanged,
    this.validator,
    this.controller,
    this.focusNode,
    this.suffixIconsize,
    this.onSuffix,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<_WidgetForBlocProvider> createState() => __WidgetForBlocProviderState();
}

class __WidgetForBlocProviderState extends BaseState<_WidgetForBlocProvider> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode= widget.focusNode ?? FocusNode();
    focusNode.addListener(() { 
      if(focusNode.hasFocus){
        context.read<DefaultTextFieldCubit>().changeSuffixColor(currentThemeData.colorScheme.primary);
      }
      else{
        context.read<DefaultTextFieldCubit>().changeSuffixColor(currentThemeData.primaryColorLight);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DefaultTextFieldCubit, Color>(
      builder: (context, state) {
        return TextFormField(
          focusNode: focusNode,
          validator: widget.validator,
          style: currentThemeData.currentAppFonts.title3,
          obscureText: widget.obscureText ?? false,
          controller: widget.controller,
          minLines: widget.minLength,
          onChanged: widget.onChanged,
          maxLines: widget.minLength == null ? 1: 12,
          decoration: InputDecoration(
            errorText: widget.errorText,
            labelText: widget.labelText,
            labelStyle: currentThemeData.currentAppFonts.onboardContent,
            suffixIcon: widget.suffixIcon == null ? null : GestureDetector(
              onTap: widget.onSuffix,
              child: Icon(widget.suffixIcon, color: state, size: 22),
            ),
            hintStyle: currentThemeData.currentAppFonts.textFieldHintStyle,
            hintText: widget.labelText,
            contentPadding: widget.contentPadding ?? EdgeInsets.only(left: context.mediumValue, bottom: 30),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide:
                  BorderSide(color: currentThemeData.primaryColorLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide:
                  BorderSide(color: currentThemeData.colorScheme.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide:
                  BorderSide(color: currentThemeData.colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide:
                  BorderSide(color: currentThemeData.colorScheme.error),
            ),
          ),
        );
      },
    );  }
}

class DefaultTextField extends StatefulWidget {
  final double borderRadius;
  final double? inputHeight;
  final int? minLength;
  final String labelText;
  final IconData? suffixIcon;
  final void Function(String value)? onChanged;
  final String?  errorText;
  final bool? obscureText;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? suffixIconsize;
  final void Function()? onSuffix;
  final EdgeInsets? contentPadding;
  const DefaultTextField({
    Key? key,
    this.borderRadius = 30,
    this.inputHeight = 70,
    this.minLength,
    required this.labelText,
    this.suffixIcon,
    this.onChanged,
    this.errorText,
    this.obscureText,
    this.validator,
    this.controller,
    this.focusNode,
    this.suffixIconsize,
    this.onSuffix,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends BaseState<DefaultTextField> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.inputHeight,
      child: BlocProvider(
        create: (context) =>
            DefaultTextFieldCubit(currentThemeData.primaryColorLight),
        child: _WidgetForBlocProvider(labelText: widget.labelText, controller: widget.controller, focusNode: widget.focusNode,suffixIcon: widget.suffixIcon, validator: widget.validator, obscureText: widget.obscureText,suffixIconsize: widget.suffixIconsize, onSuffix: widget.onSuffix, borderRadius: widget.borderRadius, minLength: widget.minLength, contentPadding: widget.contentPadding,errorText:  widget.errorText,onChanged: widget.onChanged,),
      ),
    );
  }
}

class DefaultTextFieldCubit extends Cubit<Color> {
  DefaultTextFieldCubit(super.initialState);

  void changeSuffixColor(Color color) {
    emit(color);
  }
}
