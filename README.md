# LHYADTool

[![CI Status](https://img.shields.io/travis/li437277219@gmail.com/LHYADTool.svg?style=flat)](https://travis-ci.org/li437277219@gmail.com/LHYADTool)
[![Version](https://img.shields.io/cocoapods/v/LHYADTool.svg?style=flat)](https://cocoapods.org/pods/LHYADTool)
[![License](https://img.shields.io/cocoapods/l/LHYADTool.svg?style=flat)](https://cocoapods.org/pods/LHYADTool)
[![Platform](https://img.shields.io/cocoapods/p/LHYADTool.svg?style=flat)](https://cocoapods.org/pods/LHYADTool)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

1、配置

NSUserTrackingUsageDescription = "App需要请授权访问唯一标示（idfa）, 可以为您推荐更好的广告"

build setting 修改 BitCode = NO

2、initSDK

    #import <LHYADTool/LHYADTool.h>

    AppDelegate的didFinishLaunchingWithOptions中实现以下方法
     
    LHYADConfig *config = [LHYADConfig new];
    config.buAppId = @"5000546";
    config.buLinkId = @"887383142";
    config.buRewardedId = @"945494747";
    config.isRequstRewarded = YES;
    config.linkImage = [UIImage imageNamed:@"linkImage"];
    config.linkRect = CGRectMake(0, 100, 300, 400);
    
    __weak typeof(self) weakSelf = self;
    [LHYADInitTool initTool:config window:self.window enter:^(BOOL pt) {

    }];
    
    备注： isRequstRewarded表示是否需要请求激励广告；linkImage可不传；linkRect可不传（当有linkImage默认全屏）

3、展示激励广告

        [[LHYBURewardedManager shared] showBURewardedWithViewController:self reward:^(RewardedState rewardState) {
        if (rewardState == Rewarded_request_error) {
            NSLog(@"激励广告没有准备好");
        }else if (rewardState == Rewarded_get_reward) {
            NSLog(@"可以获取奖励");
        }else {
            NSLog(@"不能获取奖励");
        }
    }];
    


## Requirements

## Installation

LHYADTool is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LHYADTool'
```

## Author

oceanLi, li437277219@gmail.com

## License

LHYADTool 目前只支持buad 启动、激励广告，持续更新中...
