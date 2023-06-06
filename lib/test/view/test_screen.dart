import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hearing_test/components/neum_container.dart';
import 'package:hearing_test/constants/style_constants/app_colors.dart';
import 'package:hearing_test/test/provider/test_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dart:ui' as ui;

import 'package:lottie/lottie.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
// import 'package:sound_generator/sound_generator.dart';
// import 'package:sound_generator/waveTypes.dart';

import '../../components/neum_button.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
   bool isPlaying = false;
  double frequency = 20;
  double balance = 0;
  double volume = 1;
  waveTypes waveType = waveTypes.SINUSOIDAL;
  int sampleRate = 96000;
  @override
  void dispose() {
    super.dispose();
    SoundGenerator.release();
  }

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

   

    SoundGenerator.setAutoUpdateOneCycleSample(true);
    //Force update for one time
    SoundGenerator.refreshOneCycleData();
  }

  @override
  Widget build(BuildContext context) {
    late Sound sound;

    // waveTypes waveType = waveTypes.SINUSOIDAL;
    // int sampleRate = 96000;
    sound = ref.watch(soundStateNotifierProvider);
    final double volume = sound.volume;
    print(volume);
    ref.read(soundStateNotifierProvider.notifier).playSound();
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          textDirection: ui.TextDirection.ltr,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: NeumorphicContainer(
                      depth: 5,
                      padding: 2,
                      beginColor: AppColor.firstleniarColor,
                      endColor: AppColor.secondleniarColor,
                      child: Text(
                        'right_ear'.tr(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: NeumorphicContainer(
                      padding: 2,
                      color: AppColor.bgColor,
                      child: Text('left_ear'.tr(),
                          style: const TextStyle(fontSize: 20)),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: NeumorphicContainer(
                        depth: 5,
                        padding: 6,
                        color: AppColor.bgColor,
                        height: 30,
                        child: Container()),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: NeumorphicContainer(
                        height: 30,
                        padding: 6,
                        color: AppColor.bgColor,
                        child: Container()),
                  )
                ],
              ),
            ),
            Lottie.asset(
              "assets/lottie/wave-loop.json",
            ),
            const SizedBox(
              height: 96,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphicContainer(
                    padding: 2,
                    color: AppColor.bgColor,
                    child: Text(
                      sound.frequency.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  NeumorphicContainer(
                    padding: 2,
                    color: AppColor.bgColor,
                    child: Text("${sound.volume * 100}",
                        style: const TextStyle(fontSize: 20)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: NeumorphicButtons(
                beginColor: AppColor.firstleniarColor,
                endColor: AppColor.secondleniarColor,
                text: 'i_can_hear'.tr(),
                onPressed: () {
                  ref.read(soundStateNotifierProvider.notifier).stop();
                  ref.read(soundStateNotifierProvider.notifier).downVolume();

                  ref.read(soundStateNotifierProvider.notifier).playSound();

                  // volume = ref.watch(soundStateNotifierProvider).volume;
                  // SoundGenerator.setVolume(volume);
                  // SoundGenerator.play();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: NeumorphicButtons(
                beginColor: AppColor.firstRedColor,
                endColor: AppColor.secondRedColor,
                text: 'i_can_not_hear'.tr(),
                onPressed: () {
                  ref.read(soundStateNotifierProvider.notifier).stop();
                  ref.read(soundStateNotifierProvider.notifier).raiseVolume();
                  ref.read(soundStateNotifierProvider.notifier).playSound();
                  // volume = ref.watch(soundStateNotifierProvider).volume;

                  // print(volume);

                  // SoundGenerator.setVolume(volume);
                  // SoundGenerator.play();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeVolume(int volume) {}
}
