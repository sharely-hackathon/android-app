import '../dio/base/base_response.dart';
import '../dio/dio_config.dart';
import '../dio/dio_manager.dart';
import '../models/cart_model.dart';

class CartApi {

  // 查询购物车
  static Future<CartModel?> queryCartById({
    required String cartId,
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    BaseResponse result = await DioManager().get(
      'store/carts/$cartId',
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    if (result.code == DioConfig.successCode) {
      return CartModel.fromJson(result.data);
    }

    return null;
  }

  // 创建购物车
  static Future<CartModel?> createCart({
    String? regionId,
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    BaseResponse result = await DioManager().post(
      'store/carts',
      data: {"region_id": regionId},
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    if (result.code == DioConfig.successCode) {
      return CartModel.fromJson(result.data);
    }

    return null;
  }

  // 添加购物车
  static Future<bool> addProductToCart({
    required String cartId,
    required Map<String, dynamic> map,
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    BaseResponse result = await DioManager().post(
      'store/carts/$cartId/line-items',
      data: map,
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    return result.code == DioConfig.successCode;
  }
}
