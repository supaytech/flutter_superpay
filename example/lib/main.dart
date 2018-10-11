import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_superpay/flutter_superpay.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _payInfo = "";
  String _channel = "";
  String _wxAppId = "";
  SuperPayResult _payResult;

  @override
  void initState() {
    super.initState();
  }


  callAlipay() async {
    _payInfo = "partner=\"2088421584120261\"&out_trade_no=\"FI102010001101101320256\"&subject=\"东风雪铁龙\"&body=\"爱丽舍-三厢 1.6 MT\"&total_fee=\"0.01\"¬ify_url=\"https://fcw.supaytechnology.com/fcw/server/ALIPAY10201-VS.htm\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&seller_id=\"2088421584120261\"¤cy=\"AUD\"&forex_biz=\"FP\"&it_b_pay=\"7d\"&secondary_merchant_id=\"1000\"&secondary_merchant_name=\"Super\"&secondary_merchant_industry=\"8299\"&sign=\"Ad9776%2F8FT3E%2Ffp1p49gw1%2FQXr%2FB%2FPkUt8D6krzi3%2FvKizcul8Ag7%2FXzuVKUJFVFXHDIyroFCoDY778WLYfls1zIEL4648PqsTPsbWgbtw%2Bra8cPDmURTocI7bCzFhuTp229aZM3cxPV4UHGiqC9TTSZbQhfE9KHvti%2BrOQIgNE%3D\"&sign_type=\"RSA\"";
    _channel = "alipay";
    dynamic payResult;
    try {
      print("The pay info is : " + _payInfo + _channel);
      payResult = await FlutterSuperpay.pay("",_payInfo, _channel);
    } on Exception catch (e) {
      print(e);
      e.toString();
    }

    if (!mounted) return;

    setState(() {
      _payResult = payResult;
    });
  }

  callWX() async {
    _payInfo = "{\"appid\":\"wx6c94cedf0b0fe9f9\",\"noncestr\":\"425e9656254d489c97eb28e340c0c6c8\",\"package\":\"Sign=WXPay\",\"partnerid\":\"217980731\",\"prepayid\":\"wx111536186968150f3961085e2748601527\",\"sign\":\"50F129EDE3D48E7FBB5B90AD6B5ADDB4\",\"timestamp\":\"1539243378\"}";
    _channel = "wx";
    _wxAppId = "wx6c94cedf0b0fe9f9";
    dynamic payResult;
    try {
      print("The pay info is : " +_wxAppId+ _payInfo + _channel);
      payResult = await FlutterSuperpay.pay(_wxAppId,_payInfo, _channel);
    } on Exception catch (e) {
      payResult = null;
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _payResult = payResult;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('SuperPay example'),
        ),
        body: new SingleChildScrollView(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new RaisedButton(onPressed: callWX, child: new Text("调用微信")),
              new RaisedButton(onPressed: callAlipay, child: new Text("调用支付宝")),
              new Text(_payResult == null ? "null" : _payResult.toString())
            ],
          ),
        ),
      ),
    );
  }
}
