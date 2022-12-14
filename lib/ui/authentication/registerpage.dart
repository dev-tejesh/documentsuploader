import 'package:documentsuploader/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:documentsuploader/ui/authentication/loginpage.dart';
import 'package:documentsuploader/utils/buttons.dart';
import 'package:documentsuploader/utils/decoration.dart';
import 'package:documentsuploader/utils/spacing.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final registerKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9c27B0),
      body: GetBuilder<AuthController>(builder: (_authController) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'REGISTER',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 1,
                        blurRadius: 0,
                        offset: Offset(0, 5),
                      )
                    ]),
                child: Column(
                  children: [
                    Form(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: registerKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              final validEmail = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                              if (validEmail.hasMatch(val.toString())) {
                                return null;
                              } else {
                                return 'Please enter valid email';
                              }
                            },
                            onChanged: (value) {
                              _authController.email = value;
                              _authController.update();
                            },
                            decoration: inputDecoration(
                                hintText: 'Enter Email',
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                )),
                          ),
                          sizedBoxHeight10,
                          TextFormField(
                            decoration: inputDecoration(
                                hintText: 'Enter Password',
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                )),
                            validator: (val) {
                              if (val.toString().length > 7) {
                                return null;
                              } else {
                                return "Password should be atleast 8 characters long";
                              }
                            },
                            onChanged: (value) {
                              _authController.password = value;
                              _authController.update();
                            },
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight20,
                    primaryActionButton(
                      text: 'Sign Up',
                      onTap: () {
                        if (registerKey.currentState!.validate()) {
                          _authController.register(context);
                        
                        }
                      },
                    ),
                    sizedBoxHeight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account? '),
                        InkWell(
                          onTap: () => {Get.to(LoginPage())},
                          child: const Text(
                            'Log In',
                            style: TextStyle(color: Colors.orange),
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
      }),
    );
  }
}
