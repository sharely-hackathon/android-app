import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharely/utils/sp_utils.dart';

import '../../../lang/translations.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/toast_utils.dart';

class SwitchLanguageDialog extends StatelessWidget {
  var isEnglish = true.obs;

  SwitchLanguageDialog({super.key}) {
    Locale? locale = Get.locale;
    isEnglish.value = locale == ENGLISH;
  }

  @override
  Widget build(BuildContext context) => Container(
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SELECT LANGUAGE'.tr,
                  style: TextStyle(
                    color: toColor('#3D3D3D'),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () => dismissLoading(),
                  child: Text(
                    'CANCEL'.tr,
                    style: TextStyle(
                      color: toColor('#767676'),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () => isEnglish.value = false,
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Español",
                        style: TextStyle(
                          color: isEnglish.value
                              ? toColor('#767676')
                              : toColor('#1A1A1A'),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      !isEnglish.value
                          ? Icon(
                              Icons.check_circle,
                              size: 20.sp,
                            )
                          : Icon(
                              Icons.check_circle,
                              size: 20.sp,
                              color: Colors.transparent,
                            )
                    ],
                  ).paddingOnly(top: 30.h)),
            ),
            Divider(
              color: toColor("EEEEEE"),
              height: 1.h,
            ).marginSymmetric(
              vertical: 20.h,
            ),
            InkWell(
              onTap: () => isEnglish.value = true,
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "English",
                        style: TextStyle(
                          color: !isEnglish.value
                              ? toColor('#767676')
                              : toColor('#1A1A1A'),
                          fontSize: 14.sp,
                        ),
                      ),
                      isEnglish.value
                          ? Icon(
                              Icons.check_circle,
                              size: 20.sp,
                            )
                          : Icon(
                              Icons.check_circle,
                              size: 20.sp,
                              color: Colors.transparent,
                            )
                    ],
                  )),
            ),
            Divider(
              color: toColor("EEEEEE"),
              height: 1.h,
            ).marginSymmetric(
              vertical: 20.h,
            ),
            InkWell(
              onTap: () => switchLanguage(),
              child: Container(
                width: 1.sw,
                height: 44.h,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Center(
                  child: Text(
                    'Confirm'.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  void switchLanguage() async {
    Locale locale =
        isEnglish.value ? const Locale('en', 'US') : const Locale('es', 'ES');
    await Get.updateLocale(locale);
    SPUtils.setLocal(locale.languageCode);
    dismissLoading();
  }
}
