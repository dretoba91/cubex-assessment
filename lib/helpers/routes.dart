// import 'package:flutter_state_managements/splash.dart';
import 'package:cubex_assessment/authentication/login.dart';
import 'package:cubex_assessment/authentication/signup.dart';
import 'package:cubex_assessment/screens/onboarding.dart';
import 'package:cubex_assessment/screens/profile_page.dart';
import 'package:cubex_assessment/screens/splash.dart';
import 'package:go_router/go_router.dart';

class RouteHelpers {
  static final GoRouter routes = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) {
          return const Splash();
        },
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) {
          return const Onboarding();
        },
        routes: [
          GoRoute(
            path: 'login',
            name: 'login',
            builder: (context, state) {
              return const LoginPage();
            },
          ),
          GoRoute(
            path: 'signup',
            name: 'signup',
            builder: (context, state) {
              return const SignUp();
            },
          ),
        ],
      ),

      GoRoute(
        path: '/profile-page',
        name: 'profile-page',
        builder: (context, state) {
          return const ProfilePage();
        },
      ),

      // GoRoute(
      //   path: '/user-info',
      //   name: 'user-info',
      //   builder: (context, state) {
      //     final Map<String, String> data = state.extra as Map<String, String>;
      //     return UserInfo(
      //       email: data['userEmail']!,
      //     );
      //   },
      // ),
    ],
  );
}
