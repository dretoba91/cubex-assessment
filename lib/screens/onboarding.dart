// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Center(
                    child: Text(
                      'WELCOME TO CUREX',
                      style: TextStyle(
                          color: Color(0xFF2D4990),
                          fontFamily: "Montserrat",
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: SizedBox(
                      height: 40,
                      width: 310,
                      child: ElevatedButton(
                          onPressed: () {
                            context.goNamed('login');
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Color(0xFF2D4990),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              textStyle: TextStyle(
                                  color: Color(0xFF1E1E1E),
                                  fontFamily: "Montserrat",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                          child: Text(
                            'Log In',
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: "Montserrat",
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      height: 40,
                      width: 310,
                      child: ElevatedButton(
                          onPressed: () {
                            context.goNamed('signup');
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Color(0xFFFFFFFF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      width: 1.5, color: Color(0xFF2D4990))),
                              textStyle: TextStyle(
                                  color: Color(0xFF2D4990),
                                  fontFamily: "Montserrat",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Color(0xFF2D4990),
                                fontFamily: "Montserrat",
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
