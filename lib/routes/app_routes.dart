
import 'package:hearing_test/setup/view/setup_screen.dart';
import 'package:hearing_test/test/view/function/sound_generate.dart';
import 'package:hearing_test/welcome/view/welcome_screen.dart';

import '../test/view/test_screen.dart';
import 'routes.dart';

class AppRoutes {
  static final routes = {
    Routes.welcome: (context) => const WelcomeScreen(),
    Routes.setup: (context)=> const SetupScreen(),
    Routes.test: (context)=> const TestScreen(),
    Routes.gen: (context)=> const SoundGen()
  
  };
}
