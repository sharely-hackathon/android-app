import '../dio/base/base_response.dart';
import '../dio/dio_config.dart';
import '../dio/dio_manager.dart';

class LoginApi {

  static Future<String?> authApi({
    required Map<String, dynamic> map,
    bool isShowLoading = false,
    bool isShowErrMsg = false,
  }) async {
    BaseResponse result = await DioManager().get(
      'admin/api-keys',
      queryParameters: map,
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    if (result.code == DioConfig.successCode) {
      return result.data;
    }

    return null;
  }
}