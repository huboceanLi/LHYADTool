//
//  LHYConfigManager.m
//  LHYADTool
//
//  Created by oceanMAC on 2023/2/15.
//

#import "LHYConfigManager.h"

static LHYConfigManager * configManager = nil;

@implementation LHYConfigManager

+(LHYConfigManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configManager = [[LHYConfigManager alloc] init];
    });
    return configManager;
}

@end
