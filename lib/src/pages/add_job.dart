import 'package:flutter/material.dart';
import 'package:jobs_app/src/configs/app_colors.dart';
import 'package:jobs_app/src/models/job.dart';
import 'package:jobs_app/src/services/firebase_service.dart';
import 'package:jobs_app/src/shared/app_button.dart';
import 'package:jobs_app/src/shared/app_text_field.dart';

class AddJob extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddJobState();
}

class AddJobState extends State<AddJob> {
  final TextEditingController titleFieldController = TextEditingController();
  final TextEditingController descpFieldController = TextEditingController();
  String selectedCompany = "assets/images/pocketsystems.png";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: Builder(
            builder: (childContext) => Column(
              children: [
                SizedBox(height: 50),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.chevron_left,
                        size: 40,
                      ),
                    ),
                    SizedBox(width: 25),
                    Text(
                      "Add New Job",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: Job.sampleData
                      .map((jobItem) => GestureDetector(
                            onTap: () => setState(() {
                              selectedCompany = jobItem.companyLogo;
                            }),
                            child: Container(
                              height: 60,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: selectedCompany == jobItem.companyLogo
                                      ? Colors.white
                                      : AppColors.bgColorItem,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Image.asset(
                                jobItem.companyLogo,
                                width: 25,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 20),
                AppTextField(
                  placeholder: "Enter position name",
                  controller: titleFieldController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a job title";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                AppTextField(
                  placeholder: "Describe Requirement...",
                  isMultiLine: true,
                  controller: descpFieldController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a job title";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                if (!isLoading)
                  AppButton(
                      label: "Post Job",
                      onTap: () {
                        if (!Form.of(childContext).validate()) {
                          return;
                        }
                        submitJob();
                      }),
                if (isLoading) Center(child: CircularProgressIndicator())
              ],
            ),
          ),
        ),
      ),
    );
  }

  submitJob() async {
    setState(() {
      isLoading = true;
    });
    Job job = Job(
        selectedCompany, titleFieldController.text, descpFieldController.text);
    await FirebaseService.createJob(job);
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context, true);
  }
}
