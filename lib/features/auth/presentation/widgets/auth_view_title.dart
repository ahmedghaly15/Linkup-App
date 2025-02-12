import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_text_styles.dart';

class AuthViewTitle extends StatelessWidget {
  const AuthViewTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Text(
        title,
        style: AppTextStyles.textStyle50Bold,
      ),
    );
  }
}
