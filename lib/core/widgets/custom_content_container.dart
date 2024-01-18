import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';

class CustomContentContainer extends StatelessWidget {
  const CustomContentContainer({
    super.key,
    required this.child,
    this.height,
    this.width = double.infinity,
  });

  final Widget child;
  final double? height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 8.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightWhiteBlue,
        borderRadius: BorderRadius.all(Radius.circular(45.r)),
      ),
      child: child,
    );
  }
}
