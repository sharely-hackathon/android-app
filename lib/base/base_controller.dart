import 'package:get/get.dart';

// 基础页面控制器
abstract class BaseController extends GetxController
    with GetTickerProviderStateMixin {

  var isDataLoad = true.obs;

  int pageNum = 1;
  int pageSize = 20;
  // 总页数
  int totalPage = 0;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void _loadData() async {
    isDataLoad.value = true;
    await fetchData();
    // 这里假设子类会处理数据是否为空的情况
    isDataLoad.value = false;
  }

  // 抽象方法，子类必须实现
  Future<void> fetchData();
}
