class BaseResponse {
  int code;
  dynamic data;
  String? message;

  static const String codeCon = 'code';
  static const String dataCon = 'data';
  static const String msgCon = 'msg';

  BaseResponse({this.code = 200, this.data, this.message});

  factory BaseResponse.fromJson(json) {
    try {
      return BaseResponse(
        code: json[codeCon] ?? -1,
        // data值需要经过工厂转换为我们传进来的类型
        data: json[dataCon] ?? json.toString(),
        message: json[msgCon] ?? '未知异常',
      );
    } catch (e) {
      return BaseResponse(
        code: -1,
        // data值需要经过工厂转换为我们传进来的类型
        data: json.toString(),
        message: '未知异常',
      );
    }
  }
}
