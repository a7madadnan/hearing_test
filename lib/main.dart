import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hearing_test/routes/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
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

class MySound extends StatefulWidget {
  const MySound({super.key});

  @override
  State<MySound> createState() => _MySoundState();
}

class _MySoundState extends State<MySound> {
  bool isPlaying = false;
  double frequency = 20;
  double balance = 0;
  double volume = 1;
  waveTypes waveType = waveTypes.SINUSOIDAL;
  List<int>? oneCycleData;
  int sampleRate = 44100;
  @override
  void initState() {
    super.initState();
    isPlaying = false;

    SoundGenerator.init(sampleRate);

    SoundGenerator.onIsPlayingChanged.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    SoundGenerator.onOneCycleDataHandler.listen((value) {
      setState(() {
        oneCycleData = value;
      });
    });

    SoundGenerator.setAutoUpdateOneCycleSample(true);
    //Force update for one time
    SoundGenerator.refreshOneCycleData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Sound Generator Example'),
      ),
      body: Column(children: [
        CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal,
            child: IconButton(
                icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                onPressed: () {
                  isPlaying ? SoundGenerator.stop() : SoundGenerator.play();
                })),
        const Text('this is 250 Hz'),
      ]),
    );
  }
}
