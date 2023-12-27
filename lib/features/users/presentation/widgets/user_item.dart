import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';

class UserItem extends StatelessWidget {
  const UserItem({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0.r),
      ),
      color: AppColors.primaryColor.withOpacity(0.6),
      elevation: 10.h,
      shadowColor: Colors.black,
      child: MaterialButton(
        onPressed: () {
          context.navigateTo(
            routeName: Routes.userProfileRoute,
            arguments: user,
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: user.image!,
              imageBuilder: (_, image) {
                return CircleAvatar(
                  backgroundImage: image,
                  radius: 55.r,
                  backgroundColor: AppColors.primaryColor,
                );
              },
              errorWidget: (context, error, _) => const CachedImageErrorIcon(),
            ),
            SizedBox(height: 8.h),
            Flexible(
              child: Text(
                user.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.textStyle20Bold.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.touch_app,
                  color: Colors.white,
                  size: 22.w,
                ),
                SizedBox(width: 5.w),
                Text(
                  "Visit",
                  style: AppTextStyles.textStyle16.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
