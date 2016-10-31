//
//  MobileIronManager.h
//  DualMode
//
//  Created by hzyuxiaohua on 16/8/16.
//  Copyright © 2016年 hzyuxiaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppConnect/AppConnect.h>

@interface MobileIronManager : NSObject

@property (nonatomic, readonly) BOOL isReady;

+ (instancetype)defaultManager;

- (void)stop;

- (void)retire;

- (void)startWithLaunchFinishOptions:(NSDictionary *)options;

@end
