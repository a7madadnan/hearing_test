import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hearing_test/constants/style_constants/app_colors.dart';
import 'package:hearing_test/components/neum_button.dart';
import 'package:hearing_test/components/neum_container.dart';
import 'package:hearing_test/routes/routes.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Neumorphic(
                style: const NeumorphicStyle(
                  color: AppColor.bgColor,
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Lottie.asset("assets/lottie/sound-bar-wave.json")),
              ),
              const SizedBox(
                height: 100,
              ),
              NeumorphicContainer(
                color: AppColor.bgColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'hearing_guider'.tr(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "home_description".tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 220,
              ),
              NeumorphicButtons(
                text: ('start'.tr()),
                beginColor: AppColor.firstleniarColor,
                endColor: AppColor.secondleniarColor,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.setup);
                },
              ),
            ]),
      ),
    );
  }
}
