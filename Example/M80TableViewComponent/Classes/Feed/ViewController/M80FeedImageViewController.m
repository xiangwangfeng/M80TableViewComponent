//
//  M80FeedImageViewController.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/6/13.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80FeedImageViewController.h"
#import <YYWebImage/YYWebImage.h>

@interface M80FeedImageViewController ()
@property (nonatomic,strong)    UIImageView *imageView;
@property (nonatomic,strong)    NSURL *url;
@end

@implementation M80FeedImageViewController
- (instancetype)initWithURL:(NSURL *)url
{
    if (self = [super init])
    {
        _url = url;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView yy_setImageWithURL:self.url placeholder:nil];
    [self.view addSubview:self.imageView];
    self.view.backgroundColor  = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(onTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)onTap:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}
@end
