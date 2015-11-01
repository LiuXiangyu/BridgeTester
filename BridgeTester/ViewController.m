//
//  ViewController.m
//  BridgeTester
//
//  Created by LiuXiangyu on 10/30/15.
//  Copyright © 2015 LiuXiangyu. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ViewController ()
@property WebViewJavascriptBridge *bridge;
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIButton *goButton;
@property(nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController
- (void) constructUIComponents {
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    self.webView = [[UIWebView alloc]
                    initWithFrame:CGRectMake(0.0f, 61.0f, width, height - 61.0f)];
    
    self.textField = [[UITextField alloc]
                      initWithFrame:CGRectMake(10.0f, 20.0f, width - 80.0f, 31.0f)];
    
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.textField.contentVerticalAlignment =
    UIControlContentVerticalAlignmentCenter;
    
    self.textField.textAlignment = NSTextAlignmentLeft;
    
    self.textField.placeholder = @"url";
    
    self.goButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.goButton.frame = CGRectMake(width - 70.0f, 20.0f, 60.0f, 31.0f);
    
    [self.goButton setTitle:@"go" forState:UIControlStateNormal];
    
    [self.goButton addTarget:self
                      action:@selector(redirect:)
            forControlEvents:(UIControlEventTouchDown)];
}

- (void) addUIComponetsToView:(UIView *)paramView {
    [paramView addSubview:self.webView];
    [paramView addSubview:self.textField];
    [paramView addSubview:self.goButton];
}

- (void) redirect:(UIButton *)paramSender {
    NSURL *url = [NSURL URLWithString:self.textField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self constructUIComponents];
    [self addUIComponetsToView:self.view];
    self.bridge = [WebViewJavascriptBridge
                   bridgeForWebView:self.webView
                   handler:^(id data, WVJBResponseCallback responseCallback) {
                       NSLog(@"Received message from javascript: %@", data);
                       responseCallback(@"Right back atcha");
                   }];
    
    /*[self.bridge
     registerHandler:@"jshandler"
     handler:^(id data, WVJBResponseCallback responseCallback){
        NSLog(@"Received data from javascript: %@", data);
         responseCallback(@"data from objc");
     }];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
