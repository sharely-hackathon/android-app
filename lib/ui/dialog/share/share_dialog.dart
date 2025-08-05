import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:sharely/utils/toast_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../dio/http_interceptor.dart';

class ShareDialog extends StatelessWidget {
  ShareDialog({
    super.key,
    required this.handle,
    required this.url,
    this.cookies,
  }) {
    _initWebViewController();
  }

  final String handle;
  final Map<String, String?>? cookies;
  final String url;

  late final WebViewController _webViewController;

  // 初始化WebViewController
  void _initWebViewController() {
    showLoading();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) async {},
          onPageFinished: (String url) async {
            dismissLoading(status: SmartStatus.loading);
          },
          onWebResourceError: (WebResourceError error) {
            dismissLoading(status: SmartStatus.loading);
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );

    // 先设置cookie再加载页面
    _initCookiesAndLoadPage();
  }

  // 初始化cookies并加载页面
  Future<void> _initCookiesAndLoadPage() async {
    if (cookies != null) {
      await _setCookies();
      // 等待一小段时间确保cookie设置完成
      await Future.delayed(const Duration(milliseconds: 100));
    }
    _webViewController.loadRequest(Uri.parse(url));
  }

  // 设置cookies（带重试机制）
  Future<void> _setCookies() async {
    if (cookies == null) return;

    final uri = Uri.parse(url);
    final cookieManager = WebViewCookieManager();

    // 重试最多3次
    for (int attempt = 1; attempt <= 3; attempt++) {
      try {
        for (final entry in cookies!.entries) {
          if (entry.value != null) {
            await cookieManager.setCookie(
              WebViewCookie(
                name: entry.key,
                value: entry.value.toString(),
                domain: uri.host,
                path: '/',
              ),
            );
            flog('设置cookie成功 (尝试 $attempt): ${entry.key}=${entry.value}');
          }
        }

        // 验证cookie是否设置成功
        await Future.delayed(const Duration(milliseconds: 50));
        flog('Cookie设置完成，第$attempt次尝试成功');
        return;
      } catch (e) {
        flog('设置cookie失败 (尝试 $attempt): $e');
        if (attempt < 3) {
          await Future.delayed(Duration(milliseconds: 100 * attempt));
        }
      }
    }

    flog('Cookie设置最终失败，已重试3次');
  }

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      width: 0.8.sw,
      height: 0.7.sh,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: WebViewWidget(controller: _webViewController),
    ),
  );
}
