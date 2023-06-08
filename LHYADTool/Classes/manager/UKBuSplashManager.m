//
//  UKBuSplashManager.m
//  AFNetworking
//
//  Created by Ocean 李 on 2023/6/3.
//

#import "UKBuSplashManager.h"
#import <BUAdSDK/BUAdSDK.h>
#import <BUAdSDK/BUSplashView.h>
#import "HYUKConfigManager.h"

static UKBuSplashManager * configManager = nil;

@interface UKBuSplashManager()<BUSplashAdDelegate>

@property (nonatomic, strong) BUSplashAd *splashAdView;
//@property (nonatomic, strong) UIImageView *bgImageView;
@property (copy, nonatomic) void (^close)(BOOL close);
@property (nonatomic, strong) UIViewController *rootVC;

@end

@implementation UKBuSplashManager

+(UKBuSplashManager *)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configManager = [[UKBuSplashManager alloc] init];
//        configManager.index = 1;
//        configManager.index = 0;
    });
    return configManager;
}

- (void)registerAppId {
    [BUAdSDKManager setAppID:[HYUKConfigManager shareInstance].ADIDModel.buAppId];
}

- (void)loadSplashAdWithVC:(UIViewController *)vc close:(void (^)(BOOL close))close
{
    self.close = close;
    self.rootVC = vc;
    
    self.splashAdView = [[BUSplashAd alloc] initWithSlotID:[HYUKConfigManager shareInstance].ADIDModel.buOpenId adSize:vc.view.bounds.size];
    self.splashAdView.delegate = self;
    [self.splashAdView loadAdData];
}

- (void)splashAdLoadSuccess:(BUSplashAd *)splashAd
{
    [splashAd showSplashViewInRootViewController:self.rootVC];
}

/// This method is called when material load failed
- (void)splashAdLoadFail:(BUSplashAd *)splashAd error:(BUAdError *_Nullable)error
{
    NSLog(@"splashAdLoadFail");
    [splashAd removeSplashView];
    self.splashAdView = nil;
    self.splashAdView.delegate = nil;
    self.close(YES);
}

/// This method is called when splash view render successful
- (void)splashAdRenderSuccess:(BUSplashAd *)splashAd{
    NSLog(@"splashAdRenderSuccess");

}

/// This method is called when splash view render failed
- (void)splashAdRenderFail:(BUSplashAd *)splashAd error:(BUAdError *_Nullable)error{
    NSLog(@"splashAdRenderFail");
    [splashAd removeSplashView];
    self.splashAdView = nil;
    self.splashAdView.delegate = nil;
    self.close(YES);
}

/// This method is called when splash view will show
- (void)splashAdWillShow:(BUSplashAd *)splashAd{
    NSLog(@"splashAdWillShow");

}

/// This method is called when splash view did show
- (void)splashAdDidShow:(BUSplashAd *)splashAd{
    NSLog(@"splashAdDidShow");

}

/// This method is called when splash view is clicked.
- (void)splashAdDidClick:(BUSplashAd *)splashAd {
    NSLog(@"splashAdDidClick");

}

/// This method is called when splash view is closed.
- (void)splashAdDidClose:(BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType {
    NSLog(@"splashAdDidClose自动结束");
}

/// This method is called when splash viewControllr is closed.
- (void)splashAdViewControllerDidClose:(BUSplashAd *)splashAd {
    
    [splashAd removeSplashView];
    self.splashAdView = nil;
    self.splashAdView.delegate = nil;
    self.close(YES);
    NSLog(@"splashAdViewControllerDidClose");
}

- (void)splashDidCloseOtherController:(nonnull BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
    NSLog(@"splashDidCloseOtherController");

}


- (void)splashVideoAdDidPlayFinish:(nonnull BUSplashAd *)splashAd didFailWithError:(nonnull NSError *)error {
    NSLog(@"splashVideoAdDidPlayFinish");
    [splashAd removeSplashView];
    self.splashAdView = nil;
    self.splashAdView.delegate = nil;
    self.close(YES);
}

@end
