// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:developer';

import 'package:cubex_assessment/helpers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 5), () => checkUserPreference());
  }

  checkUserPreference() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getString('token');

    if (isLoggedIn != null) {
      log('==> logged in: $isLoggedIn');
      if (isLoggedIn.isNotEmpty) {
        context.goNamed('profile-page');
      } else {
        context.goNamed('onboarding');
      }
    } else {
      context.goNamed('onboarding');
    }
  }

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
                children: const [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
