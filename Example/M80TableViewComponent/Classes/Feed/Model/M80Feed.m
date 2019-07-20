//
//  M80Feed.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/30.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80Feed.h"

@implementation M80Feed
+ (instancetype)feed:(NSDictionary *)item
{
    M80Feed *feed = [M80Feed new];
    feed.feedId = [item[@"id"] integerValue];
    feed.username = item[@"user"][@"screen_name"];
    feed.userId = [item[@"user"][@"id"] longLongValue];
    feed.createAt = item[@"created_at"];
    feed.avatarURLString = item[@"user"][@"avatar_large"];
    
    feed.text = item[@"text"];
    
    NSMutableArray *images = [NSMutableArray array];
    NSArray *imageIds = item[@"pic_ids"];
    if ([imageIds isKindOfClass:[NSArray class]])
    {
        for (NSString *imageId in imageIds)
        {
            NSString *url = item[@"pic_infos"][imageId][@"thumbnail"][@"url"];
            if ([url length])
            {
                [images addObject:url];
            }
        }
    }
    if ([images count])
    {
        feed.images = images;
    }
    
    feed.repostCount = [item[@"reposts_count"] integerValue];
    feed.commentCount= [item[@"comments_count"] integerValue];
    feed.likeCount = [item[@"attitudes_count"] integerValue];
    return feed;
}

@end
