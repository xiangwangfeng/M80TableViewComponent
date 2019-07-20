//
//  M80FeedBaseCellComponent.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/30.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80FeedBaseCellComponent.h"
#import <M80TableViewComponent/NSObject+M80.h>
#import "M80FeedSectionComponent.h"

@implementation M80FeedBaseCellComponent

- (M80Feed *)feed
{
    if (_feed == nil)
    {
        M80FeedSectionComponent *section = [self.superComponent m80_asObject:M80FeedSectionComponent.class];
        _feed = section.feed;
    }
    return _feed;
}

- (void)configure:(UITableViewCell *)cell
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)didSelect:(UITableViewCell *)cell
{
    
}

@end
