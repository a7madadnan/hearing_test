import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hearing_test/components/neum_container.dart';
import 'package:hearing_test/constants/style_constants/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondleniarColor,
        title: Center(
            child: Text(
          "test_result".tr(),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(
              'left_ear'.tr(),
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 30,
            ),
            NeumorphicContainer(
              padding: 50,
              color: AppColor.bgColor,
              child: Column(
                children: [
                  const SimpleCircularProgressBar(
                    maxValue: 80,
                    progressColors: [
                      AppColor.secondleniarColor,
                      AppColor.firstleniarColor,
                    ],
                    size: 100,
                    backStrokeWidth: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'the_left_ear_has_normal_hearing'.tr(),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Text(
              'right_ear'.tr(),
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 30,
            ),
            NeumorphicContainer(
              padding: 50,
              color: AppColor.bgColor,
              child: Column(
                children: [
                  const SimpleCircularProgressBar(
                    maxValue: 80,
                    progressColors: [
                      AppColor.secondleniarColor,
                      AppColor.firstleniarColor,
                    ],
                    size: 100,
                    backStrokeWidth: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'the_right_ear_has_normal_hearing'.tr(),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
