//
//  M80FeedTextCell.h
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/6/13.
//  Copyright © 2019 amao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface M80FeedTextCell : UITableViewCell
@property (nonatomic,copy)  NSString    *text;
+ (CGFloat)height:(NSString *)text width:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
