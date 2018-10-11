package com.example.fluttersuperpay

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.app.Activity


import android.widget.Toast

import com.recheng.superpay.callback.OnPayResultListener
import com.recheng.superpay.enums.PayWay
import com.recheng.superpay.pay.ChengPay
import com.recheng.superpay.pay.PayParams
import com.recheng.superpay.utils.LogUtil
import java.lang.Exception
import java.util.*


class FlutterSuperpayPlugin(private val mRegistrar: Registrar) : MethodCallHandler {

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar): Unit {
            val channel = MethodChannel(registrar.messenger(), "flutter_superpay")
            channel.setMethodCallHandler(FlutterSuperpayPlugin(registrar))
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result): Unit {
        if (call.method == "pay") {
//            result.success("Android ${android.os.Build.VERSION.RELEASE}")
            val payInfo = call.argument<String>("payInfo")
            val channel = call.argument<String>("channel")
            val wxAppId = if (call.hasArgument("wxAppId")){
                call.argument<String>("wxAppId")
            }else{
                ""
            }
            pay(mRegistrar.activity(),wxAppId, payInfo, channel, result)
        } else {
            result.notImplemented()
        }

    }

    /**
     * 支付
     */
    fun pay(currentActivity: Activity, wxAppId: String,payInfo: String, channel: String, callback: Result) {
        var result = HashMap<String, String>()
        try {
            val payBuilder = PayParams.Builder(currentActivity)
            when (channel) {
                "wx" -> {
                    payBuilder.payWay(PayWay.WechatPay)
                    //微信支付包名签名必须和官网一致  请注意!!!
                    payBuilder.wechatAppID(wxAppId)
                }
                "alipay" -> payBuilder.payWay(PayWay.AliPay)
            }
            val payParams = payBuilder.payInfo(payInfo).build()
            ChengPay.newInstance(payParams).doPay(object : OnPayResultListener {
                override fun onPaySuccess(payWay: PayWay) {
                    LogUtil.i("支付成功 " + payWay.toString())
                    result["memo"] = "支付成功"
                    result["result"] = "支付成功"
                    result["resultStatus"] = "0"
                    callback.success(result)
                }

                override fun onPayCancel(payWay: PayWay) {
                    LogUtil.i("支付取消 " + payWay.toString())
                    result["memo"] = "支付取消"
                    result["result"] = "支付取消"
                    result["resultStatus"] = "2"
                    callback.success(result)
                }

                override fun onPayFailure(payWay: PayWay, errCode: Int) {
                    LogUtil.i("其他错误 " + payWay.toString())
                    result["memo"] = "其他错误"
                    result["result"] = "其他错误"
                    result["resultStatus"] = "$errCode"
                    callback.success(result)
                }
            })
        } catch (e: Exception) {
            LogUtil.i("支付发生错误")
            e.printStackTrace()
            callback.error(e.message, "支付发生错误", e)
        }

    }
}
