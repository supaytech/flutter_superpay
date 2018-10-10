#import "FlutterSuperpayPlugin.h"
#import "SPSDKPay.h"

__weak FlutterSuperpayPlugin* __FlutterAlipayPlugin;

@interface FlutterSuperpayPlugin()

@property (readwrite,copy,nonatomic) FlutterResult callback;

@end

@implementation FlutterSuperpayPlugin

-(id)init{
    if(self = [super init]){
        
        __FlutterAlipayPlugin  = self;
        
    }
    return self;
}

-(void)dealloc{
    
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_superpay"
            binaryMessenger:[registrar messenger]];
  FlutterSuperpayPlugin* instance = [[FlutterSuperpayPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    NSDictionary *arguments = [call arguments];
    
    if ([@"pay" isEqualToString:call.method]) {
        NSString* urlScheme = [self fetchUrlScheme];
        if(!urlScheme){
            NSLog(@"superpay cannot be found in info.plist,please visit https://github.com/supaytech/superpay-ios-sdk or example.");
            return;
        }
        self.callback = result;
        [self pay:arguments[@"payInfo"] channel:arguments[@"channel"] urlScheme:[self fetchUrlScheme]];
    } else {
        result(FlutterMethodNotImplemented);
    }
    
}

-(NSString*)fetchUrlScheme{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSArray* types = [infoDic objectForKey:@"CFBundleURLTypes"];
    for(NSDictionary* dic in types){
        if([@"superpay" isEqualToString: [dic objectForKey:@"CFBundleURLName"]]){
            return [dic objectForKey:@"CFBundleURLSchemes"][0];
        }
    }
    return nil;
}

+ (BOOL)handleOpenURL:(NSURL *)url
       withCompletion:(SPSDKPayCompletion)completion{
    return [SPSDKPay handleOpenURL:url withCompletion:nil];
}

+ (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
       withCompletion:(SPSDKPayCompletion)completion{
    return [SPSDKPay handleOpenURL:url sourceApplication:sourceApplication withCompletion:nil];
}

-(void)pay:(NSString*)payInfo channel:(NSString *)channel urlScheme:(NSString*)urlScheme{
    SPSDKPaymentChannel _channel;
    if ([channel isEqualToString:@"wx"]) {
        _channel = SPSDKPaymentChannelWX;
    }else if ([channel isEqualToString:@"alipay"]){
        _channel = SPSDKPaymentChannelAliPay;
    }else{
        _channel = 999;
    }
    //获取到CFBundleURLSchemes
    [SPSDKPay createPayment:payInfo paymentChannel:_channel appURLScheme:urlScheme withCompletion:^(NSDictionary *result, SPSDKPayError *error) {
        NSLog(@"completion block: %@", result);
        if (error == nil && [result[@"status"] unsignedIntegerValue] == 200) {
            [self onGetResult:@{@"result":error.description, @"resultStatus":result[@"status"], @"mono":@"pay success!"}];
        } else {
            NSLog(@"Error: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
            [self onGetResult:@{@"result":error.description, @"resultStatus":[NSString stringWithFormat:@"%zd",error.code], @"mono":[error getMsg]}];
        }
    }];
}




-(void)onGetResult:(NSDictionary*)resultDic{
    if(self.callback!=nil){
        self.callback(resultDic);
        self.callback = nil;
    }
    
}

@end
