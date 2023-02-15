//
//  LHYBUAdLinkManager.h
//  LHYADTool
//
//  Created by oceanMAC on 2023/2/15.
//

#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHYBUAdLinkManager : NSObject

+(LHYBUAdLinkManager *)shared;

- (void)registerAppId;

- (void)loadSplashAdWithView:(UIView *)adView close:(void (^)(BOOL close))close;

@end

NS_ASSUME_NONNULL_END
