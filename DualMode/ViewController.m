//
//  ViewController.m
//  DualMode
//
//  Created by hzyuxiaohua on 16/8/16.
//  Copyright © 2016年 hzyuxiaohua. All rights reserved.
//

#import "ViewController.h"

#import "MobileIronManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *authStateLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *retireBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self resetAuthStateLabel];
}

- (IBAction)startBtnAction:(id)sender
{
    [[MobileIronManager defaultManager] startWithLaunchFinishOptions:nil];
}

- (IBAction)retireBtnAction:(id)sender
{
    [[MobileIronManager defaultManager] retire];
}

- (IBAction)stopBtnAction:(id)sender
{
    [[MobileIronManager defaultManager] stop];
}

#pragma mark - private

- (void)updateAuthStateLabel
{
    [self performSelector:@selector(resetAuthStateLabel) withObject:nil afterDelay:.3f];
}

- (void)resetAuthStateLabel
{
    [self updateBtnState];
    NSString* text = @"UNAUTHORIZED";
    UIColor* textColor = [UIColor redColor];
    
    NSNumber* state = [[NSUserDefaults standardUserDefaults] objectForKey:@"ACAUTHSTATE"];
    if (state) {
        switch (state.integerValue) {
            case ACAUTHSTATE_UNAUTHORIZED:
                textColor = [UIColor redColor];
                text = @"UNAUTHORIZED";
                break;
                
            case ACAUTHSTATE_RETIRED:
                textColor = [UIColor grayColor];
                text = @"RETIRED";
                break;
                
            case ACAUTHSTATE_AUTHORIZED:
                textColor = [UIColor greenColor];
                text = @"AUTHORIZED";
                break;
        }
    }
    
    [self.authStateLabel setText:text];
    [self.authStateLabel setTextColor:textColor];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateAuthStateLabel];
    });
}

- (void)updateBtnState
{
    NSNumber* state = [[NSUserDefaults standardUserDefaults] objectForKey:@"ACAUTHSTATE"];
    switch (state.integerValue) {
        case ACAUTHSTATE_UNAUTHORIZED:
            self.startBtn.enabled = YES;
            self.retireBtn.enabled = NO;
            self.stopBtn.enabled = NO;
            break;
            
        case ACAUTHSTATE_RETIRED:
            self.startBtn.enabled = ![[MobileIronManager defaultManager] isReady];
            self.retireBtn.enabled = NO;
            self.stopBtn.enabled = [[MobileIronManager defaultManager] isReady];
            break;
            
        case ACAUTHSTATE_AUTHORIZED:
            self.startBtn.enabled = NO;
            self.retireBtn.enabled = YES;
            self.stopBtn.enabled = YES;
            break;
    }
}

@end
