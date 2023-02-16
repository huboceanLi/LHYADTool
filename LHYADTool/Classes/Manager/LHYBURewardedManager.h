//
//  LHYBURewardedManager.h
//  LHYADTool
//
//  Created by oceanMAC on 2023/2/16.
//

#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RewardedState) {
    Rewarded_request_error = 0,       //
    Rewarded_Not_reward ,    //
    Rewarded_get_reward,      //
};

@interface LHYBURewardedManager : NSObject

+(LHYBURewardedManager *)shared;

- (void)loadBURewarded;

- (void)showBURewardedWithViewController:(UIViewController *)vc reward:(void (^)(RewardedState rewardState))reward;

@end

NS_ASSUME_NONNULL_END
