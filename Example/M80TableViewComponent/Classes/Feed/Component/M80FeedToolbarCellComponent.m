//
//  M80FeedToolbarCellComponent.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/31.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80FeedToolbarCellComponent.h"
#import "M80FeedToolbarViewCell.h"

@implementation M80FeedToolbarCellComponent
- (UINib *)cellNib
{
    return [UINib nibWithNibName:@"M80FeedToolbarViewCell"
                          bundle:NSBundle.mainBundle];
}

- (CGFloat)height
{
    return 30.0;
}

- (void)configure:(M80FeedToolbarViewCell *)cell
{
    [super configure:cell];
    [cell.commentButton setTitle:[NSString stringWithFormat:@"%d",(int)self.feed.commentCount]
                        forState:UIControlStateNormal];
    [cell.likeButton setTitle:[NSString stringWithFormat:@"%d",(int)self.feed.likeCount]
                     forState:UIControlStateNormal];
}
@end
