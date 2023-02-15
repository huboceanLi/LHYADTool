//
//  LHYADInitTool.h
//  LHYADTool
//
//  Created by oceanMAC on 2023/2/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LHYADConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHYADInitTool : NSObject

+ (void)initTool:(LHYADConfig *)config window:(UIWindow *)window enter:(void (^)(BOOL pt))enter;

@end

NS_ASSUME_NONNULL_END
