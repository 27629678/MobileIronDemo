//
//  AppDelegate.m
//  DualMode
//
//  Created by hzyuxiaohua on 16/8/16.
//  Copyright © 2016年 hzyuxiaohua. All rights reserved.
//

#import "AppDelegate.h"

#import "MobileIronManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSNumber* authState = [[NSUserDefaults standardUserDefaults] objectForKey:@"ACAUTHSTATE"];
    if ([authState isEqualToNumber:@(ACAUTHSTATE_AUTHORIZED)]) {
        [[MobileIronManager defaultManager] startWithLaunchFinishOptions:launchOptions];
    }
    
    return YES;
}


@end
