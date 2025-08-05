import 'dart:developer' as f;
import 'package:dio/dio.dart';

import '../utils/sp_utils.dart';

void flog(v, [String? name]) => f.log(v.toString(), name: name ?? 'flog');

class HttpInterceptor extends Interceptor {

  // 添加密钥常量
  static const String _publishableKey = 'pk_e15ee2e35fa70aa35033d31c7650a3c105d6c86547356586b6ab85a21ecca3ef';

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['x-publishable-api-key'] = _publishableKey;

    String? token = SPUtils.get("token") as String?;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    StringBuffer sb = StringBuffer();
    sb.writeln('********* 网络请求 *********');
    sb.writeln('uri: ${options.uri}');
    sb.writeln('method: ${options.method}');
    sb.writeln('extra: ${options.extra}');
    sb.writeln('headers: ${options.headers}');
    
    // 处理FormData的输出
    if (options.data is FormData) {
      FormData formData = options.data as FormData;
      
      // 提取表单字段
      Map<String, dynamic> formFields = {};
      for (var field in formData.fields) {
        formFields[field.key] = field.value;
      }
      
      // 提取文件字段
      Map<String, dynamic> fileInfo = {};
      for (var file in formData.files) {
        // 收集文件信息
        Map<String, dynamic> fileDetails = {
          'fileName': file.value.filename,
          'contentType': file.value.contentType?.toString(),
          'length': file.value.length,
        };
        fileInfo[file.key] = fileDetails;
      }
      
      sb.writeln('data(FormData): {');
      sb.writeln('  fields: $formFields,');
      sb.writeln('  files: $fileInfo');
      sb.writeln('}');
    } else {
      sb.writeln('data: ${options.data}');
    }
    
    sb.writeln('queryParameters: ${options.queryParameters}');

    flog(sb.toString());

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    StringBuffer sb = StringBuffer();
    sb.writeln('********* 网络出现错误 *********');
    sb.writeln('DioError $err');
    if (err.response != null) {
      sb.writeln('uri: ${err.response?.requestOptions.uri}');
      sb.writeln('statusCode: ${err.response?.statusCode}');
    }
    flog(sb.toString());
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    StringBuffer sb = StringBuffer();
    sb.writeln('********* 网络成功返回 *********');
    sb.writeln('uri: ${response.requestOptions.uri}');
    sb.writeln('statusCode: ${response.statusCode}');
    if (response.isRedirect == true) {
      sb.writeln('redirect: ${response.realUri}');
    }

    sb.writeln('Response Content: ${response.toString()}');
    flog(sb.toString());

    handler.next(response);
  }
}
