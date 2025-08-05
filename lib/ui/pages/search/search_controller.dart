import 'package:get/get.dart';

import '../../../base/base_controller.dart';
import '../../../main.dart';

// 重用Home页面的Product类
class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final double originalPrice;
  final double rating;
  final String earnPercentage;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.earnPercentage,
  });
}

class SearchController extends BaseController {
  // 搜索框文本
  final searchText = ''.obs;
  
  // 搜索结果商品
  final searchProducts = <Product>[].obs;
  
  // 是否有搜索结果
  final hasSearchResults = false.obs;
  
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
  final categories = <CategoryItem>[
    CategoryItem(
      title: 'Sports & outdoor',
      color: '8B4513',
      imagePath: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=200&fit=crop',
    ),
    CategoryItem(
      title: 'Beauty & Personal Care',
      color: 'A0A0A0',
      imagePath: 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=300&h=200&fit=crop',
    ),
    CategoryItem(
      title: '3C Products',
      color: '696969',
      imagePath: 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=300&h=200&fit=crop',
    ),
    CategoryItem(
      title: 'Grocery',
      color: 'D2B48C',
      imagePath: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=300&h=200&fit=crop',
    ),
    CategoryItem(
      title: 'Car supplies',
      color: '2F2F2F',
      imagePath: 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=300&h=200&fit=crop',
    ),
    CategoryItem(
      title: 'Home appliances',
      color: 'BDB76B',
      imagePath: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=300&h=200&fit=crop',
    ),
    CategoryItem(
      title: 'Jewelry',
      color: 'C4A484',
      imagePath: 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=300&h=200&fit=crop',
    ),
    CategoryItem(
      title: 'Furniture',
      color: 'A9A9A9',
      imagePath: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=300&h=200&fit=crop',
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // 初始化一些筛选项为选中状态
    selectedFilters.addAll(['Lip color', 'Ship from']);
  }

  // 搜索方法
  void onSearchChanged(String value) {
    searchText.value = value;
    
    // 如果有输入内容，显示搜索结果
    if (value.isNotEmpty) {
      hasSearchResults.value = true;
      _loadSearchResults();
    } else {
      hasSearchResults.value = false;
      searchProducts.clear();
    }
  }

  // 模拟加载搜索结果
  void _loadSearchResults() {
    searchProducts.value = [
      Product(
        id: '1',
        name: 'Daily Routine: Natural Finish Full Face Kit (4 PC)',
        image: testImg,
        price: 27.50,
        originalPrice: 30.25,
        rating: 4.52,
        earnPercentage: '8%',
      ),
      Product(
        id: '2',
        name: 'Jelly Balm Hydrating Lip Color...',
        image: testImg,
        price: 27.50,
        originalPrice: 30.25,
        rating: 4.52,
        earnPercentage: '8%',
      ),
      Product(
        id: '3',
        name: 'Spackle Skin Perfecting Primer',
        image: testImg,
        price: 27.50,
        originalPrice: 30.25,
        rating: 4.52,
        earnPercentage: '8%',
      ),
      Product(
        id: '4',
        name: 'Daily Routine: Natural Finish Full Face Kit (4 PC)',
        image: testImg,
        price: 27.50,
        originalPrice: 30.25,
        rating: 4.52,
        earnPercentage: '8%',
      ),
      Product(
        id: '5',
        name: 'Jelly Balm Hydrating Lip Color Premium',
        image: testImg,
        price: 27.50,
        originalPrice: 30.25,
        rating: 4.52,
        earnPercentage: '8%',
      ),
      Product(
        id: '6',
        name: 'Laura Geller Baked Blush-N-Brighten',
        image: testImg,
        price: 27.50,
        originalPrice: 30.25,
        rating: 4.52,
        earnPercentage: '8%',
      ),
    ];
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
    print('点击了商品: ${product.name}');
  }

  // 分类点击事件
  void onCategoryTap(CategoryItem category) {
    // 处理分类点击
    print('点击了分类: ${category.title}');
  }

  @override
  Future<void> fetchData() async {
  }
}

class CategoryItem {
  final String title;
  final String color;
  final String imagePath;

  CategoryItem({
    required this.title,
    required this.color,
    required this.imagePath,
  });
} 