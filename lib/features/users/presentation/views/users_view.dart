import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/body_loading_indicator.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';
import 'package:social_app/features/users/presentation/widgets/empty_user_view.dart';
import 'package:social_app/features/users/presentation/widgets/user_item.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final UserCubit cubit = BlocProvider.of<UserCubit>(context);

        if (state is GetAllUsersLoading) {
          return const Center(
            child: BodyLoadingIndicator(),
          );
        } else if (state is GetAllUserSuccess) {
          return cubit.users.isNotEmpty
              ? SafeArea(
                  child: GridView.builder(
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 650),
                        columnCount: cubit.users.length,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: UserItem(
                              user: cubit.users[index],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: cubit.users.length,
                    padding: EdgeInsets.only(
                      left: 15.w,
                      right: 15.w,
                      bottom: 10.h,
                    ),
                    scrollDirection: Axis.vertical,
                    reverse: false,
                    primary: true,
                    shrinkWrap: true,
                    physics: AppConstants.physics,
                    dragStartBehavior: DragStartBehavior.start,
                    clipBehavior: Clip.hardEdge,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300.w,
                      mainAxisExtent: 220.h,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      childAspectRatio: 3 / 2,
                    ),
                  ),
                )
              : const EmptyUsersView();
        } else if (state is GetAllUserError) {
          return SliverFillRemaining(
            child: CustomErrorWidget(
              onPressed: () => cubit.getAllUsers(),
              error: state.error,
            ),
          );
        } else {
          return const EmptyUsersView();
        }
      },
    );
  }
}
