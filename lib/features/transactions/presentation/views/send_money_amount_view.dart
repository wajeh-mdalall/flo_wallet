import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/string_extension.dart';
import 'package:flo_wallet/core/functions/show_confirmation_dialog.dart';
import 'package:flo_wallet/core/services/notification_service.dart';
import 'package:flo_wallet/core/widgets/build_section_widget.dart';
import 'package:flo_wallet/core/widgets/custom_input_scaffold.dart';
import 'package:flo_wallet/features/transactions/presentation/cubit/send_money_cubit/send_money_cubit.dart';
import 'package:flo_wallet/features/transactions/presentation/widgets/receiver_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMoneyAmountView extends StatefulWidget {
  final String senderId;
  final String senderName;
  final String receiverId;
  final String receiverName;
  final String? receiverProfileImage;
  const SendMoneyAmountView({
    super.key,
    required this.receiverId,
    required this.receiverName,
    required this.receiverProfileImage,
    required this.senderId,
    required this.senderName,
  });

  @override
  State<SendMoneyAmountView> createState() => _SendMoneyAmountViewState();
}

class _SendMoneyAmountViewState extends State<SendMoneyAmountView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  bool isEnabled = false;
  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      if (_amountController.text.trim().isNotEmpty != isEnabled) {
        setState(() {
          isEnabled = _amountController.text.trim().isNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendMoneyCubit, SendMoneyState>(
      listener: (context, state) {
        if (state is SendMoneySuccess) {
          NotificationService.showSenderSuccessNotification(
            recipientName: widget.receiverName.toFirstName(),
            amount: int.parse(_amountController.text.trim()),
          );
          Navigator.of(context).popUntil((route) {
            return route.settings.name == AppConstants.kHomeView ||
                route.isFirst;
          });
        }

        if (state is SendMoneyError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return CustomInputScaffold(
          title: "Send Money",
          subtitle: "Enter the amount you wish to transfer securely.",
          body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                ReceiverInfoCard(
                  id: widget.receiverId,
                  name: widget.receiverName.toFirstAndLastName(),
                  profileImage: widget.receiverProfileImage,
                ),
                SizedBox(height: 12),
                BuildSectionWidget(
                  title: "Amount",
                  child: TextFormField(
                    maxLength: 10,
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      // decimal: true,
                    ),
                    decoration: AppStyles.customTextFieldDecoration(
                      hintText: "0.00",
                      prefixIcon: Icons.attach_money,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter the amount';
                      }
                      final parsedAmount = int.tryParse(value.trim());
                      if (parsedAmount == null || parsedAmount <= 0) {
                        return 'Please enter a valid positive amount';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 12),
                BuildSectionWidget(
                  title: "Title",
                  child: TextFormField(
                    maxLength: 10,
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    decoration: AppStyles.customTextFieldDecoration(
                      hintText: 'e.g. Shopping, Bills, Transfer',
                      prefixIcon: Icons.description_outlined,
                    ),
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
          onSubmit: () {
            if (_formKey.currentState!.validate()) {
              final int amount = int.parse(_amountController.text.trim());
              final String title = _titleController.text.trim();
              showConfirmationDialog(
                context,
                "Are you sure you want to send \$$amount to ${widget.receiverName.toFirstName()} ?",
                onConfirm: () {
                  context.read<SendMoneyCubit>().sendMoney(
                    senderId: widget.senderId,
                    senderName: widget.senderName,
                    receiverId: widget.receiverId,
                    receiverName: widget.receiverName,
                    amount: amount,
                    title: title,
                  );
                },
              );
            }
          },
          isEnabled: isEnabled,
          isLoading: state is SendMoneyLoading,
        );
      },
    );
  }
}
