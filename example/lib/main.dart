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
    _payInfo = "";
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
    _payInfo = "{\"appid\":\"wxeae61855935702fb\",\"noncestr\":\"f8b3dacef9c146f8a8e55e0f4630be5e\",\"package\":\"Sign=WXPay\",\"partnerid\":\"232028432\",\"prepayid\":\"wx06200512915760d46c7c6ac32367430420\",\"sign\":\"597ED7F160249C28A26021121DC1C919\",\"timestamp\":\"1533557113\"}";
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
