import '../dio/base/base_response.dart';
import '../dio/dio_config.dart';
import '../dio/dio_manager.dart';
import '../models/address_model.dart';
import '../models/points_history_model.dart';
import '../models/profile_model.dart';
import '../models/reward_model.dart';

class ProfileApi {

  static Future<String?> login({
    required Map<String, dynamic> map,
    bool isShowLoading = true,
    bool isShowErrMsg = false,
  }) async {
    BaseResponse result = await DioManager().post(
      'auth/customer/emailpass',
      data: map,
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    if (result.code == DioConfig.successCode) {
      return result.data["token"];
    }
    return null;
  }

  static Future<ProfileModel?> getProfile({
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    BaseResponse result = await DioManager().get(
      'store/customers/me',
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    if (result.code == DioConfig.successCode) {
      return ProfileModel.fromJson(result.data["customer"]);
    }
    return null;
  }

  // 获取用户 收货地址
  static Future<AddressModel?> getUserAddress({
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    BaseResponse result = await DioManager().get(
      'store/customers/me/addresses',
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    if (result.code == DioConfig.successCode) {
      return AddressModel.fromJson(result.data);
    }
    return null;
  }

  //  新增地址
  static Future<bool> addUserAddress({
    required Map<String, dynamic> map,
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    BaseResponse result = await DioManager().post(
      'store/customers/me/addresses',
      data: map,
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    return result.code == DioConfig.successCode;
  }

  //  更新地址
  static Future<bool> updateUserAddress({
    required String addressId,
    required Map<String, dynamic> map,
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    BaseResponse result = await DioManager().post(
      'store/customers/me/addresses/$addressId',
      data: map,
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    return result.code == DioConfig.successCode;
  }

  static Future<RewardModel?> getRewardCenter({
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    BaseResponse result = await DioManager().get(
      'store/loyalty/center',
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    if (result.code == DioConfig.successCode) {
      return RewardModel.fromJson(result.data);
    }
    return null;
  }

  static Future<PointsHistoryModel?> getPoints({
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    BaseResponse result = await DioManager().get(
      'store/loyalty/points',
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    if (result.code == DioConfig.successCode) {
      return PointsHistoryModel.fromJson(result.data);
    }
    return null;
  }
}