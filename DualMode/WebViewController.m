//
//  WebViewController.m
//  DualMode
//
//  Created by hzyuxiaohua on 16/8/16.
//  Copyright © 2016年 hzyuxiaohua. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL* url = [NSURL URLWithString:@"http://www.163.com"];
    NSURLRequest* req = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:req];
}

@end
