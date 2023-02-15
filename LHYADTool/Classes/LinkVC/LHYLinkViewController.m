//
//  LHYLinkViewController.m
//  LHYADTool
//
//  Created by oceanMAC on 2023/2/15.
//

#import "LHYLinkViewController.h"
#import "LHYConfigManager.h"
#import<CoreTelephony/CTCellularData.h>
#import "LHYReachability.h"
#import <QMUIKit/QMUIKit.h>
#import "LHYBUAdLinkManager.h"

@interface LHYLinkViewController ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (copy, nonatomic) void (^rootVC)(BOOL rootVC);
@property (nonatomic) LHYReachability *hostReachability;
@property (nonatomic, strong) QMUIButton *tipButton;

@end

@implementation LHYLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;

    if ([LHYConfigManager shareInstance].linkImage == nil) {
    }else {
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        bgImageView.image = [LHYConfigManager shareInstance].linkImage;
        bgImageView.clipsToBounds = YES;
        bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:bgImageView];
        self.bgImageView = bgImageView;
    }
    
    self.tipButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
    self.tipButton.imagePosition = QMUIButtonImagePositionTop;
    self.tipButton.spacingBetweenImageAndTitle = 6;
    [self.tipButton setTitle:@"网络错误\n点击重试!" forState:0];
    self.tipButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.tipButton.titleLabel.numberOfLines = 0;
    [self.tipButton setTitleColor:UIColor.blackColor forState:0];
    [self.view addSubview:self.tipButton];
    [self.tipButton addTarget:self action:@selector(TipButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.tipButton.frame = self.view.bounds;
    self.tipButton.hidden = YES;
    
    self.hostReachability = [LHYReachability reachabilityWithHostName:@"http://www.baidu.com"];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
}

- (void)TipButtonClick {
    [self updateInterfaceWithReachability:self.hostReachability];
}

- (void)updateInterfaceWithReachability:(LHYReachability *)reachability{
    if (reachability == self.hostReachability){
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        switch (netStatus){
            case NotReachable: {
                self.tipButton.hidden = NO;
                NSLog(@"ViewController : 没有网络！");
                break;
            }
            case ReachableViaWWAN: {
                
                NSLog(@"ViewController : 4G/3G");
                self.tipButton.hidden = YES;
                [self showLinkAd];
                [self.hostReachability stopNotifier];
                break;
            }
            case ReachableViaWiFi: {
                
                NSLog(@"ViewController : WiFi");
                self.tipButton.hidden = YES;
                [self showLinkAd];
                [self.hostReachability stopNotifier];
                break;
            }
        }
    }
}

- (void)showViewControllerRootVC:(void (^)(BOOL rootVC))rootVC
{
    self.rootVC = rootVC;
}

- (void)showLinkAd {
    [[LHYBUAdLinkManager shared] registerAppId];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __weak typeof(self) weakSelf = self;
        [[LHYBUAdLinkManager shared] loadSplashAdWithView:self.view close:^(BOOL close) {
            weakSelf.rootVC(YES);
        }];
    });
}
//- (void)networkStatus {
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"CHOOSENET"]){
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CHOOSENET"];
//        CTCellularData *cellularData = [[CTCellularData alloc] init];
////        [self addReachabilityManager];
//        __weak typeof(self) weakSelf = self;
//        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
//    //        if (weakSelf.haveNet == NO) {
//    //            weakSelf.haveNet = YES;
////                [weakSelf addReachabilityManager];
//    //        }
//
//    //        if (state == kCTCellularDataRestrictedStateUnknown) {
//    //            NSLog(@"网络不通：%@",@(state) );
//    //        }else if (state == kCTCellularDataRestricted) {
//    //            [weakSelf addReachabilityManager];
//    //            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"CHOOSENET"]){
//    //                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CHOOSENET"];
//    //            }else{
//    //                if (state == kCTCellularDataRestricted) {
//    //                    if (weakSelf.haveNet == NO) {
//    //                        weakSelf.haveNet = YES;
//    //                        [weakSelf iCloudQuery];
//    //                    }
//    //                    NSLog(@"网络通过WIFI：%@",@(state) );//弹框前状态，，，弹框后选择了无线
//    //                }
//    //            }
//    //        }
//    //        else if (state == kCTCellularDataNotRestricted) {
//    //            if (weakSelf.haveNet == NO) {
//    //                weakSelf.haveNet = YES;
//    //                [weakSelf iCloudQuery];
//    //            }
//    //            NSLog(@"网络通过WIFI或移动网连接：%@",@(state));//选择了无线和流量
//    //        }
//        };
//    }else{
////        [self addReachabilityManager];
//
//    }
//}


@end
