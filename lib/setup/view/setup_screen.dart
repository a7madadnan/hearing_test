
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hearing_test/components/neum_container.dart';
import 'package:hearing_test/constants/style_constants/app_colors.dart';
import 'package:hearing_test/routes/routes.dart';
import 'package:hearing_test/setup/view/widgets/animated_Check.dart';
import 'package:lottie/lottie.dart';
import 'package:headset_connection_event/headset_event.dart';

import 'package:volume_controller/volume_controller.dart';

import '../../components/neum_button.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen>
    with TickerProviderStateMixin {
  double _volumeListenerValue = 0;
  HeadsetEvent headsetPlugin = HeadsetEvent();
  HeadsetState headsetEvent = HeadsetState.DISCONNECT;
  @override
  void initState() {
    super.initState();
    VolumeController().listener((volume) {
      setState(() => _volumeListenerValue = volume);
    });
  }

  @override
  Widget build(BuildContext context) {
    headsetPlugin.getCurrentState.then((val) {
      setState(() {
        headsetEvent = val ?? HeadsetState.DISCONNECT;
      });
    });
    bool isMax = _volumeListenerValue == 1;
    bool isConnected = headsetEvent == HeadsetState.CONNECT;
    bool goodToGo = (isMax && isConnected);
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            NeumorphicContainer(
              color: AppColor.mainAccentColor,
              child: Text(
                'before_you_start'.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Lottie.asset("assets/lottie/speaker-headphones.json",
                repeat: false, height: 130, width: 130),
            const SizedBox(
              height: 50,
            ),
            Directionality(
              textDirection: context.locale.languageCode == ('ar')
                  ? ui.TextDirection.ltr
                  : ui.TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: isConnected ? -5 : 5,
                      color: AppColor.bgColor,
                      boxShape: const NeumorphicBoxShape.circle(),
                    ),
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: AnimatedCheck(
                        condition: headsetEvent == HeadsetState.CONNECT,
                        lottieFile: 'assets/lottie/green-check.json',
                      ),
                    ),
                  ),
                  Text(
                    'connect_headphones'.tr(),
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Directionality(
              textDirection: context.locale.languageCode == ('ar')
                  ? ui.TextDirection.ltr
                  : ui.TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: isMax ? -5 : 5,
                      color: AppColor.bgColor,
                      boxShape: const NeumorphicBoxShape.circle(),
                    ),
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: AnimatedCheck(
                        condition: _volumeListenerValue == 1,
                        lottieFile: 'assets/lottie/green-check.json',
                      ),
                    ),
                  ),
                  Text(
                    "turn_the_volume_up".tr(),
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            NeumorphicButtons(
              textColor: goodToGo ? Colors.white : Colors.black,
              depth: goodToGo ? 5 : -5,
              text: ('start_the_test'.tr()),
              color: goodToGo ? null : AppColor.bgColor,
              beginColor: goodToGo ? AppColor.firstleniarColor : null,
              endColor: goodToGo ? AppColor.secondleniarColor : null,
              onPressed: () {
                if (goodToGo) Navigator.pushNamed(context, Routes.test);
              },
            ),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    VolumeController().removeListener();
    super.dispose();
  }
}
