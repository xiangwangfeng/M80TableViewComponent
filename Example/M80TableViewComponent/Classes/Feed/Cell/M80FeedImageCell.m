//
//  M80FeedImageCell.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/31.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80FeedImageCell.h"
#import <YYWebImage/YYWebImage.h>
#import "M80Feed.h"
#import "M80FeedImageCellComponent.h"
#import <M80TableViewComponent/NSObject+M80.h>

#define M80OneImageRatio (0.618)
#define M80OtherImageRatio (0.309)
#define M80ImageHorizontalMargin (15)
#define M80ImageVerticalMargin  (5)


@interface M80FeedImageCell ()
@property (nonatomic,strong)    NSArray *imageViews;
@property (nonatomic,strong)    M80Feed *feed;
@end


@implementation M80FeedImageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier])
    {
        [self setup];
    }
    return self;
}


+ (CGFloat)heightByFeed:(M80Feed *)feed
                  width:(CGFloat)width
{
    CGFloat contraintWidth = width - M80ImageHorizontalMargin - M80ImageHorizontalMargin;
    NSInteger count = MIN(9,feed.images.count);
    NSInteger rows = (count + 2) / 3;
    CGFloat ratio = count == 1 ? M80OneImageRatio : M80OtherImageRatio;
    return ratio * rows * contraintWidth + (rows + 1) * M80ImageVerticalMargin;
}

- (void)refresh:(M80Feed *)feed
{
    self.feed = feed;
    NSArray *urls = feed.images;
    for (NSInteger i = 0; i < [urls count] && i < [self.imageViews count]; i++)
    {
        UIImageView *imageView = self.imageViews[i];
        NSURL *url = [NSURL URLWithString:urls[i]];
        [imageView yy_setImageWithURL:url placeholder:nil];
        [imageView setHidden:NO];
    }
    
    for (NSInteger i = [urls count]; i < [self.imageViews count]; i++)
    {
        [self.imageViews[i] setHidden:YES];
    }
}

#pragma mark - misc
- (void)setup
{
    NSMutableArray *imageViews = [NSMutableArray array];
    for (NSInteger i = 0; i < 9; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.hidden = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(onTap:)];
        [imageView addGestureRecognizer:tap];
        [imageView setUserInteractionEnabled:YES];
        
        [imageViews addObject:imageView];
        [self addSubview:imageView];
    }
    _imageViews = imageViews;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = MIN(self.imageViews.count,self.feed.images.count);
    CGFloat width = self.bounds.size.width;
    CGFloat contraintWidth = width - M80ImageHorizontalMargin - M80ImageHorizontalMargin;
    if (count == 1)
    {
        CGFloat size = contraintWidth * M80OneImageRatio;
        UIImageView *imageView = self.imageViews.firstObject;
        [imageView setFrame:CGRectMake(M80ImageHorizontalMargin, M80ImageVerticalMargin, size, size)];
    }
    else
    {
        CGFloat size = contraintWidth * M80OtherImageRatio;
        CGFloat gap = (contraintWidth - 3 * size) / 2.0;
        for (NSInteger i = 0; i < count; i++)
        {
            NSInteger row = i / 3;
            NSInteger column = i % 3;
            CGRect frame = CGRectMake(M80ImageHorizontalMargin + column * (gap + size),
                                      M80ImageVerticalMargin + row * (size + M80ImageVerticalMargin),
                                      size,
                                      size);
            [self.imageViews[i] setFrame:frame];
        }
    }
}

- (void)onTap:(UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    if (view)
    {
        NSInteger index = [self.imageViews indexOfObject:view];
        if (index != NSNotFound && index < self.feed.images.count)
        {
            NSString *urlString = self.feed.images[index];
            M80FeedImageCellComponent *component = [self.m80_cellComponent m80_asObject:M80FeedImageCellComponent.class];
            if (component)
            {
                [component didClickImage:urlString];
            }
        }
    }
}
    
@end
