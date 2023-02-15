//
//  LHYConfigManager.h
//  LHYADTool
//
//  Created by oceanMAC on 2023/2/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHYConfigManager : NSObject

+ (instancetype)shareInstance;

//link image
@property (nonatomic, strong) UIImage *linkImage;
//buadsdk app id
@property (nonatomic, strong) NSString *buAppId;
//buadsdk link id
@property (nonatomic, strong) NSString *buLinkId;

@end

NS_ASSUME_NONNULL_END
