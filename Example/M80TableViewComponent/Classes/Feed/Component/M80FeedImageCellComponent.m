//
//  M80FeedImageCellComponent.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/31.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80FeedImageCellComponent.h"
#import "M80FeedImageCell.h"
#import "M80FeedImageViewController.h"

@implementation M80FeedImageCellComponent

- (Class)cellClass
{
    return [M80FeedImageCell class];
}

- (CGFloat)height
{
    UITableView *tableView = self.tableView;
    CGFloat width = tableView ? self.tableView.bounds.size.width : UIScreen.mainScreen.bounds.size.width;
    return [M80FeedImageCell heightByFeed:self.feed
                                    width:width];
}

- (void)configure:(M80FeedImageCell *)cell
{
    [super configure:cell];
    [cell refresh:self.feed];
}

- (BOOL)shouldCacheHeight
{
    return YES;
}

- (void)didClickImage:(NSString *)urlString
{
    UIViewController *vc = self.context.viewController;
    if (vc)
    {
        NSURL *url = [NSURL URLWithString:urlString];
        M80FeedImageViewController *viewController = [[M80FeedImageViewController alloc] initWithURL:url];
        [vc presentViewController:viewController
                         animated:YES
                       completion:nil];
    }
}

@end
