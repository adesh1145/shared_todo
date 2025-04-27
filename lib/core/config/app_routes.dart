import 'package:flutter/material.dart';
import 'package:shareed_todo/presentation/view/onboarding_screen.dart';
import 'package:shareed_todo/presentation/view/social_login_screen.dart';
import 'package:shareed_todo/presentation/view/todo_detail.dart';
import 'package:shareed_todo/presentation/view/todo_list_screen.dart';

import '../../presentation/view/spalsh_screen.dart';

class AppRoutes {
  // Route names

  static const String login = '/login';
  static const String onboarding = '/onboarding';
  static const String socialLogin = '/socialLogin';
  static const String todoList = '/todoList';
  static const String todoDetail = '/todoDetail';
  static const String intial = '/';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case intial:
        return MaterialPageRoute(builder: (_) => SpalshScreen());

      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

      case socialLogin:
        return MaterialPageRoute(builder: (_) => SocialLoginScreen());

      case todoList:
        return MaterialPageRoute(builder: (_) => TodoListScreen());
      case todoDetail:
        return MaterialPageRoute(
            builder: (_) => TodoDetail(todoId: settings.arguments as String?));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
