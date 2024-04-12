// ignore_for_file: unnecessary_string_interpolations, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cubex_assessment/components/widgets/full_button.dart';
import 'package:cubex_assessment/helpers/dio.dart/dio_client.dart';
import 'package:cubex_assessment/helpers/size_calculator.dart';
import 'package:cubex_assessment/helpers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<dynamic> userContent = [];
  String email = '';
  String username = '';
  String phoneNumber = '';
  DioClient dioClient = DioClient();

  @override
  void initState() {
    super.initState();
    getUserProfile();
    // setState(() {
    //   email = Provider.of<UserProvider>(context, listen: false).email;
    //   username = Provider.of<UserProvider>(context, listen: false).username;
    //   phoneNumber =
    //       Provider.of<UserProvider>(context, listen: false).phoneNumber;
    // });
  }

  Future<dynamic> getUserProfile() async {
    try {      
      final response = await dioClient.getUser();
      setState(() {
        userContent = response;
      });      
    } catch (e) {
      log('==> e: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Profile"),
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 55.0,
              backgroundImage: AssetImage('assets/images/person1.jpg'),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Username',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        centerTitle: true,
        toolbarHeight: 200,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizer(true, 24, context)),
          child: Column(
            children: [
              Card(
                elevation: 1.0,
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.redAccent,
                  ),
                  title: Text(
                    'Email address',
                  ),
                ),
              ),
              Card(
                elevation: 1.0,
                child: ListTile(
                  leading: Icon(
                    Icons.public,
                    color: Colors.redAccent,
                  ),
                  title: Text("Nigeria"),
                ),
              ),
              Card(
                elevation: 1.0,
                child: ListTile(
                  leading: Icon(
                    Icons.phone_android,
                    color: Colors.redAccent,
                  ),
                  title: Text('Phone number'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: FullButton(
        buttonFunction: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', '');
          log("==> token after logout");
          context.goNamed('onboarding');
        },
        buttonText: 'Log out',
      ),
    );
  }
}
