//
//  M80FeedViewController.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/30.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80FeedViewController.h"
#import <M80TableViewComponent/M80TableViewComponent.h>
#import "M80FeedSectionComponent.h"
#import "M80FeedMocker.h"

@interface M80FeedViewController ()
@property (nonatomic,strong)    M80TableViewComponent *tableViewComponent;
@end

@implementation M80FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Feed";
    [self setupTableView];
    [self setupRefreshControl];
    [self loadMore:YES
        completion:nil];
    
}

- (void)setupTableView
{
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.tableViewComponent = [[M80TableViewComponent alloc] initWithTableView:self.tableView];
    
    M80TableViewComponentContext *context = [M80TableViewComponentContext new];
    context.viewController = self;
    self.tableViewComponent.context = context;
}

- (void)setupRefreshControl
{
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [refresh addTarget:self
                action:@selector(onRefresh:)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
}

- (void)onRefresh:(id)sender
{
    [self.refreshControl beginRefreshing];
    [self loadMore:NO
        completion:^{
            [self.refreshControl endRefreshing];
        }];
}

- (void)loadMore:(BOOL)after completion:(dispatch_block_t)completion
{
    [M80FeedMocker fetchFeeds:100
                   completion:^(NSArray * _Nonnull feeds) {
                       dispatch_async(dispatch_get_global_queue(0, 0), ^{
                           NSMutableArray *sections = [NSMutableArray array];
                           for (M80Feed *feed in feeds)
                           {
                               M80FeedSectionComponent *section = [M80FeedSectionComponent sectionByFeed:feed];
                               [sections addObject:section];
                           }
                           
                           dispatch_async(dispatch_get_main_queue(), ^{
                               if (after)
                               {
                                   [self.tableViewComponent addSections:sections];
                               }
                               else
                               {
                                   [self.tableViewComponent insertSections:sections
                                                                   atIndex:0];
                               }
                               
                               if (completion) {
                                   completion();
                               }
                           });
                       });
                   }];
}
@end
