//
//  HYUkRequestWorking.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/18.
//

#import "HYUkRequestWorking.h"
#import <YYKit/YYKit.h>

@implementation HYUkRequestWorking

+ (id)getVersionCompletionHandle:(void(^)(HYVideoVersionModel *model, BOOL success))completed
{
    
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    
    NSDictionary *dic = @{@"bundleid":bundleId};
    return [self GET:@"http://vod.wxspb.cn/api/index/get_version" parameters:dic complationHandle:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        if (!error) {
            HYVideoVersionBaseModel *model = [HYVideoVersionBaseModel modelWithDictionary:responseObject];
            completed(model.data, YES);
        }else {
            completed(nil, NO);
        }
    }];
}

@end
