//
//  M80FeedImageCell.h
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/31.
//  Copyright © 2019 amao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class M80Feed;

NS_ASSUME_NONNULL_BEGIN

@interface M80FeedImageCell : UITableViewCell
+ (CGFloat)heightByFeed:(M80Feed *)feed
                  width:(CGFloat)width;
- (void)refresh:(M80Feed *)feed;
@end

NS_ASSUME_NONNULL_END
