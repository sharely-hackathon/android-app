import 'dart:io';

import 'package:catcher_2/core/catcher_2.dart';
import 'package:catcher_2/handlers/file_handler.dart';
import 'package:catcher_2/mode/dialog_report_mode.dart';
import 'package:catcher_2/mode/silent_report_mode.dart';
import 'package:catcher_2/model/catcher_2_options.dart';
import 'package:catcher_2/model/report.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_ume_kit_dio_plus/flutter_ume_kit_dio_plus.dart';
import 'package:flutter_ume_plus/flutter_ume_plus.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sharely/ui/pages/main_page.dart';
import 'package:sharely/ui/pages/splash/splash_page.dart';
import 'package:sharely/utils/sp_utils.dart';
import 'package:sharely/widgets/custom_error_widget.dart';
import 'package:sharely/widgets/custom_loading_widget.dart';

import 'controller/bindings.dart';
import 'dio/dio_config.dart';
import 'dio/dio_manager.dart';
import 'dio/http_interceptor.dart';
import 'lang/translations.dart';

const testImg = 'https://picsum.photos/300/300';

var showOrHide = false.obs;

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

/// 错误过滤器函数，用于过滤图片加载失败的错误
bool errorFilterFunction(Report report) {
  if (report.error == null) return true;

  final String errorMsg = report.error.toString();

  // 定义需要过滤的错误模式
  final filters = [
    // 图片加载失败（支持常见图片格式）
    r'Failed to load http.*\.(png|jpg|jpeg|webp|gif)',
    // 资源加载失败
    r'Bad state: Failed to load',
    r'HttpException: Invalid statusCode: 404',
    r'(Unable to load asset|The asset does not exist or has empty data)',
    // SVG加载相关
    r'SvgLoader\._load',
    r'_VectorGraphicWidgetState\._loadPicture',
    r'NetworkImage\._load'
  ];

  // 使用正则表达式匹配
  final shouldFilter = filters.any(
      (pattern) => RegExp(pattern, caseSensitive: false).hasMatch(errorMsg));

  return !shouldFilter; // 匹配到任一模式则返回false
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 沉浸式状态栏
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  await SPUtils.init();

  String? ipAddress = SPUtils.get('ipAddress') as String?;
  flog('服务器地址：${ipAddress ?? DioConfig.baseUrl}');
  if (ipAddress != null) {
    DioConfig.baseUrl = ipAddress;
  }

  PluginManager.instance.register(DioInspector(dio: dio));

  Directory? externalDir;
  if (Platform.isAndroid || Platform.isIOS) {
    externalDir = await getApplicationCacheDirectory();
  }
  if (Platform.isMacOS) {
    externalDir = await getApplicationDocumentsDirectory();
  }
  var path = '';
  if (externalDir != null) {
    path = '${externalDir.path}/app_crash.txt';
  }
  flog('Crash_File_Path: $path');

  final debugOptions = Catcher2Options(
    kDebugMode ? DialogReportMode() : SilentReportMode(),
    [FileHandler(File(path))],
    filterFunction: errorFilterFunction, // 添加过滤器函数
  );
  final releaseOptions = Catcher2Options(
    kDebugMode ? DialogReportMode() : SilentReportMode(),
    [FileHandler(File(path))],
    filterFunction: errorFilterFunction, // 添加过滤器函数
  );

  if (showOrHide.value) {
    Catcher2(
      rootWidget: const MyApp(),
      debugConfig: debugOptions,
      releaseConfig: releaseOptions,
      ensureInitialized: true,
    );
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => Obx(() => UMEWidget(
            enable: showOrHide.value,
            child: GetMaterialApp(
              title: 'Sharely',
              initialBinding: InitialBindings(),
              navigatorObservers: [routeObserver],
              navigatorKey: Catcher2.navigatorKey,
              home: child,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('es', 'ES'),
              ],
              translations: Messages(),
              //跟随系统语言
              fallbackLocale: const Locale('en', 'US'),
              builder: FlutterSmartDialog.init(
                loadingBuilder: (String msg) => CustomLoadingWidget(
                  color: Colors.white,
                  size: 40.sp,
                  msg: msg,
                ),
                notifyStyle: FlutterSmartNotifyStyle(
                  warningBuilder: (String msg) => CustomWarnWidget(msg),
                ),
              ),
            ),
          )),
      child: MainPage(),
    );
  }
}
