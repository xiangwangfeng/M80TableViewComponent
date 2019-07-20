//
//  M80FeedMocker.h
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/30.
//  Copyright © 2019 amao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M80Feed.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^M80FetchFeedsCompletion)(NSArray *feeds);


@interface M80FeedMocker : NSObject
+ (void)fetchFeeds:(NSInteger)count
        completion:(M80FetchFeedsCompletion)completion;
@end

NS_ASSUME_NONNULL_END
