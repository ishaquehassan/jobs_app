import 'package:flutter/material.dart';
import 'package:jobs_app/src/configs/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String placeholder;
  final bool isPasswordField;
  final bool isMultiLine;
  final TextEditingController controller;
  final ValueChanged<String> validator;
  final ValueChanged<String> onFieldSubmit;

  const AppTextField(
      {@required this.placeholder,
      this.validator,
      this.controller,
      this.onFieldSubmit,
      this.isPasswordField = false,
      this.isMultiLine = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.fieldBgColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.fieldBorderColor)),
      padding: EdgeInsets.all(20),
      child: TextFormField(
        minLines: isMultiLine ? 13 : 1,
        maxLines: isMultiLine ? 13 : 1,
        validator: validator,
        controller: controller,
        obscureText: isPasswordField,
        onFieldSubmitted: onFieldSubmit,
        decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
              color: AppColors.textColorDark,
              fontSize: 15,
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero),
      ),
    );
  }
}
