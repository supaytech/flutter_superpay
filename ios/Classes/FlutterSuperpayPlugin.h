#import <Flutter/Flutter.h>
#import "SPSDKPay.h"
@interface FlutterSuperpayPlugin : NSObject<FlutterPlugin>

+ (BOOL)handleOpenURL:(NSURL *)url
       withCompletion:(SPSDKPayCompletion)completion;

+ (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
       withCompletion:(SPSDKPayCompletion)completion;

@end
