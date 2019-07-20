//
//  M80FeedMocker.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/30.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80FeedMocker.h"

@implementation M80FeedMocker
+ (void)fetchFeeds:(NSInteger)count
        completion:(M80FetchFeedsCompletion)completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *feeds = [self feeds:count];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(feeds);
        });
    });
}

+ (NSArray *)feedsInFile
{
    NSMutableArray *feeds = [NSMutableArray array];
    NSInteger index = arc4random() % 8;
    NSString *filename = [NSString stringWithFormat:@"weibo_%d",(int)index];
    NSString *path = [[NSBundle mainBundle] pathForResource:filename
                                                     ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
    NSArray *items = dict[@"statuses"];
    for (NSDictionary *item in items)
    {
        M80Feed *feed = [M80Feed feed:item];
        [feeds addObject:feed];
    }
    return feeds;
}

+ (NSArray *)feeds:(NSInteger)count
{
    NSArray *feeds = [self feedsInFile];
    NSInteger feedsCount = feeds.count;
    NSMutableArray *results = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++)
    {
        NSInteger index = i % feedsCount;
        [results addObject:feeds[index]];
    }
    return results;
}

@end
