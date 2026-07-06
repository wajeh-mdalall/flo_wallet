import 'package:flutter/material.dart';
import '../../../../core/constants.dart';
import 'package:country_picker/country_picker.dart';

class CountryDropdownFormField extends StatefulWidget {
  final TextEditingController controller;

  const CountryDropdownFormField({super.key, required this.controller});

  @override
  State<CountryDropdownFormField> createState() =>
      _CountryDropdownFormFieldState();
}

class _CountryDropdownFormFieldState extends State<CountryDropdownFormField> {
  final List<Country> _countries = CountryService().getAll();
  Country? _selectedCountry;
  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isNotEmpty) {
      _selectedCountry = Country.parse(widget.controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Country>(
      validator: (value) {
        if (value == null) {
          return "required";
        }
        return null;
      },
      hint: Text("Country", style: ApptextStyle.hintTextStyle()),
      decoration: AppStyles.customTextFieldDecoration(
        prefixIcon: Icons.public,
        contentPaddingHorizontal: 0,
      ),
      borderRadius: BorderRadius.circular(25),
      isExpanded: true,
      initialValue: _selectedCountry,
      items: _countries.map((Country country) {
        return DropdownMenuItem<Country>(
          value: country,
          child: Text(
            "${country.flagEmoji}  ${country.name}",
            style: ApptextStyle.titleStyle(size: 14),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: (Country? newValue) {
        setState(() {
          _selectedCountry = newValue;
          widget.controller.text = newValue?.name ?? "";
        });
      },
    );
  }
}
