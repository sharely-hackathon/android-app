import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:developer';

class NetworkImageUtil {
  /// 加载网络图片或本地图片
  /// [imageUrl] 图片URL或本地文件路径
  /// [width] 图片宽度
  /// [height] 图片高度
  /// [fit] 图片填充方式
  /// [placeholder] 加载中占位图
  /// [errorWidget] 加载失败占位图
  static Widget loadImage(
    String imageUrl, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
    double? radius,
  }) {
    // 添加日志以便调试
    log('正在加载图片: $imageUrl');
    
    // 网络图片
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) {
        log('图片加载中: $url');
        return placeholder ?? const Center(child: CircularProgressIndicator());
      },
      errorWidget: (context, url, error) {
        log('图片加载失败: $url, 错误: $error');
        return errorWidget ?? _buildErrorWidget(width, height, radius: radius);
      },
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 300),
      httpHeaders: const {
        'User-Agent': 'Mozilla/5.0 (Android 10; Mobile; rv:81.0) Gecko/81.0 Firefox/81.0',
      },
    );
  }

  /// 加载本地图片文件
  static Widget _loadLocalImage(
    String filePath, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? errorWidget,
  }) {
    final file = File(filePath);

    return FutureBuilder<bool>(
      future: file.exists(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData && snapshot.data == true) {
          return Image.file(
            file,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) =>
                errorWidget ?? _buildErrorWidget(width, height),
          );
        } else {
          return errorWidget ?? _buildErrorWidget(width, height);
        }
      },
    );
  }

  /// 构建错误显示组件
  static Widget _buildErrorWidget(double? width, double? height, {double? radius}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: radius != null ? BorderRadius.circular(radius) : null,
      ),
      child: const Icon(Icons.error, color: Colors.red),
    );
  }

  /// 加载圆形网络图片或本地图片
  /// [imageUrl] 图片URL或本地文件路径
  /// [size] 图片尺寸（宽高相等）
  /// [placeholder] 加载中占位图
  /// [errorWidget] 加载失败占位图
  static Widget loadCircleImage(
    String imageUrl, {
    double size = 50.0,
    Widget? placeholder,
    Widget? errorWidget,
    BoxFit fit = BoxFit.cover,
  }) {
    return ClipOval(
      child: loadImage(
        imageUrl,
        width: size,
        height: size,
        placeholder: placeholder,
        errorWidget: errorWidget,
        fit: fit,
      ),
    );
  }

  /// 加载圆角网络图片或本地图片
  /// [imageUrl] 图片URL或本地文件路径
  /// [width] 图片宽度
  /// [height] 图片高度
  /// [radius] 圆角半径
  /// [fit] 图片填充方式
  /// [placeholder] 加载中占位图
  /// [errorWidget] 加载失败占位图
  static Widget loadRoundedImage(
    String imageUrl, {
    double? width,
    double? height,
    double radius = 4.0,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) {
          log('图片加载中: $url');
          return placeholder ?? const Center(child: CircularProgressIndicator());
        },
        errorWidget: (context, url, error) {
          log('图片加载失败: $url, 错误: $error');
          return errorWidget ?? _buildErrorWidget(width, height, radius: radius);
        },
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 300),
        httpHeaders: const {
          'User-Agent': 'Mozilla/5.0 (Android 10; Mobile; rv:81.0) Gecko/81.0 Firefox/81.0',
        },
      ),
    );
  }

  /// 单独的圆角加载
  static Widget loadOnlyRoundedImage(
    String imageUrl, {
    double? width,
    double? height,
    double topLeft = 4.0,
    double topRight = 4.0,
    double bottomLeft = 4.0,
    double bottomRight = 4.0,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      ),
      child: loadImage(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: placeholder,
        errorWidget: errorWidget,
        radius: [topLeft, topRight, bottomLeft, bottomRight].reduce((a, b) => a < b ? a : b),
      ),
    );
  }

  /// 判断是否为本地文件路径
  static bool isLocalPath(String path) {
    return path.startsWith('/') || path.startsWith('file://');
  }

  /// 获取本地文件的URL表示
  static String getLocalFileUrl(String filePath) {
    if (filePath.startsWith('file://')) {
      return filePath;
    }
    return 'file://$filePath';
  }
}
