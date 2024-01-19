import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_get_back_button.dart';
import 'package:social_app/features/profile/presentation/widgets/current_user_info.dart';
import 'package:social_app/features/profile/presentation/widgets/current_user_posts.dart';
import 'package:social_app/features/profile/presentation/widgets/custom_pop_menu_button.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: 10.h, left: 10.w),
            sliver: const SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomGetBackButton(),
                  CustomPopMenuButton(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 77.h),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: <Widget>[
                CustomContentContainer(
                  horizontalPadding: 0,
                  height: 650.h,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      AppConstants.contentContainerRadius.r,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      const CurrentUserInfo(),
                      SizedBox(height: 16.h),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Helper.isDark(context)
                                ? AppColors.darkPrimaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(50.r),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                offset: Offset(0, -5.h),
                                blurRadius: 20.r,
                                spreadRadius: 0,
                                color: const Color(0xffD2DFE2),
                              ),
                            ],
                          ),
                          child: CurrentUserPosts(
                            uId: Helper.currentUser!.uId!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -60.h,
                  child: CachedNetworkImage(
                    imageUrl: Helper.currentUser!.image!,
                    errorWidget: (context, error, _) =>
                        const CachedImageErrorIcon(),
                    imageBuilder: (_, image) => CircleAvatar(
                      radius: 60.r,
                      backgroundColor: Helper.isDark(context)
                          ? AppColors.darkPrimaryColor
                          : AppColors.scaffoldBackgroundClr,
                      child: CircleAvatar(
                        backgroundImage: image,
                        radius: 55.r,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
