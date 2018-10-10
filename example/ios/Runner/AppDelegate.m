#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "FlutterSuperpayPlugin.h"

@implementation AppDelegate

-(NSString*)fetchUrlScheme{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSArray* types = [infoDic objectForKey:@"CFBundleURLTypes"];
    for(NSDictionary* dic in types){
        if([@"superpay" isEqualToString:  [dic objectForKey:@"CFBundleURLName"]]){
            return [dic objectForKey:@"CFBundleURLSchemes"][0];
        }
    }
    return nil;
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    NSLog(@"==========%@",[self fetchUrlScheme]);
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

// iOS 8 及以下请用这个
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FlutterSuperpayPlugin handleOpenURL:url sourceApplication:sourceApplication withCompletion:nil];
}

// iOS 9 以上请用这个
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    return [FlutterSuperpayPlugin handleOpenURL:url withCompletion:nil];
}

@end
