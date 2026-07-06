import 'package:flo_wallet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flo_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void refreshHomeData(BuildContext context) {
                  final authState =
                  context.read<AuthCubit>().state as Authenticated;
              final String uId = authState.authUser.uId;
    context.read<HomeCubit>().fetchHomeData(uId: uId);
  }