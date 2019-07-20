//
//  M80FeedAvatarCell.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/31.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80FeedAvatarCell.h"
#import <YYWebImage/YYWebImage.h>
#import <M80TableViewComponent/M80TableViewComponent.h>
#import <M80TableViewComponent/NSObject+M80.h>
#import "M80FeedAvatarCellComponent.h"

@interface M80AvatarManager : NSObject
+ (YYWebImageManager *)avatarImageManager;
@end

@implementation M80FeedAvatarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(onTap:)];
    [self.avatarImageView addGestureRecognizer:tap];
    [self.avatarImageView setUserInteractionEnabled:YES];
}

- (void)refresh:(M80Feed *)feed
{
    self.nameLabel.text = feed.username;
    self.infoLabel.text = feed.createAt;
    [self.avatarImageView yy_setImageWithURL:[NSURL URLWithString:feed.avatarURLString]
                                 placeholder:[UIImage imageNamed:@"user_avatar"]
                                     options:0
                                     manager:[M80AvatarManager avatarImageManager]
                                    progress:nil
                                   transform:nil
                                  completion:nil];
    
    
}

- (void)onTap:(id)sender
{
    M80TableViewCellComponent *component = self.m80_cellComponent;
    M80FeedAvatarCellComponent *avatarComponent = [component m80_asObject:M80FeedAvatarCellComponent.class];
    [avatarComponent didClickUserAvatar];
}


@end



@implementation M80AvatarManager

+ (YYWebImageManager *)avatarImageManager
{
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *tempDir = NSTemporaryDirectory();
        NSString *path = [tempDir stringByAppendingPathComponent:@"weibo.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        manager.sharedTransformBlock = ^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
            if (image == nil)
            {
                return nil;
            }
            CGFloat a = MIN(image.size.width, image.size.height);
            
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(a, a) , NO, image.scale);
            CGContextRef context = UIGraphicsGetCurrentContext();
            
            
            UIBezierPath * path = [UIBezierPath bezierPath];
            [path addArcWithCenter:CGPointMake(a / 2.f, a / 2.f) radius:a / 2.f startAngle:0 endAngle:2 * M_PI clockwise:YES];
            
            CGContextAddPath(context, path.CGPath);
            
            CGContextClip(context);
            
            CGRect rect;
            if (image.size.width > image.size.height)
            {
                rect = CGRectMake(- (image.size.width - image.size.height) * a / (2.f * image.size.height), 0,
                                  a * image.size.width / image.size.height, a);
            }
            else
            {
                rect = CGRectMake(0, - (image.size.height - image.size.width) * a / (2.f * image.size.width),
                                  a, a * image.size.height / image.size.width);
            }
            [image drawInRect:rect];
            CGContextDrawPath(context, kCGPathFillStroke);
            UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return result;
        };
    });
    return manager;
}

@end
