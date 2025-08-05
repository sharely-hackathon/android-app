import 'package:get/get.dart';
import '../../../../base/base_controller.dart';
import '../shipping_address_edit/shipping_address_edit_page.dart';

class ShippingAddressController extends BaseController {
  // 收货地址列表
  final addressList = <ShippingAddressModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // 初始化示例数据
    _initSampleData();
  }

  @override
  Future<void> fetchData() async {
    // 这里可以从API获取收货地址列表
    // 目前使用本地示例数据
  }

  void _initSampleData() {
    addressList.addAll([
      ShippingAddressModel(
        id: '1',
        name: 'Johnny Dong',
        address: '38 King st',
        city: 'Banana, NY, USA 3083',
        phone: '+1 04306537',
      ),
      ShippingAddressModel(
        id: '2',
        name: 'Johnny Dong',
        address: '38 King st',
        city: 'Banana, NY, USA 3083',
        phone: '+1 04306537',
      ),
    ]);
  }

  // 添加新地址
  void addNewAddress() {
    Get.to(() => ShippingAddressEditPage());
  }

  // 编辑地址
  void editAddress(ShippingAddressModel address) {
    Get.to(() => ShippingAddressEditPage(), arguments: address);
  }

  // 删除地址
  void deleteAddress(String addressId) {
    addressList.removeWhere((address) => address.id == addressId);
  }
}

class ShippingAddressModel {
  final String id;
  final String name;
  final String address;
  final String city;
  final String phone;

  ShippingAddressModel({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.phone,
  });
} 