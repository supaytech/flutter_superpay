import 'dart:async';

import 'package:flutter/services.dart';

class SuperPayResult {
  ///
  final String memo;

  /// 支付后结果
  final String result;

  /// 支付状态，参考android和ios的sdk文档https://github.com/supaytech
  final String resultStatus;

  SuperPayResult({this.memo, this.result, this.resultStatus});

  @override
  String toString() {
    return "{mono: $memo, resultStatus:$resultStatus, result:$result}";
  }
}

class FlutterSuperpay {
  static const MethodChannel _channel = const MethodChannel('flutter_superpay');

  static Future<SuperPayResult> pay(
      String wxAppId, String payInfo, String channel) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'wxAppId': wxAppId,
      'payInfo': payInfo,
      'channel': channel, // 微信:wx  支付宝:alipay
    };
    var res = await _channel.invokeMethod('pay', params);
    return new SuperPayResult(
        result: res['result'],
        resultStatus: res['resultStatus'],
        memo: res['mono']);
  }
}
