import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../base/base_controller.dart';
import '../../../../controller/app_controller.dart';
import '../../../../models/address_model.dart';
import '../../../../models/region_model.dart';
import '../../../../apis/profile_api.dart';
import '../../../../utils/toast_utils.dart';
import '../../../../dio/http_interceptor.dart';
import '../shipping_address/shipping_address_controller.dart';

class ShippingAddressEditController extends BaseController {
  // 表单控制器
  final addressNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final companyController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final phoneController = TextEditingController();

  // 响应式变量
  final selectedCountry = Rxn<Country>();
  final countryDisplayText = ''.obs;
  final isEditMode = false.obs;
  
  // 要编辑的地址ID
  String? editingAddressId;

  @override
  void onInit() {
    super.onInit();
    // 检查是否是编辑模式
    final arguments = Get.arguments;
    if (arguments != null && arguments is Address) {
      isEditMode.value = true;
      editingAddressId = arguments.id;
    }
    
    // 加载区域数据
    fetchData();
  }

  @override
  void onClose() {
    addressNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    companyController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    phoneController.dispose();
    super.onClose();
  }

  @override
  Future<void> fetchData() async {
    // 使用AppController的缓存数据，如果没有缓存才调用API
    await AppController.find.getRegionData();
    
    // 如果是编辑模式，在数据加载完成后设置地址信息
    final arguments = Get.arguments;
    if (arguments != null && arguments is Address && isEditMode.value) {
      _loadAddressData(arguments);
    }
  }

  // 加载地址数据（编辑模式）
  void _loadAddressData(Address address) {
    addressNameController.text = ''; // 根据需要设置默认名称
    firstNameController.text = address.firstName;
    lastNameController.text = address.lastName;
    companyController.text = address.company;
    addressLine1Controller.text = address.address1;
    addressLine2Controller.text = address.address2;
    cityController.text = address.city;
    stateController.text = address.province;
    postalCodeController.text = address.postalCode;
    countryController.text = address.countryCode;
    phoneController.text = address.phone;
    
    // 根据国家代码查找对应的Country对象
    final countries = getCountryList();
    final country = countries.firstWhereOrNull((c) => c.iso2 == address.countryCode || c.name == address.countryCode);
    if (country != null) {
      selectedCountry.value = country;
      final displayText = country.displayName.isEmpty ? country.name : country.displayName;
      countryController.text = displayText;
      countryDisplayText.value = displayText;
    } else {
      selectedCountry.value = null;
      countryDisplayText.value = address.countryCode;
    }
  }

  // 选择国家
  void selectCountry(Country country) {
    selectedCountry.value = country;
    final displayText = country.displayName.isEmpty ? country.name : country.displayName;
    countryController.text = displayText;
    countryDisplayText.value = displayText;
  }

  // 获取所有区域中的去重国家列表
  List<Country> getCountryList() {
    return AppController.find.getCountryList();
  }

  // 保存地址
  Future<void> saveAddress() async {
    if (!_validateForm()) return;

    // 构建API请求参数
    final Map<String, dynamic> addressData = {
      "address_name": addressNameController.text.isNotEmpty ? addressNameController.text : "My Home",
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "company": companyController.text,
      "address_1": addressLine1Controller.text,
      "address_2": addressLine2Controller.text,
      "city": cityController.text,
      "postal_code": postalCodeController.text,
      "country_code": selectedCountry.value?.iso2 ?? countryController.text,
      "phone": phoneController.text,
      "province": stateController.text,
      "is_default_billing": false,
      "is_default_shipping": false,
    };

    try {
      bool result;
      
      if (isEditMode.value && editingAddressId != null) {
        // 更新现有地址
        result = await ProfileApi.updateUserAddress(
          addressId: editingAddressId!,
          map: addressData,
          isShowLoading: true,
          isShowErrMsg: true,
        );
      } else {
        // 新增地址
        result = await ProfileApi.addUserAddress(
          map: addressData,
          isShowLoading: true,
          isShowErrMsg: true,
        );
      }

      if (result) {
        // API调用成功
        showSuccess(isEditMode.value ? 'Address updated successfully'.tr : 'Address added successfully'.tr);
        
        // 刷新地址列表
        final shippingController = Get.find<ShippingAddressController>();
        await shippingController.fetchData();
        
        Get.back(result: true);
      } else {
        // API调用失败
        showError(isEditMode.value ? 'Failed to update address'.tr : 'Failed to add address'.tr);
      }
    } catch (e) {
      // 异常处理
      flog('保存地址失败: $e');
      showError(isEditMode.value ? 'Failed to update address'.tr : 'Failed to add address'.tr);
    }
  }

  // 取消操作
  void cancel() {
    Get.back();
  }

  // 验证表单
  bool _validateForm() {
    if (firstNameController.text.isEmpty) {
      showError('Please enter first name'.tr);
      return false;
    }
    if (lastNameController.text.isEmpty) {
      showError('Please enter last name'.tr);
      return false;
    }
    if (addressLine1Controller.text.isEmpty) {
      showError('Please enter address'.tr);
      return false;
    }
    if (cityController.text.isEmpty) {
      showError('Please enter city'.tr);
      return false;
    }
    if (stateController.text.isEmpty) {
      showError('Please enter province/state'.tr);
      return false;
    }
    if (postalCodeController.text.isEmpty) {
      showError('Please enter postal code'.tr);
      return false;
    }

    if (selectedCountry.value == null && countryController.text.isEmpty) {
      showError('Please select country'.tr);
      return false;
    }
    return true;
  }
} 