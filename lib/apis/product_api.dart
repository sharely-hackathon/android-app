import 'package:dio/dio.dart';
import 'package:sharely/dio/dio_config.dart';

import '../dio/base/base_response.dart';
import '../dio/dio_manager.dart';
import '../models/category_model.dart';
import '../models/order_list_model.dart';
import '../models/product_model.dart';
import '../models/region_model.dart';

class ProductApi {

  static Future<RegionModel?> getRegionData({
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    BaseResponse result = await DioManager().get(
      'store/regions',
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    if (result.code != DioConfig.successCode) {
      return null;
    }

    return RegionModel.fromJson(result.data);
  }

  static Future<ProductModel?> getProductList({
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    final queryParameters = {
      'fields': '*variants.calculated_price,+variants.inventory_quantity,*variants,*seller.reviews,*seller.reviews.customer,*seller.reviews.seller,*seller.products.variants',
    };

    BaseResponse result = await DioManager().get(
      'store/products',
      queryParameters: queryParameters,
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    if (result.code != DioConfig.successCode) {
      return null;
    }

    return ProductModel.fromJson(result.data);
  }

  static Future<Product?> getProductById({
    required String productId,
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    // 添加 GraphQL fields 参数来获取价格信息
    final queryParameters = {
      'fields': '*variants.calculated_price,+variants.inventory_quantity,*variants,*seller,*seller.products,*seller.reviews,*seller.reviews.customer,*seller.reviews.seller,*seller.products.variants,*attribute_values,*attribute_values.attribute',
      'limit': '1',
    };

    BaseResponse result = await DioManager().get(
      'store/products/$productId',
      queryParameters: queryParameters,
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    if (result.code != DioConfig.successCode) {
      return null;
    }

    return Product.fromJson(result.data["product"]);
  }

  static Future<CategoryModel?> getProductCategories({
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    BaseResponse result = await DioManager().get(
      'store/product-categories',
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    if (result.code != DioConfig.successCode) {
      return null;
    }

    return CategoryModel.fromJson(result.data);
  }

  static Future<OrderListModel?> getOrders({
    bool isShowLoading = true,
    bool isShowErrMsg = true,
  }) async {
    final queryParameters = {
      'fields': 'shipping_total,total,currency_code,seller,*seller',
    };

    BaseResponse result = await DioManager().get(
      'store/orders',
      queryParameters: queryParameters,
      isShowLoading: isShowLoading,
      isShowErrMsg: isShowErrMsg,
    );

    if (result.code != DioConfig.successCode) {
      return null;
    }

    return OrderListModel.fromJson(result.data);
  }
}