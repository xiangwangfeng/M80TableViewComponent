//
//  M80FeedTextCellComponent.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/30.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80FeedTextCellComponent.h"
#import "M80FeedTextCell.h"

@implementation M80FeedTextCellComponent

- (Class)cellClass
{
    return [M80FeedTextCell class];
}

- (CGFloat)height
{
    CGFloat width = self.tableView.bounds.size.width;
    if (width == 0)
    {
        width = [[UIScreen mainScreen] bounds].size.width;
    }
    return [M80FeedTextCell height:self.feed.text
                             width:width];
}

- (void)configure:(M80FeedTextCell *)cell
{
    [super configure:cell];
    cell.text = self.feed.text;
}

- (BOOL)shouldCacheHeight
{
    return YES;
}

@end
