import 'dart:async';

import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharely/utils/toast_utils.dart';

import '../../../apis/product_api.dart';
import '../../../base/base_controller.dart';
import '../../../dio/http_interceptor.dart';
import '../../../main.dart';
import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../product_detail/product_detail_page.dart';

class SearchController extends BaseController {
  // 搜索框文本
  final searchController = TextEditingController();
  
  // 搜索结果商品
  final searchProducts = <Product>[].obs;
  
  // 是否有搜索结果
  final hasSearchResults = false.obs;
  
  // 搜索错误状态
  final searchError = Rxn<String>();
  
  // 是否已经开始搜索过
  final hasStartedSearch = false.obs;
  
  // 筛选相关
  final selectedFilters = <String>[].obs;
  final filterOptions = [
    'Lip color',
    'Ship from',
    'Category',
    'Sort by',
    'Brand',
    'Price range',
  ];
  
  // 分类数据
  final categories = Rxn<CategoryModel>();

  // 搜索结果加载状态
  final isSearching = false.obs;
  
  // Algolia搜索器
  HitsSearcher? _productsSearcher;
  
  // 防抖定时器
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    // 初始化一些筛选项为选中状态
    selectedFilters.addAll(['Lip color', 'Ship from']);
    
    // 初始化Algolia搜索器，简化配置避免超时错误
    _productsSearcher = HitsSearcher(
      applicationID: 'EFCKPE6UFP',
      apiKey: '325d229a873e1df5da3f9e10468b6a9a',
      indexName: 'products',
      insights: false, // 禁用insights以提高性能
    );
    
