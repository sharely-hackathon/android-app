import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

import '../../../base/base_scaffold.dart';
import '../../../utils/toast_utils.dart';
import '../../../dio/http_interceptor.dart';

class WebViewPage extends StatelessWidget {
  final String title;
  final String url;
  final Map<String, String?>? cookies;
  late final WebViewController _webViewController;

  WebViewPage({
    super.key,
    required this.title,
    required this.url,
    this.cookies,
  }) {
    _initWebViewController();
  }

  // 初始化WebViewController
  void _initWebViewController() {
    showLoading();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
          },
          onPageStarted: (String url) async {
          },
          onPageFinished: (String url) async {
            dismissLoading();
          },
          onWebResourceError: (WebResourceError error) {
            dismissLoading();
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
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: title,
      onBack: () async {
        //关闭当前 H5
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return;
        }
        Get.back();
      },
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
