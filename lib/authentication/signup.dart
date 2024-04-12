// ignore_for_file: prefer_const_constructors, await_only_futures, prefer_is_empty

import 'dart:developer';
import 'dart:io';

import 'package:cubex_assessment/components/authentication_header.dart';
import 'package:cubex_assessment/components/widgets/full_button.dart';
import 'package:cubex_assessment/components/widgets/general_textfield.dart';
import 'package:cubex_assessment/components/widgets/intl_phone_field.dart';
import 'package:cubex_assessment/helpers/dio.dart/dio_client.dart';
import 'package:cubex_assessment/helpers/regex.dart';
import 'package:cubex_assessment/helpers/size_calculator.dart';
import 'package:cubex_assessment/helpers/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String userEmail = '';
  String usernameText = "";
  String userPassword = "";
  String avatar = "";
  String? profilePhotoUrl = '';
  String completePhoneNumber = "";
  dynamic formData;
  bool hasFinishUploadingPhoto = true;
  bool profilePhotoUploaded = false;
  bool startProgress = false;
  TextEditingController usernameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();
  bool obscurePassword = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  DioClient dioClient = DioClient();

  Future uploadSinglePhoto() async {
    setState(() {
      hasFinishUploadingPhoto = false;
      startProgress = true;
    });
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = await File(image.path);
      final imageFileName = imageTemp.path.split('/').last;
      final path = 'files/$imageFileName';
      // var formData = FormData.fromMap({
      //   'files': await MultipartFile.fromFile(imageTemp.path,
      //       filename: imageTemp.path.split('/').last)
      // });
      return path;

      // var response = await apiService.uploadToAws(formData, context);
      // if (response["success"] == true) {
      //   return response['content'][0]['url'];
      // }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('failed to pick image: $e');
      }
    }
  }

  Future<dynamic> preRegisterUser() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final String email = userEmail;
      String password = userPassword;
      String phoneNumber = completePhoneNumber;
      String username = usernameText;
      log("==> email: $email ===> password: $password ===> username: $username");

      final response = await dioClient.register(
          email, username, password, phoneNumber, avatar);
      if (response == 'Registration successful') {
        log('response is true: $response');
        userProvider.setEmail(email);
        userProvider.setUsername(username);
        userProvider.setPhoneNumber(phoneNumber);
      } else {}
      context.goNamed('login');
    } catch (e) {
      log('==> e: $e');
    }
  }

  @override
  void dispose() {
    usernameEditingController.dispose();
    passwordEditingController.dispose();
    phoneEditingController.dispose();
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
        elevation: 1,
      ),
      body: SafeArea(
          child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizer(true, 24, context)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthenticationHeader(
                    titleText: 'Start creating your account...'),
                SizedBox(
                  height: sizer(false, 18, context),
                ),
                Text(
                  "You're now one step closer to be part of us... and everything else in-between! 😎",
                  style: TextStyle(
                    height: sizer(true, 1.4, context),
                    fontSize: sizer(true, 13, context),
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: sizer(false, 24, context),
                ),
                Text(
                  "Enter your email address",
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
                  textController: emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: emailVal,
                  onChanged: (val) => setState(() {
                    userEmail = val ?? '';
                  }),
                ),
                SizedBox(
                  height: sizer(false, 8, context),
                ),
                Text(
                  "Enter your preferred username",
                  style: TextStyle(
                    height: sizer(true, 1.4, context),
                    fontSize: sizer(true, 13.5, context),
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "(use only letters, numbers, underscore and within 2 to 30 characters. may the force be with you lol)",
                  style: TextStyle(
                    height: sizer(true, 1.4, context),
                    fontSize: sizer(true, 11.5, context),
                    color: Color(0xFFB5B5B5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: sizer(false, 8, context),
                ),
                GeneralTextField(
                  focusNode: _focusNodes[1],
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
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
                    Text(
                      "(use at least 6 characters)",
                      style: TextStyle(
                        height: sizer(true, 1.4, context),
                        fontSize: sizer(true, 11.5, context),
                        color: Color(0xFFB5B5B5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: sizer(false, 8, context),
                    ),
                    GeneralTextField(
                      textController: passwordEditingController,
                      focusNode: _focusNodes[2],
                      validator: passwordVal,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r"\s"))
                      ],
                      obscureText: obscurePassword,
                      onChanged: (val) => setState(() {
                        userPassword = val ?? '';
                      }),
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

                    // SizedBox(
                    //   height: 50,
                    //   width: 380,
                    //   child: TextFormField(
                    //     focusNode: _focusNodes[2],
                    //     controller: passwordEditingController,
                    //     validator: passwordVal,
                    //     inputFormatters: [
                    //       FilteringTextInputFormatter.deny(RegExp(r"\s"))
                    //     ],
                    //     onChanged: (val) => setState(() {
                    //       password = val;
                    //     }),
                    //     decoration: InputDecoration(
                    //       // floatingLabelBehavior: FloatingLabelBehavior.auto,
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Colors.black54,
                    //         ),
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(8),
                    //         ),
                    //       ),
                    //       filled: true,
                    //       fillColor: Color(0xFFFFFFFF),
                    //       labelStyle: TextStyle(
                    //         color: Color(0xFF000000),
                    //         fontFamily: "Montserrat",
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //       focusColor: Color(0xFF2D4990),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(8)),
                    //         borderSide: BorderSide(
                    //           color: Color(0xFF2D4990),
                    //         ),
                    //       ),
                    //       suffix: IconButton(
                    //         onPressed: () {
                    //           setState(() {
                    //             obscurePassword = !obscurePassword;
                    //           });
                    //         },
                    //         icon: Icon(
                    //           obscurePassword
                    //               ? Icons.visibility_off_outlined
                    //               : Icons.visibility_outlined,
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //       suffixIconColor: MaterialStateColor.resolveWith(
                    //         (states) => states.contains(MaterialState.focused)
                    //             ? Color(0xFF2D4990)
                    //             : Colors.grey,
                    //       ),
                    //     ),
                    //     obscureText: obscurePassword,
                    //   ),
                    // ),
                    SizedBox(
                      height: sizer(false, 19, context),
                    ),

                    Form(
                      key: _key,
                      autovalidateMode: _autovalidate,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter your phone number",
                            style: TextStyle(
                              height: sizer(true, 1.4, context),
                              fontSize: sizer(true, 13.5, context),
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "(we’ll send you otp to verify your account)",
                            style: TextStyle(
                              height: sizer(true, 1.4, context),
                              fontSize: sizer(true, 11.5, context),
                              color: Color(0xFFB5B5B5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: sizer(false, 8, context),
                          ),
                          SizedBox(
                            height: sizer(false, 60, context),
                            child: IntlPhoneField(
                              focusNode: _focusNodes[3],
                              initialValue: Provider.of<UserProvider>(context,
                                      listen: true)
                                  .phoneNumber,
                              style: TextStyle(
                                height: sizer(true, 1.4, context),
                                fontSize: sizer(true, 13, context),
                                color: Color(0xFF252525),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlignVertical: TextAlignVertical.bottom,
                              controller: phoneEditingController,
                              dropdownIcon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                isCollapsed: true,
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    width: 0.5,
                                    color: Color(0xFFF5F5F5),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    width: 0.5,
                                    color: Color(0xFFF5F5F5),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: sizer(false, 14, context),
                                  horizontal: sizer(true, 20, context),
                                ),
                                fillColor: Color(0xFFF5F5F5),
                                hintStyle: TextStyle(
                                  height: sizer(true, 1.4, context),
                                  color: Colors.black,
                                  fontSize: sizer(true, 13, context),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      sizer(true, 12, context)),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Color(0xFFF5F5F5),
                                  ),
                                ),
                                errorText: "",
                                errorStyle: TextStyle(
                                  height: sizer(true, 1.4, context),
                                  fontSize: sizer(true, 0, context),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      sizer(true, 12, context)),
                                  borderSide: const BorderSide(
                                    width: 0.5,
                                    color: Colors.grey,
                                  ),
                                ),
                                counter: const Offstage(),
                                filled: true,
                              ),
                              onChanged: (phone) {
                                setState(() {
                                  completePhoneNumber = phone.countryCode +
                                      phone.number
                                          .replaceAll(RegExp(r'^0+'), '');
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: sizer(false, 19, context),
                    ),

                    Text(
                      "Add profile photo (optional)",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        height: sizer(true, 1.4, context),
                        fontSize: sizer(true, 13.5, context),
                        color: Color(0xFF252525),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: sizer(false, 10, context),
                    ),
                    GestureDetector(
                      onTap: () async {
                        profilePhotoUrl = await uploadSinglePhoto();
                        setState(() {
                          startProgress = false;
                        });
                        hasFinishUploadingPhoto = false;
                        if (profilePhotoUrl!.trim().length > 0) {
                          setState(() {
                            hasFinishUploadingPhoto = true;
                            profilePhotoUploaded = true;
                            avatar = profilePhotoUrl!;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(11.0, 12.0, 11.0, 9.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFF5F5F5),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: hasFinishUploadingPhoto == false &&
                                startProgress == true
                            ? Center(
                                child: SizedBox(
                                    height: sizer(false, 20, context),
                                    width: sizer(false, 20, context),
                                    child: CircularProgressIndicator()))
                            : Row(
                                children: [
                                  SvgPicture.asset(
                                    !profilePhotoUploaded
                                        ? 'assets/images/picUpload.svg'
                                        : 'assets/images/success.svg',
                                    width: sizer(true, 24.0, context),
                                    height: sizer(true, 24.0, context),
                                  ),
                                  SizedBox(
                                    width: sizer(true, 7.0, context),
                                  ),
                                  Text(
                                    !profilePhotoUploaded
                                        ? 'Select new profile photo to upload'
                                        : 'photo successfully added!',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: sizer(true, 13.0, context)),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizer(false, 22, context),
                ),
                FullButton(
                  buttonText: "Sign up for Cubex",
                  weight: FontWeight.w800,
                  online: emailRegExMatch(emailEditingController.text) &&
                      usernameRegExMatch(usernameEditingController.text) &&
                      phoneRegExMatch(phoneEditingController.text) &&
                      passwordEditingController.text.length >= 6 &&
                      phoneEditingController.text.length >= 9,
                  buttonFunction: () async {
                    await preRegisterUser();
                  },
                ),
                SizedBox(
                  height: sizer(false, 250, context),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
