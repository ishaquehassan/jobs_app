import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/src/configs/app_colors.dart';
import 'package:jobs_app/src/models/job.dart';
import 'package:jobs_app/src/pages/add_job.dart';
import 'package:jobs_app/src/pages/sign_in.dart';
import 'package:jobs_app/src/services/firebase_service.dart';
import 'package:jobs_app/src/shared/app_text_field.dart';
import 'package:jobs_app/src/shared/job_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<QueryDocumentSnapshot<Job>>>(
        future: FirebaseService.readJobs(keyword),
        builder: (childContext, data) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser.displayName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (ctx) => SignIn()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Image.asset("assets/images/logout.png",
                          width: 25, height: 25),
                    ),
                  )
                ],
              ),
              if (data.connectionState == ConnectionState.done) ...[
                SizedBox(height: 20),
                AppTextField(
                    controller: TextEditingController(text: keyword),
                    placeholder: "Search Jobs here",
                    onFieldSubmit: search),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.data.length,
                    itemBuilder: (childContext, index) =>
                        JobItem(data.data[index].data()),
                  ),
                )
              ],
              if (data.connectionState == ConnectionState.waiting)
                Expanded(child: Center(child: CircularProgressIndicator()))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 35),
        onPressed: () async {
          await Navigator.push(
              context, CupertinoPageRoute(builder: (_) => AddJob()));
          setState(() {});
        },
        backgroundColor: AppColors.bgAddFab,
      ),
    );
  }

  search(String keywords) {
    setState(() {
      keyword = keywords;
    });
  }
}
