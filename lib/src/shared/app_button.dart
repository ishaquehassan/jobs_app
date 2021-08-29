import 'package:flutter/material.dart';
import 'package:jobs_app/src/configs/app_colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function onTap;

  const AppButton({@required this.label, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border:
                      Border.all(width: 1, color: AppColors.fieldBorderColor)),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }
}
