import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/string_extension.dart';
import 'package:flo_wallet/core/functions/show_confirmation_dialog.dart';
import 'package:flo_wallet/core/functions/show_error_dialog.dart';
import 'package:flo_wallet/core/widgets/custom_input_scaffold.dart';
import 'package:flo_wallet/features/auth/presentation/widgets/custom_phone_number_input.dart';
import 'package:flo_wallet/features/user/presentation/cubit/user_search_cubit/user_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class UserSearchView extends StatefulWidget {
  final String currentUserId;
  final String currentUserName;
  final String currentUserPhoneNumber;
  const UserSearchView({
    super.key,
    required this.currentUserId,
    required this.currentUserName,
    required this.currentUserPhoneNumber,
  });

  @override
  State<UserSearchView> createState() => _UserSearchViewState();
}

class _UserSearchViewState extends State<UserSearchView> {
  bool isValidate = false;
  String? searchedUserPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSearchCubit, UserSearchState>(
      listener: (context, state) {
        if (state is UserSearchError) {
          showErrorDialog(context, state.errMessage);
        }
        if (state is UserSearchFound) {
          final user = state.user;
          showConfirmationDialog(
            context,
            "We found them! Would you like to start a send money to ${user.name.toFirstAndLastName()} ?",
            onConfirm: () {
              context.push(
                AppConstants.kSendMoneyAmountView,
                extra: {
                  AppExtraKeys.kSenderId: widget.currentUserId,
                  AppExtraKeys.kSenderName: widget.currentUserName,
                  AppExtraKeys.kReceiverId: user.uId,
                  AppExtraKeys.kReceiverName: user.name,
                  AppExtraKeys.kReceiverProfileImage: user.profileImageUrl,
                },
              );
            },
          );
        }
      },
      builder: (context, state) {
        return CustomInputScaffold(
          title: "Search for User",
          subtitle: "Enter the phone number to find the user.",
          body: CustomPhoneInputWidget(
            onInputValidated: (value) {
              setState(() {
                isValidate = value;
              });
            },
            onInputChanged: (PhoneNumber number) {
              searchedUserPhoneNumber = number.phoneNumber;
            },
            errorText: (!isValidate && searchedUserPhoneNumber != null)
                ? "Please enter a valid phone number"
                : null,
          ),
          onSubmit: () {
            if (searchedUserPhoneNumber != null) {
              context.read<UserSearchCubit>().findUserByPhone(
                currentUserPhoneNumber: widget.currentUserPhoneNumber,
                phoneNumber: searchedUserPhoneNumber!,
              );
            }
          },
          titleButton: "Search",
          isEnabled: isValidate,
          isLoading: state is UserSearchLoading,
        );
      },
    );
  }
}
