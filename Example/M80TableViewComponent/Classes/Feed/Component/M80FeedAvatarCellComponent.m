//
//  M80FeedAvatarCellComponent.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/30.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80FeedAvatarCellComponent.h"
#import "M80FeedAvatarCell.h"
#import "M80Feed.h"
#import "M80WebViewController.h"


@implementation M80FeedAvatarCellComponent
- (UINib *)cellNib
{
    return [UINib nibWithNibName:@"M80FeedAvatarCell" bundle:NSBundle.mainBundle];
}

- (CGFloat)height
{
    return 50.0;
}

- (void)configure:(M80FeedAvatarCell *)cell
{
    [super configure:cell];
    [cell refresh:self.feed];
}

- (void)didClickUserAvatar
{
    UIViewController *vc = self.context.viewController;
    M80Feed *feed = self.feed;
    if (vc && feed)
    {
        NSString *urlString = [NSString stringWithFormat:@"http://m.weibo.cn/u/%lld",feed.userId];
        NSURL *url = [NSURL URLWithString:urlString];
        M80WebViewController *webViewController = [[M80WebViewController alloc] initWithURL:url];
        [vc.navigationController pushViewController:webViewController
                                           animated:YES];
    }
}
@end
