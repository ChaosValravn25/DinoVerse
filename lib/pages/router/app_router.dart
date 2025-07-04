import 'package:flutter/material.dart';
import 'package:flutter_application_laboratorio_3/pages/home_page.dart';
import 'package:flutter_application_laboratorio_3/pages/preferences_page.dart';
import 'package:flutter_application_laboratorio_3/pages/activity_page.dart';
import 'package:flutter_application_laboratorio_3/pages/feedback_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/preferences':
        return MaterialPageRoute(builder: (_) => const PreferencesPage());
      case '/activities':
        return MaterialPageRoute(builder: (_) => const ActivityPage());
      case '/feedback':
        return MaterialPageRoute(builder: (_) => const FeedbackPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
