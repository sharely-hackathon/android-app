import 'package:get/get.dart';
import 'package:sharely/apis/profile_api.dart';
import 'package:sharely/models/address_model.dart';
import '../../../../base/base_controller.dart';
import '../shipping_address_edit/shipping_address_edit_page.dart';

class ShippingAddressController extends BaseController {
  // 收货地址列表
  final addressList = <Address>[].obs;
  final addressModel = Rxn<AddressModel>();

  @override
  void onInit() {
    super.onInit();
    // 获取真实数据
    fetchData();
  }

  @override
  Future<void> fetchData() async {
    final result = await ProfileApi.getUserAddress();
    if (result != null) {
      addressModel.value = result;
      addressList.assignAll(result.addresses.reversed);
    }
  }

  // 添加新地址
  void addNewAddress() async {
    final result = await Get.to(() => ShippingAddressEditPage());
    if (result != null) {
      fetchData();
    }
  }

  // 编辑地址
  void editAddress(Address address) async {
    final result = await Get.to(() => ShippingAddressEditPage(), arguments: address);
    if (result != null) {
      fetchData();
    }
  }

  // 删除地址
  void deleteAddress(String addressId) {
    addressList.removeWhere((address) => address.id == addressId);
  }
} 