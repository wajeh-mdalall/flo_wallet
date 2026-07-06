import 'package:flo_wallet/core/extensions/theme_extension.dart';
import '../../../../core/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CustomPhoneInputWidget extends StatelessWidget {
  final void Function(PhoneNumber)? onInputChanged;
  final void Function(bool)? onInputValidated;
  final String? errorText;
  const CustomPhoneInputWidget({
    super.key,
    this.onInputChanged,
    this.onInputValidated,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputValidated: onInputValidated,
      onInputChanged: onInputChanged,
      cursorColor: context.colors.primary,
      textStyle: ApptextStyle.inputTextStyle(),
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
        setSelectorButtonAsPrefixIcon: true,
        showFlags: true,
        useEmoji: true,
        trailingSpace: false,
      ),
      initialValue: PhoneNumber(isoCode: 'AE'),
      formatInput: true,
      keyboardType: TextInputType.phone,
      inputDecoration: AppStyles.customTextFieldDecoration(
        hintText: "Mobile number",
        errorText: errorText,
      ),
      selectorTextStyle: ApptextStyle.inputTextStyle(),
    );
  }
}
