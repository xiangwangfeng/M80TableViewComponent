//
//  M80ListDiffCellComponent.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/27.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80ListDiffCellComponent.h"

@implementation M80ListDiffCellComponent

- (CGFloat)height
{
    return 42.0;
}

- (void)configure:(UITableViewCell *)cell
{
    cell.textLabel.text = [_number stringValue];
}

- (Class)cellClass
{
    return [UITableViewCell class];
}

- (NSString *)diffableHash
{
    return [_number stringValue];
}

@end
