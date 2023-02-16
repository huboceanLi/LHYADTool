//
//  LHYBUAdLinkManager.m
//  LHYADTool
//
//  Created by oceanMAC on 2023/2/15.
//

#import "LHYBUAdLinkManager.h"
#import "LHYConfigManager.h"

static LHYBUAdLinkManager * configManager = nil;

@interface LHYBUAdLinkManager()<BUSplashAdDelegate>

@property (nonatomic, strong) BUSplashAd *splashAd;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (copy, nonatomic) void (^close)(BOOL close);

@end

@implementation LHYBUAdLinkManager

+(LHYBUAdLinkManager *)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configManager = [[LHYBUAdLinkManager alloc] init];
    });
    return configManager;
}

- (void)registerAppId {
    [BUAdSDKManager setAppID:[LHYConfigManager shareInstance].buAppId];
}

- (void)loadSplashAdWithView:(UIViewController *)vc close:(void (^)(BOOL close))close
{
    self.close = close;
    
    self.splashAd = [[BUSplashAd alloc] initWithSlotID:[LHYConfigManager shareInstance].buLinkId adSize:vc.view.bounds.size];
    self.splashAd.delegate = self;

    [self.splashAd showSplashViewInRootViewController:vc];
    [self.splashAd loadAdData];

    if ([LHYConfigManager shareInstance].linkImage == nil) {
    }else {
        self.bgImageView = [[UIImageView alloc] initWithFrame:[LHYConfigManager shareInstance].linkRect];
        self.bgImageView.image = [LHYConfigManager shareInstance].linkImage;
        self.bgImageView.clipsToBounds = YES;
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [vc.view addSubview:self.bgImageView];
    }

    
//    NSArray *list = @[
//        @{ @"slotID" : @"945494753" , @"adType" : @(GromoreAdTypeBanner) , @"adDesc" : @"banner广告" },
//        @{ @"slotID" : @"887383142" , @"adType" : @(GromoreAdTypeSplash) , @"adDesc" : @"开屏广告" },
//        @{ @"slotID" : @"887418500" , @"adType" : @(GromoreAdTypeSplash) , @"adDesc" : @"开屏广告" },
//        @{ @"slotID" : @"945494755" , @"adType" : @(GromoreAdTypeInterstitial) , @"adDesc" : @"插屏广告" },
//        @{ @"slotID" : @"945494760" , @"adType" : @(GromoreAdTypeNative) , @"adDesc" : @"自渲染native广告" },
//        @{ @"slotID" : @"945494759" , @"adType" : @(GromoreAdTypeNative) , @"adDesc" : @"模板native广告" },
//        @{ @"slotID" : @"945494761" , @"adType" : @(GromoreAdTypeNative) , @"adDesc" : @"模板native广告" },
//        @{ @"slotID" : @"945494747" , @"adType" : @(GromoreAdTypeRewardedVideo) , @"adDesc" : @"激励广告" },
//        @{ @"slotID" : @"945494739" , @"adType" : @(GromoreAdTypeRewardedVideo) , @"adDesc" : @"激励广告" },
//        @{ @"slotID" : @"945490586" , @"adType" : @(GromoreAdTypeRewardedVideo) , @"adDesc" : @"激励广告" },
//        @{ @"slotID" : @"945494751" , @"adType" : @(GromoreAdTypeFullscreenVideo) , @"adDesc" : @"全屏广告" },
//        @{ @"slotID" : @"945494752" , @"adType" : @(GromoreAdTypeFullscreenVideo) , @"adDesc" : @"全屏广告" },
//        @{ @"slotID" : @"946961656" , @"adType" : @(GromoreAdTypeInterstitialPro) , @"adDesc" : @"插全屏广告" },
//        @{ @"slotID" : @"948388643" , @"adType" : @(GromoreAdTypeDraw) , @"adDesc" : @"draw广告" }
//   ];
    
}

- (void)splashAdLoadSuccess:(BUSplashAd *)splashAd {
//    NSLog(@"splashAdLoadSuccess");
}

/// This method is called when material load failed
- (void)splashAdLoadFail:(BUSplashAd *)splashAd error:(BUAdError *_Nullable)error {
    NSLog(@"%@",error);
}

/// This method is called when splash view render successful
- (void)splashAdRenderSuccess:(BUSplashAd *)splashAd {
//    NSLog(@"splashAdRenderSuccess");
}

/// This method is called when splash view render failed
- (void)splashAdRenderFail:(BUSplashAd *)splashAd error:(BUAdError *_Nullable)error {
    NSLog(@"%@",error);
}

/// This method is called when splash view will show
- (void)splashAdWillShow:(BUSplashAd *)splashAd {
//    NSLog(@"splashAdWillShow");
    [UIView animateWithDuration:0.25 animations:^{
        self.bgImageView.alpha = 0.0f;
    } completion:^(BOOL finished) {

    }];
}

/// This method is called when splash view did show
- (void)splashAdDidShow:(BUSplashAd *)splashAd {
//    NSLog(@"splashAdDidShow");
    self.bgImageView.hidden = YES;
}

/// This method is called when splash view is clicked.
- (void)splashAdDidClick:(BUSplashAd *)splashAd {
//    NSLog(@"splashAdDidClick");

}

/// This method is called when splash view is closed.
- (void)splashAdDidClose:(BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType {
//    NSLog(@"splashAdDidClose");
    self.close(YES);
    [self.splashAd removeSplashView];
}

/// This method is called when splash viewControllr is closed.
- (void)splashAdViewControllerDidClose:(BUSplashAd *)splashAd {
//    NSLog(@"splashAdViewControllerDidClose");
    [self.splashAd removeSplashView];
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)splashDidCloseOtherController:(BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
//    NSLog(@"splashDidCloseOtherController");
}

/// This method is called when when video ad play completed or an error occurred.
- (void)splashVideoAdDidPlayFinish:(BUSplashAd *)splashAd didFailWithError:(NSError *)error {
//    NSLog(@"%@",error);
}
@end
