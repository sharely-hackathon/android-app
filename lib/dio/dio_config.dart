class DioConfig {
  // 接口成功以后的返回码
  static const int successCode = 200;

  // token失效
  static const int tokenUnavaliable = 401;

  /// 地址前缀接口地址  ： api base url: https://api.sharely.dev/  ；接口密钥： publishable key:
  // pk_e15ee2e35fa70aa35033d31c7650a3c105d6c86547356586b6ab85a21ecca3ef ；文档  https://sharely-api-docs.pages.dev/
  static String baseUrl = 'https://api.sharely.dev/';
}