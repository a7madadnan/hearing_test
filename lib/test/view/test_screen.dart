import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hearing_test/components/neum_container.dart';
import 'package:hearing_test/constants/style_constants/app_colors.dart';
import 'package:hearing_test/test/provider/test_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:ui' as ui;
import 'package:lottie/lottie.dart';
import '../../components/neum_button.dart';
import '../../routes/routes.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  AudioPlayer player = AudioPlayer();

  @override
  void dispose() {
    ref.read(soundStateNotifierProvider.notifier).dispose();
    ref.read(soundStateNotifierProvider.notifier).player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    ref.read(soundStateNotifierProvider.notifier).playSound();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Sound sound = ref.watch(soundStateNotifierProvider);
    bool isFinished = ref.watch(soundStateNotifierProvider).isFinished;

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
                      color: !sound.isLeft ? null : AppColor.bgColor,
                      beginColor:
                          !sound.isLeft ? AppColor.firstleniarColor : null,
                      endColor:
                          !sound.isLeft ? AppColor.secondleniarColor : null,
                      child: Text(
                        'right_ear'.tr(),
                        style: TextStyle(
                            color: !sound.isLeft ? Colors.white : Colors.black,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: NeumorphicContainer(
                      padding: 2,
                      color: sound.isLeft ? null : AppColor.bgColor,
                      beginColor:
                          sound.isLeft ? AppColor.firstleniarColor : null,
                      endColor:
                          sound.isLeft ? AppColor.secondleniarColor : null,
                      child: Text(
                        'left_ear'.tr(),
                        style: TextStyle(
                            color: sound.isLeft ? Colors.white : Colors.black,
                            fontSize: 20),
                      ),
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
                        horizantalpadding: 2,
                        depth: sound.isLeft ? -5 : 5,
                        padding: 2,
                        color: AppColor.bgColor,
                        height: 40,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sound.rightLevel,
                            itemBuilder: (BuildContext context, int index) {
                              return const Padding(
                                padding: EdgeInsets.all(1.5),
                                child: NeumorphicContainer(
                                  shape: NeumorphicBoxShape.circle(),
                                  height: 23,
                                  width: 23,
                                  color: AppColor.mainAccentColor,
                                ),
                              );
                            })),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: NeumorphicContainer(
                        horizantalpadding: 2,
                        depth: sound.isLeft ? 5 : -5,
                        padding: 2,
                        color: AppColor.bgColor,
                        height: 40,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sound.leftLevel,
                            itemBuilder: (BuildContext context, int index) {
                              return const Padding(
                                padding: EdgeInsets.all(1.5),
                                child: NeumorphicContainer(
                                  shape: NeumorphicBoxShape.circle(),
                                  height: 23,
                                  width: 23,
                                  color: AppColor.mainAccentColor,
                                ),
                              );
                            })),
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
                    child: Text("${sound.frequency} Hz",
                        style: const TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  NeumorphicContainer(
                    padding: 2,
                    color: AppColor.bgColor,
                    child: Text("${(sound.volume * 100).toInt()}dB",
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
                  Result result = Result(
                      volume: ref.read(soundStateNotifierProvider).volume,
                      frequency: ref.read(soundStateNotifierProvider).frequency,
                      isLeft: ref.read(soundStateNotifierProvider).isLeft);
                       print(ref.read(resultListProvider));
                  ref.read(resultListProvider).add(result);
                  ref.read(soundStateNotifierProvider.notifier).canHear();

                  ref.read(soundStateNotifierProvider.notifier).playSound();

                  if (isFinished) {
                    Navigator.pushNamed(context, Routes.result);
                  }
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
                  Result result = Result(
                      volume: ref.read(soundStateNotifierProvider).volume,
                      frequency: ref.read(soundStateNotifierProvider).frequency,
                      isLeft: ref.read(soundStateNotifierProvider).isLeft);
                  ref.read(resultListProvider).add(result);
                  print(ref.read(resultListProvider));
                  ref
                      .read(soundStateNotifierProvider.notifier)
                      .resultSound
                      .add(ref.watch(soundStateNotifierProvider));
                  ref.read(soundStateNotifierProvider.notifier).cannotHear();

                  ref.read(soundStateNotifierProvider.notifier).playSound();

                  if (isFinished) {
                    Navigator.pushNamed(context, Routes.result);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
