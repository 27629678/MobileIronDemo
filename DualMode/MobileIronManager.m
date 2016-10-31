//
//  MobileIronManager.m
//  DualMode
//
//  Created by hzyuxiaohua on 16/8/16.
//  Copyright © 2016年 hzyuxiaohua. All rights reserved.
//

#import "MobileIronManager.h"

#import <UIKit/UIKit.h>

@interface MobileIronManager () <AppConnectDelegate>

@property (nonatomic, strong) AppConnect* connect;

@end

@implementation MobileIronManager

+ (instancetype)defaultManager
{
    static MobileIronManager* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MobileIronManager alloc] init];
    });
    
    return instance;
}

- (void)startWithLaunchFinishOptions:(NSDictionary *)options
{
    if (self.connect.isReady) {
        return;
    }
    
    [AppConnect initWithDelegate:self];
    self.connect = [AppConnect sharedInstance];
    [self.connect startWithLaunchOptions:options];
}

- (void)stop
{
    if (!self.connect) {
        return;
    }
    
    [self.connect retire];
    [self.connect stop];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.connect.authState) forKey:@"ACAUTHSTATE"];
    self.connect = nil;
}

- (void)retire
{
    if (!self.connect) {
        return;
    }
    
    [self.connect retire];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.connect.authState) forKey:@"ACAUTHSTATE"];
}

- (BOOL)isReady
{
    return self.connect.isReady;
}

#pragma mark - app connect delegate methods

- (void)appConnectIsReady:(AppConnect *)appConnect
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Mobile@Iron.Ready"
                                                 message:appConnect.isReady ? @"Ready" : @"Not Ready"
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
    [av show];
    
    if (self.connect) {
        [[NSUserDefaults standardUserDefaults] setObject:@(self.connect.authState) forKey:@"ACAUTHSTATE"];
    }
}

- (void)appConnect:(AppConnect *)appConnect authStateChangedTo:(ACAuthState)newAuthState withMessage:(NSString *)message
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Mobile@Iron.AuthState"
                                                 message:message ? : @""
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
    [av show];
}

@end
