//
//  ViewController.m
//  TestMopub
//
//  Created by steve on 2021/2/7.
//

#import "ViewController.h"
#import "MoPub.h"
#import "MPRewardedVideo.h"

#define kMopubAdUnitId @"b79ee2d1003e41639220efda16ec137e"

@interface ViewController () <MPRewardedVideoDelegate>
{
//    NSString *_mopubAdUnitId;
}
@end

@implementation ViewController

- (void)dealloc {
    [MPRewardedVideo removeDelegateForAdUnitId:kMopubAdUnitId];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor orangeColor];
    button.frame = CGRectMake(self.view.frame.size.width/2 - 250/2, 50, 250, 40);
    [button setTitle:@"initSDK" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(initMopub) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.backgroundColor = [UIColor orangeColor];
    button1.frame = CGRectMake(self.view.frame.size.width/2 - 250/2, 120, 250, 40);
    [button1 setTitle:@"load rewardAd" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(load) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.backgroundColor = [UIColor orangeColor];
    button3.frame = CGRectMake(self.view.frame.size.width/2 - 250/2, 190, 250, 40);
    [button3 setTitle:@"present rewardAd" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

- (void)initMopub {
    if (![[MoPub sharedInstance] isSdkInitialized]) {
        NSString *mopubVersion = [[MoPub sharedInstance] version];
        NSLog(@"[LOG] Mopub version is %@",mopubVersion);
        MPMoPubConfiguration *sdkConfig = [[MPMoPubConfiguration alloc] initWithAdUnitIdForAppInitialization:kMopubAdUnitId];
        NSLog(@"[LOG] Mopub init start");
        [[MoPub sharedInstance] initializeSdkWithConfiguration:sdkConfig completion:^{
            NSLog(@"[LOG] MoPub init completion");
        }];
    }
}

- (void)load {
    
    if ([NSThread isMainThread]) {
        NSLog(@"[LOG] ----------------------1");
        NSLog(@"[LOG] call loadRewardedVideoAdWithAdUnitID");
        [MPRewardedVideo setDelegate:self forAdUnitId:kMopubAdUnitId];
        [MPRewardedVideo loadRewardedVideoAdWithAdUnitID:kMopubAdUnitId withMediationSettings:nil];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"[LOG] ----------------------2");
            NSLog(@"[LOG] call loadRewardedVideoAdWithAdUnitID");
            [MPRewardedVideo setDelegate:self forAdUnitId:kMopubAdUnitId];
            [MPRewardedVideo loadRewardedVideoAdWithAdUnitID:kMopubAdUnitId withMediationSettings:nil];
        });
    }
    
}

- (BOOL)isReady {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    return b;
}

- (void)show {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    if (!b) {
        NSLog(@"[LOG] call show function, but hasAdAvailableForAdUnitID is NO");
        return;
    }
    
    NSLog(@"[LOG] call presentRewardedVideoAdForAdUnitID");
    [MPRewardedVideo presentRewardedVideoAdForAdUnitID:kMopubAdUnitId fromViewController:self withReward:nil];
}

#pragma mark - MPRewardedVideoDelegate

/**
 * This method is called after an ad loads successfully.
 */
- (void)rewardedVideoAdDidLoadForAdUnitID:(NSString *)adUnitID {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    NSLog(@"[LOG] call %@ and hasAdAvailableForAdUnitID is %@",NSStringFromSelector(_cmd),b?@"YES":@"NO");
}

/**
 * This method is called after an ad fails to load.
 */
- (void)rewardedVideoAdDidFailToLoadForAdUnitID:(NSString *)adUnitID error:(NSError *)error {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    NSLog(@"[LOG] call %@ and hasAdAvailableForAdUnitID is %@",NSStringFromSelector(_cmd),b?@"YES":@"NO");
}

/**
 * This method is called when a previously loaded rewarded video is no longer eligible for presentation.
 */
- (void)rewardedVideoAdDidExpireForAdUnitID:(NSString *)adUnitID {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    NSLog(@"[LOG] call %@ and hasAdAvailableForAdUnitID is %@",NSStringFromSelector(_cmd),b?@"YES":@"NO");
}

/**
 * This method is called when an attempt to play a rewarded video fails.
 */
- (void)rewardedVideoAdDidFailToPlayForAdUnitID:(NSString *)adUnitID error:(NSError *)error {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    NSLog(@"[LOG] call %@ and hasAdAvailableForAdUnitID is %@",NSStringFromSelector(_cmd),b?@"YES":@"NO");
}

/**
 * This method is called when a rewarded video ad is about to appear.
 */
- (void)rewardedVideoAdWillAppearForAdUnitID:(NSString *)adUnitID {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    NSLog(@"[LOG] call %@ and hasAdAvailableForAdUnitID is %@",NSStringFromSelector(_cmd),b?@"YES":@"NO");
}

/**
 * This method is called when a rewarded video ad has appeared.
 */
- (void)rewardedVideoAdDidAppearForAdUnitID:(NSString *)adUnitID {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    NSLog(@"[LOG] call %@ and hasAdAvailableForAdUnitID is %@",NSStringFromSelector(_cmd),b?@"YES":@"NO");
}

/**
 * This method is called when a rewarded video ad will be dismissed.
 */
- (void)rewardedVideoAdWillDisappearForAdUnitID:(NSString *)adUnitID {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    NSLog(@"[LOG] call %@ and hasAdAvailableForAdUnitID is %@",NSStringFromSelector(_cmd),b?@"YES":@"NO");
}

/**
 * This method is called when a rewarded video ad has been dismissed.
 */
- (void)rewardedVideoAdDidDisappearForAdUnitID:(NSString *)adUnitID {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    NSLog(@"[LOG] call %@ and hasAdAvailableForAdUnitID is %@",NSStringFromSelector(_cmd),b?@"YES":@"NO");
    
    
    NSLog(@"[LOG] ----------------------");
    NSLog(@"[LOG] will load next rewardAd");
    [self load];
}

/**
 * This method is called when the user taps on the ad.
 */
- (void)rewardedVideoAdDidReceiveTapEventForAdUnitID:(NSString *)adUnitID {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    NSLog(@"[LOG] call %@ and hasAdAvailableForAdUnitID is %@",NSStringFromSelector(_cmd),b?@"YES":@"NO");
}

/**
 * This method is called when a rewarded video ad will cause the user to leave the application.
 */
- (void)rewardedVideoAdWillLeaveApplicationForAdUnitID:(NSString *)adUnitID {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    NSLog(@"[LOG] call %@ and hasAdAvailableForAdUnitID is %@",NSStringFromSelector(_cmd),b?@"YES":@"NO");
}

/**
 * This method is called when the user should be rewarded for watching a rewarded video ad.
 */
- (void)rewardedVideoAdShouldRewardForAdUnitID:(NSString *)adUnitID reward:(MPRewardedVideoReward *)reward {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    NSLog(@"[LOG] call %@ and hasAdAvailableForAdUnitID is %@",NSStringFromSelector(_cmd),b?@"YES":@"NO");
}

/**
 Called when an impression is fired on a Rewarded Video. Includes information about the impression if applicable.
 */
- (void)didTrackImpressionWithAdUnitID:(NSString *)adUnitID impressionData:(MPImpressionData *)impressionData {
    BOOL b = [MPRewardedVideo hasAdAvailableForAdUnitID:kMopubAdUnitId];
    NSLog(@"[LOG] call %@ and hasAdAvailableForAdUnitID is %@",NSStringFromSelector(_cmd),b?@"YES":@"NO");
}

@end
