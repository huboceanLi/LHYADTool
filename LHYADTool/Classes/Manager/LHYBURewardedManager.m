//
//  LHYBURewardedManager.m
//  LHYADTool
//
//  Created by oceanMAC on 2023/2/16.
//

#import "LHYBURewardedManager.h"
#import "LHYConfigManager.h"

static LHYBURewardedManager * configManager = nil;

@interface LHYBURewardedManager()<BUNativeExpressRewardedVideoAdDelegate>

@property (nonatomic, strong) BUNativeExpressRewardedVideoAd *rewardedAd;
@property (copy, nonatomic) void (^reward)(RewardedState rewardState);

@end

@implementation LHYBURewardedManager

+(LHYBURewardedManager *)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configManager = [[LHYBURewardedManager alloc] init];
    });
    return configManager;
}

- (void)loadBURewarded {
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"tag123";
    self.rewardedAd = [[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:[LHYConfigManager shareInstance].buRewardedId rewardedVideoModel:model];
    self.rewardedAd.delegate = self;
    // optional
//       self.rewardedAd.rewardPlayAgainInteractionDelegate = self.expressRewardedVideoAgainDelegateObj;
    [self.rewardedAd loadAdData];}

- (void)showBURewardedWithViewController:(UIViewController *)vc reward:(void (^)(RewardedState rewardState))reward
{
    self.reward = reward;
    if ([LHYConfigManager shareInstance].isRequstRewarded) {
        if (self.rewardedAd) {
            [self.rewardedAd showAdFromRootViewController:vc];
        }
    }else {
        self.reward(Rewarded_get_reward);
    }

}

// mark BUNativeExpressRewardedVideoAdDelegate

/**
 This method is called when video ad material loaded successfully.
 */
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"Rewarded load Success");
}

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"%@",error);
    if ([LHYConfigManager shareInstance].isRequstRewarded) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"Request rewarded again");
            [self loadBURewarded];
        });
    }
}
/**
  this methods is to tell delegate the type of native express rewarded video Ad
 */
- (void)nativeExpressRewardedVideoAdCallback:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd withType:(BUNativeExpressRewardedVideoAdType)nativeExpressVideoType {
//    NSLog(@"nativeExpressRewardedVideoAdCallback");
}

/**
 This method is called when cached successfully.
 For a better user experience, it is recommended to display video ads at this time.
 And you can call [BUNativeExpressRewardedVideoAd showAdFromRootViewController:].
 */
- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
//    NSLog(@"nativeExpressRewardedVideoAdDidDownLoadVideo");
}

/**
 This method is called when rendering a nativeExpressAdView successed.
 It will happen when ad is show.
 */
- (void)nativeExpressRewardedVideoAdViewRenderSuccess:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
//    NSLog(@"nativeExpressRewardedVideoAdViewRenderSuccess");
}

/**
 This method is called when a nativeExpressAdView failed to render.
 @param error : the reason of error
 */
- (void)nativeExpressRewardedVideoAdViewRenderFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    NSLog(@"%@",error);
}

/**
 This method is called when video ad slot will be showing.
 */
- (void)nativeExpressRewardedVideoAdWillVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"Rewarded will show");
}

/**
 This method is called when video ad slot has been shown.
 */
- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"nativeExpressRewardedVideoAdDidVisible");
}

/**
 This method is called when video ad is about to close.
 */
- (void)nativeExpressRewardedVideoAdWillClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"nativeExpressRewardedVideoAdWillClose");

}

/**
 This method is called when video ad is closed.
 */
- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
//    NSLog(@"nativeExpressRewardedVideoAdDidClose");
    if ([LHYConfigManager shareInstance].isRequstRewarded) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"Request rewarded again");
            [self loadBURewarded];
        });
    }
}

/**
 This method is called when video ad is clicked.
 */
- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"nativeExpressRewardedVideoAdDidClick");

}

/**
 This method is called when the user clicked skip button.
 */
- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"Close Don't reward");
    self.reward(Rewarded_Not_reward);
}

/**
 This method is called when video ad play completed or an error occurred.
 @param error : the reason of error
 */
- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"%@",error);
}

/**
 Server verification which is requested asynchronously is succeeded. now include two v erify methods:
      1. C2C need  server verify  2. S2S don't need server verify
 @param verify :return YES when return value is 2000.
 */
- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    NSLog(@"Success in obtaining rewards");
    self.reward(Rewarded_get_reward);
}

/**
  Server verification which is requested asynchronously is failed.
  @param rewardedVideoAd express rewardVideo Ad
  @param error request error info
 */
- (void)nativeExpressRewardedVideoAdServerRewardDidFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    NSLog(@"%@",error);
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressRewardedVideoAdDidCloseOtherController:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd interactionType:(BUInteractionType)interactionType {
//    NSLog(@"nativeExpressRewardedVideoAdDidCloseOtherController");

}

@end
