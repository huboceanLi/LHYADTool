//
//  LHYADInitTool.m
//  LHYADTool
//
//  Created by oceanMAC on 2023/2/15.
//

#import "LHYADInitTool.h"
#import "LHYLinkViewController.h"
#import "LHYConfigManager.h"

@implementation LHYADInitTool

+ (void)initTool:(LHYADConfig *)config window:(UIWindow *)window enter:(void (^)(BOOL pt))enter
{
    if (config == nil || config.buAppId.length == 0) {
        enter(YES);
    }else {
        [LHYConfigManager shareInstance].buAppId = config.buAppId;
        [LHYConfigManager shareInstance].linkImage = config.linkImage;
        [LHYConfigManager shareInstance].buLinkId = config.buLinkId;

        [NSThread sleepForTimeInterval:0.5];
        
        LHYLinkViewController *rootVC = [[LHYLinkViewController alloc] init];//根控制器
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
        window.rootViewController = nav;
        window.backgroundColor = UIColor.whiteColor;
        [window makeKeyAndVisible];
        [rootVC showViewControllerRootVC:^(BOOL rootVC) {
            if (rootVC) {
                NSLog(@"进入主页");
                enter(YES);
            }
        }];
    }
}

@end
