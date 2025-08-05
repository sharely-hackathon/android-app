import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sharely/ui/pages/message/message_page.dart';
import 'package:sharely/ui/pages/rewards/rewards_page.dart';

import '../../utils/assets_utils.dart';
import '../../utils/color_utils.dart';
import 'home/home_page.dart';
import 'profile/profile_page.dart';
import 'main_controller.dart';

class MainPage extends StatelessWidget {
  final MainController controller = Get.put(MainController());

  MainPage({super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: 1.sw,
    height: 1.sh,
    color: Colors.white,
    child: Column(
      children: [
        Expanded(
          child: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [HomePage(), RewardsPage(), MessagePage(), ProfilePage()],
          ),
        ),
        _buildBottomNavigationBar(),
      ],
    ),
  );

  Widget _buildBottomNavigationBar() => Obx(
    () => BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: controller.currentIndex.value,
      onTap: controller.changePage,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: toColor("7E38FF"),
      unselectedItemColor: toColor('969696'),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        _buildNavItem(
          AssetsUtils.home_normal_ic,
          AssetsUtils.home_selected_ic,
          "",
        ),
        _buildNavItem(
          AssetsUtils.medal_normal_ic,
          AssetsUtils.medal_selected_ic,
          "",
        ),
        _buildNavItem(
          AssetsUtils.package_normal_ic,
          AssetsUtils.package_selected_ic,
          "",
        ),
        _buildNavItem(
          AssetsUtils.profile_normal_ic,
          AssetsUtils.profile_selected_ic,
          "",
        ),
      ],
    ),
  );

  BottomNavigationBarItem _buildNavItem(
    String icon,
    String selectedIcon,
    String label,
  ) => BottomNavigationBarItem(
    icon: SvgPicture.asset(icon, width: 30.w, height: 30.w),
    activeIcon: SvgPicture.asset(selectedIcon, width: 30.w, height: 30.w),
    label: label,
  );
}