    // 监听搜索结果，添加错误处理
    _productsSearcher?.responses.listen(
      (response) {
        _handleSearchResponse(response);
      },
      onError: (error) {
        _handleSearchError(error);
      },
    );
  }

  // 搜索方法（用于输入框内容变化）
  void onSearchChanged(String value) {
    searchController.text = value;
    
    // 取消之前的防抖定时器
    _debounceTimer?.cancel();
    
    // 如果有输入内容，延迟搜索
    if (value.trim().isNotEmpty) {
      hasStartedSearch.value = true; // 标记已开始搜索
      hasSearchResults.value = true;
      
      // 设置防抖延迟，避免频繁搜索
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        _loadSearchResults();
      });
    } else {
      // 输入框为空时，重置状态但保持已搜索过的标记
      hasSearchResults.value = false;
      searchProducts.clear();
      searchError.value = null;
      isSearching.value = false;
    }
  }
  
  // 立即搜索方法（用于搜索按钮点击）
  void performSearch() {
    _debounceTimer?.cancel();
    if (searchController.text.trim().isNotEmpty) {
      hasStartedSearch.value = true; // 标记已开始搜索
      hasSearchResults.value = true;
      _loadSearchResults();
    }
  }
  
  // 手动重试搜索（用于UI重试按钮）
  void manualRetry() {
    if (searchController.text.trim().isNotEmpty) {
      hasStartedSearch.value = true; // 标记已开始搜索
      hasSearchResults.value = true;
      _loadSearchResults();
    }
  }

  // 执行搜索
  void _loadSearchResults() async {
    if (_productsSearcher == null || searchController.text.trim().isEmpty) {
      return;
    }
    
    try {
      isSearching.value = true;
      searchError.value = null; // 清除错误状态

      // 设置搜索查询
      _productsSearcher!.applyState((state) => state.copyWith(
        query: searchController.text.trim(),
        page: 0, // 重置到第一页
      ));
      
    } catch (e) {
      flog('搜索出错: $e');
      _handleSearchError(e);
    }
  }

  // 处理搜索响应
  void _handleSearchResponse(SearchResponse response) {
    try {
      isSearching.value = false;
      
      final hits = response.hits;
      final products = <Product>[];
      
      for (final hit in hits) {
        try {
          // 从Algolia返回的数据中解析商品信息，适配真实的Product模型
          final product = Product(
            id: hit['objectID'] ?? '',
            title: hit['title'] ?? hit['name'] ?? '未知商品',
            subtitle: hit['subtitle'] ?? '',
            description: hit['description'] ?? '',
            handle: hit['handle'] ?? '',
            isGiftcard: hit['is_giftcard'] ?? false,
            discountable: hit['discountable'] ?? true,
            thumbnail: hit['thumbnail'] ?? hit['image'] ?? hit['imageUrl'] ?? testImg,
            collectionId: hit['collection_id'] ?? '',
            typeId: hit['type_id'],
            weight: hit['weight'],
            length: hit['length'],
            height: hit['height'],
            width: hit['width'],
            hsCode: hit['hs_code'],
            originCountry: hit['origin_country'],
            midCode: hit['mid_code'],
            material: hit['material'],
            createdAt: hit['created_at'] != null ? DateTime.tryParse(hit['created_at']) : null,
            updatedAt: hit['updated_at'] != null ? DateTime.tryParse(hit['updated_at']) : null,
            type: hit['type'],
            collection: hit['collection'] != null ? Tion.fromJson(hit['collection']) : null,
            options: hit['options'] != null 
                ? List<OptionsModel>.from(hit['options'].map((x) => OptionsModel.fromJson(x)))
                : [],
            tags: hit['tags'] != null 
                ? List<dynamic>.from(hit['tags'].map((x) => x))
                : [],
            images: hit['images'] != null 
                ? List<ImageModel>.from(hit['images'].map((x) => ImageModel.fromJson(x)))
                : [],
            variants: hit['variants'] != null 
                ? List<Variant>.from(hit['variants'].map((x) => Variant.fromJson(x)))
                : [],
            seller: hit['seller'] != null ? Seller.fromJson(hit['seller']) : null,
          );
          products.add(product);
          
          // 调试日志：显示解析出的商品信息
          flog('成功解析商品: ${product.title}');
          flog('图片数量: ${product.images.length}');
          flog('变体数量: ${product.variants.length}');
          flog('卖家信息: ${product.seller?.name ?? "无卖家"}');
          
        } catch (e) {
          flog('解析商品数据出错: $e');
          flog('错误的hit数据: $hit');
          continue;
        }
      }
      
      searchProducts.value = products;
      hasSearchResults.value = products.isNotEmpty;
      searchError.value = null; // 清除错误状态
      
      // 如果没有搜索结果，显示提示
      if (products.isEmpty && searchController.text.trim().isNotEmpty) {
        flog('搜索关键词"${searchController.text}"没有找到相关商品');
      }
      
    } catch (e) {
      flog('处理搜索结果出错: $e');
      _handleSearchError(e);
    }
  }
  
  // 处理搜索错误
  void _handleSearchError(dynamic error) {
    flog('搜索出现错误: $error');

    // 如果不是网络错误或已达到最大重试次数，则处理错误
    isSearching.value = false;
    searchProducts.clear();
    hasSearchResults.value = false;
    
    // 根据错误类型显示不同的提示信息
    String errorMessage = 'Search failed, please try again later'.tr;
    
    if (error.toString().contains('timeout') || error.toString().contains('connection')) {
      errorMessage = 'The network connection timed out. Please check the network connection and try again.'.tr;
    } else if (error.toString().contains('UnreachableHostsException')) {
      errorMessage = 'Unable to connect to the search service, please check your network connection'.tr;
    }
    
    // 设置错误状态供UI显示
    searchError.value = errorMessage;
    
    // 为了不打扰用户，这里只记录日志，不显示Toast
    flog('搜索错误提示: $errorMessage');
  }
  
  @override
  void onClose() {
    _debounceTimer?.cancel();
    _productsSearcher?.dispose();
    searchController.dispose();
    super.onClose();
  }

  // 筛选项点击
  void onFilterTap(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
  }

  // 商品点击事件
  void onProductTap(Product product) {
    // 处理商品点击
    Get.to(() => ProductDetailPage(), arguments: product.id);
  }

  // 分类点击事件
  void onCategoryTap(ProductCategory? category) {
    // 处理分类点击
  }

  @override
  Future<void> fetchData() async {
    categories.value = await ProductApi.getProductCategories();
  }
}