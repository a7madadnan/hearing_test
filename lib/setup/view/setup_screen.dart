import 'package:easy_localization/easy_localization.dart';

import 'dart:ui' as ui;
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
                    style:const  TextStyle(fontSize: 20),
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
                if (goodToGo) Navigator.pushNamed(context, Routes.gen);
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
// return Column(
//           children: [
//             !realEstate.isUrgent
//                 ? Material(
//                     elevation: 5,
//                     color: Colors.white,
//                     child: SizedBox(
//                       height: 60,
//                       width: MediaQuery.of(context).size.width,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 19),
//                                   child: Text(
//                                     context.l10n.upgrade_the_add_to,
//                                     style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 Container(
//                                     height: 35,
//                                     width: 100,
//                                     decoration: BoxDecoration(
//                                         color: AppColors.red,
//                                         borderRadius: BorderRadius.circular(4)),
//                                     child: Center(
//                                         child: TextButton(
//                                       style: TextButton.styleFrom(
//                                           padding: const EdgeInsets.all(0)),
//                                       onPressed: () => context.router.push(
//                                           PromoteUrgentRoute(
//                                               id: realEstate.id,
//                                               lotNumber: realEstate.lotNumber)),
//                                       child: Text(
//                                         context.l10n.urgent,
//                                         style: const TextStyle(
//                                             fontSize: 18,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ))),
//                               ],
//                             ),
//                             const Icon(
//                               Icons.chevron_right,
//                               color: Colors.black,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   children: [
//                     Stack(
//                       children: [
//                         BaityCarouselSlider(images: images),
//                         if (_store.isSold)
//                           const SoldSign()
//                         else if (realEstate.isExpired && _store.isSold)
//                           const SoldSign()
//                         else if (realEstate.isExpired)
//                           SoldSign(
//                             text: context.l10n.expired,
//                           ),
//                       ],
//                     ),
//                     realEstate.isUrgent
//                         ? Container(
//                             height: 40,
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                                 color: AppColors.red,
//                                 borderRadius: BorderRadius.circular(4)),
//                             child: Center(
//                               child: Text(
//                                 context.l10n.urgent,
//                                 style: const TextStyle(
//                                     fontSize: 18,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           )
//                         : const SizedBox.shrink(),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12.0, horizontal: 35),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           IconText(
//                             title: images.length.toString(),
//                             icon: Icons.camera_alt,
//                           ),
//                           IconText(
//                             title: realEstate.views.threeDigitFormatter(),
//                             icon: Icons.remove_red_eye_rounded,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Card(
//                       margin: const EdgeInsets.only(bottom: 2),
//                       child: Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 10),
//                         color: Colors.white,
//                         child: Text(
//                           _store.reTranslations?.title != null
//                               ? _store.reTranslations!.title
//                               : realEstate.title,
//                           style: context.textTheme.titleMedium
//                               ?.copyWith(color: AppColors.lightBlue),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     RealEstateIconsRow(
//                       nofBathRooms: realEstate.nofBathRooms,
//                       nofBedrooms: realEstate.nofTotalBedRooms,
//                       nofLivingRooms: realEstate.nofTotalLivingRooms,
//                       parkingCapacity: realEstate.parkingCapacity,
//                       padding: context.sizeQuery.width <= 320 ? 3.0 : 12.0,
//                       withBorder: true,
//                     ),
//                     const SizedBox(height: 12),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Card(
//                         elevation: 4.0,
//                         shadowColor: Colors.grey,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(7.0),
//                           side:
//                               const BorderSide(color: Colors.black12, width: 1),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 10,
//                             horizontal: 12,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 4.0),
//                               TableItem(
//                                 title: realEstate
//                                         .user.userTypeView.isConstructionCompany
//                                     ? context
//                                         .l10n.category_and_subcategory_project
//                                     : context.l10n.category_and_subcategory,
//                                 value: realEstate.isResidentialComplex
//                                     ? realEstate.getRCRECategory(context.l10n)
//                                     : realEstate.categorySubcategory ?? "",
//                                 padding: EdgeInsets.zero,
//                                 style: context.textTheme.titleSmall
//                                     ?.copyWith(fontWeight: FontWeight.bold),
//                               ),
//                               realEstate.user.userTypeView.maybeWhen(
//                                 constructionCompany: SizedBox.shrink,
//                                 orElse: () => TableItem(
//                                   title: context.l10n.offer_type,
//                                   value: context.l10n.translateOfferType(
//                                       realEstate.offerType!),
//                                   padding: EdgeInsets.zero,
//                                   style: context.textTheme.titleSmall
//                                       ?.copyWith(fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               TableItem(
//                                 title: context.l10n.published_date,
//                                 value:
//                                     "${realEstate.createdAt.timeToPeriod(context.l10n)} "
//                                     "${context.l10n.brackets(realEstate.createdAt.changeFormat(pattern: DateFormats.timeFormat).fixDirectionality)}",
//                                 padding: const EdgeInsets.all(0),
//                                 style: context.textTheme.titleSmall
//                                     ?.copyWith(fontWeight: FontWeight.bold),
//                               ),
//                               if (realEstate.expiresAt != null &&
//                                       realEstate.isMyRealEstate ||
//                                   realEstate.user.role ==
//                                       UserRole.constructionCompany)
//                                 TableItem(
//                                   title: context.l10n.expiration_date,
//                                   value: realEstate.expiresAt!.changeFormat(
//                                       pattern: DateFormats.dotted),
//                                   padding: const EdgeInsets.all(0),
//                                   style: context.textTheme.titleSmall
//                                       ?.copyWith(fontWeight: FontWeight.bold),
//                                 ),
//                               TableItem(
//                                 title: context.l10n.total_area,
//                                 value: AreaUnit(realEstate.area)
//                                     .formattedAreaWithUnit(
//                                   context.l10n,
//                                 ),
//                                 padding: EdgeInsets.zero,
//                                 style: context.textTheme.titleSmall
//                                     ?.copyWith(fontWeight: FontWeight.bold),
//                               ),
//                               if (!realEstate.isResidentialComplex)
//                                 realEstate.user.userTypeView.maybeWhen(
//                                   constructionCompany: SizedBox.shrink,
//                                   residentialComplex: SizedBox.shrink,
//                                   orElse: () => TableItem(
//                                     title: context.l10n.ownership,
//                                     value: context.l10n.translateREOwnership(
//                                             realEstate.ownershipType) ??
//                                         context.l10n.none,
//                                     padding: EdgeInsets.zero,
//                                     style: context.textTheme.titleSmall
//                                         ?.copyWith(fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               if (!realEstate
//                                   .user.userTypeView.isConstructionCompany)
//                                 TableItem(
//                                   title:
//                                       realEstate.offerType == REOfferType.rent
//                                           ? context.l10n.price_rent
//                                           : context.l10n.price_sale,
//                                   value: realEstate.getFormattedPrice(
//                                     context.settings.currency,
//                                     context.l10n,
//                                   ),
//                                   padding: EdgeInsets.zero,
//                                   style: context.textTheme.titleMedium
//                                       ?.copyWith(color: AppColors.lightBlue),
//                                 ),
//                               if (realEstate.nearestPoint != null &&
//                                   realEstate.nearestPoint!.isNotEmpty)
//                                 TableItem(
//                                   title: context.l10n.nearest_point,
//                                   value: realEstate.nearestPoint!,
//                                   padding: EdgeInsets.zero,
//                                   style: context.textTheme.titleSmall
//                                       ?.copyWith(fontWeight: FontWeight.bold),
//                                 ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       realEstate.place,
//                                       style: context.textTheme.titleSmall
//                                           ?.copyWith(
//                                               fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   if (context.settings.position != null &&
//                                       realEstate.location != null)
//                                     Expanded(
//                                       child: IconText(
//                                         title:
//                                             MapUtils.calculateDistanceWithUnit(
//                                           realEstate.location!,
//                                           context.settings.position!.location,
//                                           context.l10n,
//                                         ),
//                                         icon: Icons.location_on,
//                                         iconColor: Colors.red,
//                                         rowDirection:
//                                             context.l10n.localeName == "ar"
//                                                 ? TextDirection.rtl
//                                                 : TextDirection.ltr,
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),