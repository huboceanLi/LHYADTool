//
//  LHYViewController.m
//  LHYADTool
//
//  Created by li437277219@gmail.com on 02/15/2023.
//  Copyright (c) 2023 li437277219@gmail.com. All rights reserved.
//

#import "LHYViewController.h"
#import <LHYADTool/LHYADTool.h>

@interface LHYViewController ()

@end

@implementation LHYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    itemBtn.frame = CGRectMake((375 - 100)/2, 100, 100, 40);
    itemBtn.backgroundColor = [UIColor blueColor];
    [itemBtn setTitle:@"获取激励广告" forState:UIControlStateNormal];
    [itemBtn addTarget:self action:@selector(ButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:itemBtn];
}

- (void)ButtonClick {
    [[LHYBURewardedManager shared] showBURewardedWithViewController:self reward:^(RewardedState rewardState) {
        if (rewardState == Rewarded_request_error) {
            NSLog(@"激励广告没有准备好");
        }else if (rewardState == Rewarded_get_reward) {
            NSLog(@"可以获取奖励");
        }else {
            NSLog(@"不能获取奖励");
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
