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

@property (nonatomic, strong) BUSplashAdView *splashAdView;
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

- (void)loadSplashAdWithView:(UIView *)adView close:(void (^)(BOOL close))close
{
    self.close = close;
    
//    [self.splashAdView removeAllSubviews];
    
    self.splashAdView = [[BUSplashAdView alloc] initWithSlotID:[LHYConfigManager shareInstance].buLinkId frame:adView.bounds];
    self.splashAdView.delegate = self;
    [self.splashAdView loadAdData];
    self.splashAdView.alpha = 0.0;
    [adView addSubview:self.splashAdView];

    if ([LHYConfigManager shareInstance].linkImage == nil) {
    }else {
        self.bgImageView = [[UIImageView alloc] initWithFrame:adView.bounds];
        self.bgImageView.image = [LHYConfigManager shareInstance].linkImage;
        self.bgImageView.clipsToBounds = YES;
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [adView addSubview:self.bgImageView];
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
/**
 This method is called when splash ad material loaded successfully.
 */
- (void)splashAdDidLoad:(BUSplashAdView *)splashAd{
    [UIView animateWithDuration:0.5 animations:^{
        self.splashAdView.alpha = 1.0f;
        self.bgImageView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
    }];
}

/**
 This method is called when splash ad material failed to load.
 @param error : the reason of error
 */
- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError * _Nullable)error {
    if (error) {
        NSLog(@"%@",error);
        self.close(YES);
    }
}

/**
 This method is called when splash ad slot will be showing.
 */
- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
    
}

/**
 This method is called when splash ad is clicked.
 */
- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    self.close(YES);
//    [self.splashAdView removeAllSubviews];
    self.bgImageView.hidden = YES;
    self.splashAdView = nil;
}

/**
 This method is called when splash ad is closed.
 */
- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.close(YES);
//        [self.splashAdView removeAllSubviews];
        self.bgImageView.hidden = YES;
        self.splashAdView = nil;
    });
}

/**
 This method is called when splash ad is about to close.
 */
- (void)splashAdWillClose:(BUSplashAdView *)splashAd {
    
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType {
    
}

/**
 This method is called when spalashAd skip button  is clicked.
 */
- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    
}

/**
 This method is called when spalashAd countdown equals to zero
 */
- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    
}


@end
