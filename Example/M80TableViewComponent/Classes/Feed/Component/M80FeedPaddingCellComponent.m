//
//  M80FeedPaddingCellComponent.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/30.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80FeedPaddingCellComponent.h"

@implementation M80FeedPaddingCellComponent
- (instancetype)init
{
    if (self = [super init])
    {
        _color =  UIColor.whiteColor;
    }
    return self;
}

- (Class)cellClass
{
    return [UITableViewCell class];
}

- (CGFloat)height
{
    return self.paddingHeight;
}

- (void)configure:(UITableViewCell *)cell
{
    [super configure:cell];
    cell.backgroundColor = self.color;
}

@end
