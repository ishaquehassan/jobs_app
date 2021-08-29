import 'package:flutter/material.dart';
import 'package:jobs_app/src/configs/app_colors.dart';
import 'package:jobs_app/src/models/job.dart';

class JobItem extends StatelessWidget {
  final Job job;

  const JobItem(this.job);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color(0x3f000000),
                  blurRadius: 25,
                  offset: Offset(0, 4),
                ),
              ],
              color: AppColors.bgColorItem,
            ),
            child: Row(
              children: [
                Image.asset(job.companyLogo, width: 41, height: 41),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      job.descp,
                      style: TextStyle(
                        color: Color(0xff8f8f9e),
                        fontSize: 12,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
