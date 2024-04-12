// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:developer';

import 'package:cubex_assessment/components/authentication_header.dart';
import 'package:cubex_assessment/components/widgets/full_button.dart';
import 'package:cubex_assessment/components/widgets/general_textfield.dart';
import 'package:cubex_assessment/helpers/dio.dart/dio_client.dart';
import 'package:cubex_assessment/helpers/regex.dart';
import 'package:cubex_assessment/helpers/size_calculator.dart';
import 'package:cubex_assessment/helpers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String usernameText = "";
  String userPassword = "";
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController usernameEditingController =
      TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final List<FocusNode> _focusNodes = List.generate(2, (_) => FocusNode());
  bool isLoading = false;
  bool obscurePassword = true;
  bool passwordIncorrect = false;
  DioClient dioClient = DioClient();

  Future<dynamic> preLoginUser() async {
    try {
      final String username = usernameText;
      final String password = passwordEditingController.text;
      final response = await dioClient.login(username, password);
      await Provider.of<UserProvider>(context, listen: false)
          .setToken(response['token']);
      checkIsLoading();
      context.goNamed("profile-page");
    } catch (e) {
      log('==> e: $e');
    }
  }

  checkIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void dispose() {
    usernameEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onTap: () => Router.neglect(context, () => context.pop()),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizer(true, 24, context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const AuthenticationHeader(titleText: 'Welcome back to Cubex'),
            SizedBox(
              height: sizer(false, 30, context),
            ),
            Text(
              "Enter your username",
              style: TextStyle(
                height: sizer(true, 1.4, context),
                fontSize: sizer(true, 13.5, context),
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: sizer(false, 8, context),
            ),
            GeneralTextField(
              focusNode: _focusNodes[0],
              maxLength: 30,
              textController: usernameEditingController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9_]+"))
              ],
              validator: usernameVal,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (val) => setState(() {
                setState(() {
                  usernameText = val ?? '';
                });
              }),
            ),
            SizedBox(
              height: sizer(false, 19, context),
            ),
            Text(
              "Enter your password",
              style: TextStyle(
                height: sizer(true, 1.4, context),
                fontSize: sizer(true, 13.5, context),
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: sizer(false, 8.0, context),
            ),
            GeneralTextField(
              textController: passwordEditingController,
              // hintText: "********",
              validator: passwordVal,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r"\s"))
              ],
              obscureText: obscurePassword,
              onChanged: (val) => setState(() {}),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: sizer(true, 24, context),
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: sizer(false, 22, context),
            ),
            FullButton(
              weight: FontWeight.w800,
              buttonText: passwordIncorrect
                  ? "Incorrect password. Tap here to try again"
                  : "Log in to Cubex",
              online: passwordEditingController.text.length >= 6,
              buttonFunction: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                preLoginUser();
              },
            ),
            SizedBox(
              height: sizer(false, 240, context),
            ),
          ],
        ),
      )),
    );
  }
}
