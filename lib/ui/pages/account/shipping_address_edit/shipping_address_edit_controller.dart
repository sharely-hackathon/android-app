import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../base/base_controller.dart';
import '../shipping_address/shipping_address_controller.dart';

class ShippingAddressEditController extends BaseController {
  // 表单控制器
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();

  // 响应式变量
  final selectedCountry = ''.obs;
  final isEditMode = false.obs;
  
  // 要编辑的地址ID
  String? editingAddressId;

  @override
  void onInit() {
    super.onInit();
    // 检查是否是编辑模式
    final arguments = Get.arguments;
    if (arguments != null && arguments is ShippingAddressModel) {
      isEditMode.value = true;
      editingAddressId = arguments.id;
      _loadAddressData(arguments);
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    super.onClose();
  }

  @override
  Future<void> fetchData() async {
    // 这里可以从API获取国家列表等数据
  }

  // 加载地址数据（编辑模式）
  void _loadAddressData(ShippingAddressModel address) {
    final nameParts = address.name.split(' ');
    firstNameController.text = nameParts.isNotEmpty ? nameParts.first : '';
    lastNameController.text = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    
    addressLine1Controller.text = address.address;
    cityController.text = address.city.split(',').first.trim();
    
    // 解析城市信息，假设格式为 "City, State, Country PostalCode"
    final cityParts = address.city.split(',');
    if (cityParts.length >= 2) {
      stateController.text = cityParts[1].trim();
    }
    if (cityParts.length >= 3) {
      final lastPart = cityParts[2].trim().split(' ');
      countryController.text = lastPart.isNotEmpty ? lastPart.first : '';
      if (lastPart.length > 1) {
        postalCodeController.text = lastPart.sublist(1).join(' ');
      }
    }
  }

  // 选择国家
  void selectCountry(String country) {
    selectedCountry.value = country;
    countryController.text = country;
  }

  // 保存地址
  void saveAddress() {
    if (_validateForm()) {
      final newAddress = ShippingAddressModel(
        id: editingAddressId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: '${firstNameController.text} ${lastNameController.text}',
        address: addressLine1Controller.text,
        city: '${cityController.text}, ${stateController.text}, ${countryController.text} ${postalCodeController.text}',
        phone: '+1 04306537', // 这里可以添加电话号码字段
      );

      // 更新地址列表
      final shippingController = Get.find<ShippingAddressController>();
      if (isEditMode.value) {
        // 编辑模式：更新现有地址
        final index = shippingController.addressList.indexWhere((address) => address.id == editingAddressId);
        if (index != -1) {
          shippingController.addressList[index] = newAddress;
        }
      } else {
        // 新增模式：添加新地址
        shippingController.addressList.add(newAddress);
      }

      Get.back();
    }
  }

  // 取消操作
  void cancel() {
    Get.back();
  }

  // 验证表单
  bool _validateForm() {
    if (firstNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter first name');
      return false;
    }
    if (lastNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter last name');
      return false;
    }
    if (addressLine1Controller.text.isEmpty) {
      Get.snackbar('Error', 'Please enter address');
      return false;
    }
    if (cityController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter city');
      return false;
    }
    return true;
  }
} 