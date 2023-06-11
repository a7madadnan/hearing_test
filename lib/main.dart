import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hearing_test/routes/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hearing_test/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: const ProviderScope(child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hearing Test',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: Routes.welcome,
      routes: AppRoutes.routes,
      theme: ThemeData(fontFamily: 'Cairo'),
    );
  }
}





