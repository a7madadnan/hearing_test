

import 'package:hearing_test/result/view/result_screen.dart';
import 'package:hearing_test/setup/view/setup_screen.dart';
import 'package:hearing_test/welcome/view/welcome_screen.dart';

import '../test/view/test_screen.dart';
import 'routes.dart';

class AppRoutes {
  static final routes = {
    Routes.welcome: (context) => const WelcomeScreen(),
    Routes.setup: (context)=> const SetupScreen(),
    Routes.test: (context)=> const TestScreen(),
    Routes.result: (context)=> const ResultScreen()
  
  };
}
