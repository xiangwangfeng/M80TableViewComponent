//
//  M80WebViewController.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/6/13.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80WebViewController.h"
@import WebKit;

@interface M80WebViewController ()<WKNavigationDelegate>
@property (nonatomic,strong)    NSURL   *url;
@property (nonatomic,strong)    WKWebView *webView;
@end

@implementation M80WebViewController

- (instancetype)initWithURL:(NSURL *)url
{
    if (self = [super init])
    {
        _url  = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds
                                      configuration:configuration];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    self.title = webView.title;
}

@end
