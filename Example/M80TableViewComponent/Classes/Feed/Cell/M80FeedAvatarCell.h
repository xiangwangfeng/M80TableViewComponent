//
//  M80FeedAvatarCell.h
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/31.
//  Copyright © 2019 amao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class M80Feed;

NS_ASSUME_NONNULL_BEGIN

@interface M80FeedAvatarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
- (void)refresh:(M80Feed *)feed;
@end

NS_ASSUME_NONNULL_END
