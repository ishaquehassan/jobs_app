import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/src/configs/app_colors.dart';
import 'package:jobs_app/src/pages/home.dart';
import 'package:jobs_app/src/pages/sign_up.dart';
import 'package:jobs_app/src/services/firebase_service.dart';
import 'package:jobs_app/src/shared/app_button.dart';
import 'package:jobs_app/src/shared/app_text_field.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Page container = Scaffold
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: Builder(
            builder: (childContext) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 110),
                  Text("Let’s sign you in",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w600)),
                  SizedBox(height: 15),
                  Text(
                    "Welcome back \nyou’ve been missed !",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 65),
                  AppTextField(
                    placeholder: "Enter your email",
                    controller: emailFieldController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter email";
                      }
                      if (!value.contains("@") || !value.contains(".")) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  AppTextField(
                    placeholder: "Enter your password",
                    isPasswordField: true,
                    controller: passwordFieldController,
                    validator: (value) {
                      if (value.length < 6) {
                        return "Password must contain atleast 6 chars";
                      }
                      return null;
                    },
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => SignUp()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account ?",
                          style: TextStyle(
                              fontSize: 15, color: AppColors.textColorDark),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 15, color: AppColors.textColorLight),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  if (!isLoading)
                    AppButton(
                        label: "Sign In",
                        onTap: () async {
                          if (!Form.of(childContext).validate()) {
                            return;
                          }
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await FirebaseService.signIn(
                                emailFieldController.text,
                                passwordFieldController.text);

                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Home()));
                          } on FlutterError catch (e) {
                            ScaffoldMessenger.of(childContext).showSnackBar(
                                SnackBar(content: Text(e.message)));
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }),
                  if (isLoading) CircularProgressIndicator(),
                  SizedBox(
                    height: 50,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
