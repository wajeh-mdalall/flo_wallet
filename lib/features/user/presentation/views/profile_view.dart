import 'package:flo_wallet/core/functions/refresh_home_data.dart';
import 'package:flo_wallet/core/helper/date_helper.dart';
import 'package:flo_wallet/core/theme/cubit/theme_cubit.dart';
import 'package:flo_wallet/core/widgets/buttons/custom_app_bar_button.dart';
import 'package:flo_wallet/core/widgets/custom_card_details.dart';
import 'package:flo_wallet/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flo_wallet/core/widgets/user_avatar_display.dart';
import 'package:flo_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flo_wallet/features/user/presentation/widgets/sign_out_button.dart';
import 'package:flo_wallet/features/user/presentation/widgets/theme_switch.dart';
import 'package:flo_wallet/core/widgets/detail_tile.dart';
import 'package:flo_wallet/core/widgets/error_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import '../../../../core/constants.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final user = state.user;
        return Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(350, 50),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.18,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UserAvatarDisplay(
                        imageUrl: user?.profileImageUrl,
                        iconSize: 65,
                      ),
                      const SizedBox(height: 15),
                      user != null
                          ? Text(
                              user.name,
                              style: AppTextStyle.titleStyle(size: 22),
                            )
                          : SizedBox(height: 30),
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 10,
                  left: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAppBarButton(
                        onPressed: () {
                          refreshHomeData(context);
                        },
                        icon: Icons.refresh,
                      ),
                      if (user != null)
                        CustomAppBarButton(
                          onPressed: () {
                            context.push(
                              AppConstants.kCompleteProfile,
                              extra: {AppExtraKeys.kUser: user},
                            );
                          },
                          icon: Icons.edit,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomCardDetails(
                items: _buildProfileDetails(context, state),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildProfileDetails(BuildContext context, HomeState state) {
    final bool isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    final user = state.user;

    if (user != null) {
      return [
        DetailTile(
          icon: Icons.phone,
          title: "Mobile Number",
          value: user.phoneNumber,
        ),
        DetailTile(icon: Icons.flag, title: "Country", value: user.country),
        DetailTile(
          icon: Icons.date_range,
          title: "Date Of Birth",
          value: DateHelper.formatBirthDate(user.dateOfBirth, withAge: true),
        ),
        DetailTile(
          icon: Icons.color_lens,
          title: "Theme",
          value: isDarkMode ? "Dark Mode" : "Light Mode",
          trailing: ThemeSwitch(isDarkMode: isDarkMode),
        ),
        SignOutButton(),
      ];
    }
    if (state.status == HomeStatus.loading) {
      return const [CustomCircularProgressIndicator()];
    }
    return [ErrorTextWidget(errMessage: state.errMessage)];
  }
}
