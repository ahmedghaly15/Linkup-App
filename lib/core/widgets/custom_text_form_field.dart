import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.keyboardType,
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.label,
    this.hintText,
    this.onSubmit,
    this.borderRadius,
    this.onSaved,
    this.autofillHints,
    this.isEmail = false,
    this.enabled = true,
    this.textAlign,
    this.maxLength,
    this.onChanged,
    this.contentPadding,
    this.onTap,
    this.focusNode,
    this.onEditingComplete,
    this.textCapitalization = TextCapitalization.none,
    this.validating,
    this.enabledBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.errorBorder,
    this.border,
    this.fillColor,
    this.hintStyle,
    this.autofocus = false,
    this.disabledBorder,
    this.prefixIcon,
    this.maxLines = 1,
    this.enableSuggestions = true,
    this.hasPrefixIcon = true,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;
  final bool isEmail;
  final bool? enabled;
  final String? label;
  final List<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final Function(String submittedText)? onSubmit;
  final Function(String? value)? onSaved;
  final void Function()? onTap;
  final String? hintText;
  final TextAlign? textAlign;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validating;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? border;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final bool autofocus;
  final IconData? prefixIcon;
  final int? maxLines;
  final bool enableSuggestions;
  final bool hasPrefixIcon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemeData>(
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          autofocus: autofocus,
          enableSuggestions: enableSuggestions,
          textCapitalization: textCapitalization,
          textAlign: textAlign ?? TextAlign.start,
          keyboardType: keyboardType ?? TextInputType.text,
          obscureText: obscureText,
          maxLength: maxLength,
          onSaved: onSaved,
          onTap: onTap,
          autofillHints: autofillHints,
          onFieldSubmitted: onSubmit,
          onChanged: onChanged,
          style: _customTextFieldTextStyle(),
          maxLines: maxLines,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ??
                (state.brightness == Brightness.light
                    ? AppColors.scaffoldBackgroundClr
                    : AppColors.darkGreyClr),
            errorStyle: TextStyle(fontSize: 13.sp, color: Colors.red),
            hintText: hintText,
            hintStyle: hintStyle ?? _customTextFieldTextStyle(),
            errorMaxLines: null,
            prefix: prefix,
            prefixIcon:
                hasPrefixIcon ? Icon(prefixIcon, color: Colors.grey) : null,
            suffixIcon: suffix,
            labelText: label,
            labelStyle: Theme.of(context).textTheme.titleSmall,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
            enabledBorder: enabledBorder ?? _buildUnderlineInputBorder(),
            focusedBorder: focusedBorder ??
                _buildUnderlineInputBorder(
                  borderColor: AppColors.primaryColor,
                ),
            errorBorder: errorBorder ?? _buildUnderlineInputBorder(),
            focusedErrorBorder:
                focusedErrorBorder ?? _buildUnderlineInputBorder(),
            border: border ?? _buildUnderlineInputBorder(),
            disabledBorder: disabledBorder,
          ),
          validator: validating,
          onEditingComplete: onEditingComplete,
        );
      },
    );
  }

  TextStyle _customTextFieldTextStyle() {
    return AppTextStyles.textStyle18;
  }

  OutlineInputBorder _buildUnderlineInputBorder({Color? borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: borderColor ?? Colors.grey,
        width: 2,
      ),
    );
  }
}
