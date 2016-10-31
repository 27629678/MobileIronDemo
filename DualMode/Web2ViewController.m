//
//  Web2ViewController.m
//  DualMode
//
//  Created by hzyuxiaohua on 16/8/16.
//  Copyright © 2016年 hzyuxiaohua. All rights reserved.
//

#import "Web2ViewController.h"

#import <AFNetworking/AFNetworking.h>

@interface Web2ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) AFHTTPRequestOperation* currentOperation;

@end

@implementation Web2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)getBtnAction:(id)sender
{
    self.textView.text = @"waiting network response...";
    
    NSMutableDictionary* parameter = [NSMutableDictionary dictionary];
    parameter[@"os_ver"] = [[UIDevice currentDevice] systemVersion];
    parameter[@"app_ver"] = @"4.7.0";
    parameter[@"os_type"] = @"ios";
    parameter[@"dev_model"] = [[UIDevice currentDevice] model];
    parameter[@"appid"] = @(2);
    parameter[@"product"] = @"mailmaster";
    
    NSString* url = @"http://update.client.163.com/apptrack/versync/check.do";
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer]
                                    requestWithMethod:@"GET"
                                    URLString:url
                                    parameters:parameter];
    NSMutableURLRequest* tmp = [[AFHTTPRequestSerializer serializer]
                                requestWithMethod:@"POST"
                                URLString:url
                                parameters:parameter];
    request.HTTPMethod = @"POST";
    request.HTTPBody= tmp.HTTPBody;
    self.currentOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    __weak typeof(self) weakSelf = self;
    [self.currentOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation* operation, id json) {
        weakSelf.textView.text = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.textView.text = error.localizedDescription;
    }];
    [self.currentOperation start];
}

@end
