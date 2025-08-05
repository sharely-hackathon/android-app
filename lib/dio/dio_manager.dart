import 'package:dio/dio.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../utils/toast_utils.dart';
import 'base/base_response.dart';
import 'dio_config.dart';
import 'http_interceptor.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: DioConfig.baseUrl,
    headers: {"content-type": Headers.jsonContentType},
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
  ),
)..interceptors.add(HttpInterceptor());

class DioManager {
  // 请求，返回参数为 T
  // method：请求方法，NWMethod.POST等
  // path：请求地址
  // params：请求参数
  // success：请求成功回调
  // error：请求失败回调
  Future<BaseResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    String? tag,
    Options? options,
    required bool isShowLoading,
    required bool isShowErrMsg,
  }) async {
    try {
      if (isShowLoading) {
        showLoading(msg: "Loading...");
      }

      Response? response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );

      if (isShowLoading) {
        dismissLoading(status: SmartStatus.loading);
      }

      if (isShowErrMsg && response.statusCode != DioConfig.successCode) {
        showToast(response.statusMessage);
        BaseResponse result = BaseResponse.fromJson({
          BaseResponse.msgCon: '${response.statusMessage}',
          BaseResponse.dataCon: null,
        });

        return result;
      }

      return BaseResponse.fromJson({
        BaseResponse.msgCon: '${response.statusMessage}',
        BaseResponse.dataCon: response.data,
        BaseResponse.codeCon: DioConfig.successCode,
      });
    } on DioException catch (e) {
      if (isShowLoading) {
        dismissLoading(status: SmartStatus.loading);
      }
      BaseResponse errorBean = _createErrorEntity(e);
      if (isShowErrMsg) {
        showToast('${errorBean.message.toString()}(${errorBean.code})');
      }
      return errorBean;
    }
  }

  // 请求，返回参数为 T
  // method：请求方法，NWMethod.POST等
  // path：请求地址
  // params：请求参数
  // success：请求成功回调
  // error：请求失败回调
  Future<BaseResponse> post(
    String path, {
    data,
    String? tag,
    Options? options,
    required bool isShowLoading,
    required bool isShowErrMsg,
  }) async {
    try {
      if (isShowLoading) {
        showLoading(msg: "Loading...");
      }

      Response response = await dio.post(path, data: data, options: options);

      if (isShowLoading) {
        dismissLoading(status: SmartStatus.loading);
      }

      if (isShowErrMsg && response.statusCode != DioConfig.successCode) {
        showToast(response.statusMessage);
        BaseResponse result = BaseResponse.fromJson({
          BaseResponse.msgCon: '${response.statusMessage}',
          BaseResponse.dataCon: null,
        });

        return result;
      }

      return BaseResponse.fromJson({
        BaseResponse.msgCon: '${response.statusMessage}',
        BaseResponse.dataCon: response.data,
        BaseResponse.codeCon: DioConfig.successCode,
      });
    } on DioException catch (e) {
      if (isShowLoading) {
        dismissLoading(status: SmartStatus.loading);
      }
      BaseResponse errorBean = _createErrorEntity(e);
      if (isShowErrMsg) {
        showToast('${errorBean.message.toString()}(${errorBean.code})');
      }
      return errorBean;
    }
  }

  // PUT请求方法
  // path：请求地址
  // data：请求参数
  // tag：请求标签
  // options：Dio选项
  // isShowLoading：是否显示加载提示
  // isShowErrMsg：是否显示错误提示
  Future<BaseResponse> put(
    String path, {
    data,
    String? tag,
    Options? options,
    required bool isShowLoading,
    required bool isShowErrMsg,
  }) async {
    try {
      if (isShowLoading) {
        showLoading(msg: "Loading...");
      }

      Response response = await dio.put(path, data: data, options: options);

      if (isShowLoading) {
        dismissLoading(status: SmartStatus.loading);
      }

      if (isShowErrMsg && response.statusCode != DioConfig.successCode) {
        showToast(response.statusMessage);
        BaseResponse result = BaseResponse.fromJson({
          BaseResponse.msgCon: '${response.statusMessage}',
          BaseResponse.dataCon: null,
        });

        return result;
      }

      return BaseResponse.fromJson({
        BaseResponse.msgCon: '${response.statusMessage}',
        BaseResponse.dataCon: response.data,
        BaseResponse.codeCon: DioConfig.successCode,
      });
    } on DioException catch (e) {
      if (isShowLoading) {
        dismissLoading(status: SmartStatus.loading);
      }
      BaseResponse errorBean = _createErrorEntity(e);
      if (isShowErrMsg) {
        showToast('${errorBean.message.toString()}(${errorBean.code})');
      }
      return errorBean;
    }
  }

  // 删除请求，返回参数为 T
  // path：请求地址
  // queryParameters：查询参数
  // tag：请求标签
  // options：Dio选项
  // isShowLoading：是否显示加载提示
  // isShowErrMsg：是否显示错误提示
  Future<BaseResponse> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    String? tag,
    Options? options,
    required bool isShowLoading,
    required bool isShowErrMsg,
  }) async {
    try {
      if (isShowLoading) {
        showLoading(msg: "Loading...");
      }

      Response response = await dio.delete(
        path,
        queryParameters: queryParameters,
        options: options,
      );

      BaseResponse result = BaseResponse.fromJson(response.data);
      if (isShowLoading) {
        dismissLoading(status: SmartStatus.loading);
      }
      if (isShowErrMsg && result.code != DioConfig.successCode) {
        showToast(result.message);
        result.data = null;
      }

      return result;
    } on DioException catch (e) {
      if (isShowLoading) {
        dismissLoading(status: SmartStatus.loading);
      }
      BaseResponse errorBean = _createErrorEntity(e);
      if (isShowErrMsg) {
        showToast('${errorBean.message.toString()}(${errorBean.code})');
      }
      return errorBean;
    }
  }

  // 错误信息
  BaseResponse _createErrorEntity(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return BaseResponse.fromJson({BaseResponse.msgCon: 'Cancel Request'});
      case DioExceptionType.connectionTimeout:
        return BaseResponse.fromJson({BaseResponse.msgCon: 'Connection timeout'});
      case DioExceptionType.sendTimeout:
        return BaseResponse.fromJson({BaseResponse.msgCon: 'Send timeout'});
      case DioExceptionType.receiveTimeout:
        return BaseResponse.fromJson({BaseResponse.msgCon: 'Response timeout'});
      case DioExceptionType.connectionError:
        return BaseResponse.fromJson({BaseResponse.msgCon: 'Connection Error'});
      case DioExceptionType.badResponse:
        try {
          int? errCode = error.response?.statusCode;
          String? errMsg = error.response?.statusMessage;
          return BaseResponse.fromJson({
            BaseResponse.msgCon: errMsg,
            BaseResponse.codeCon: errCode,
          });
        } on Exception catch (_) {
          return BaseResponse.fromJson({BaseResponse.msgCon: error.message});
        }
      default:
        return BaseResponse.fromJson({BaseResponse.msgCon: error.message});
    }
  }
}
