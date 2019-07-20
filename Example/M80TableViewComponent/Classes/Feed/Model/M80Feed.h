//
//  M80Feed.h
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/30.
//  Copyright © 2019 amao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface M80Feed : NSObject
@property (nonatomic,assign)    NSInteger   feedId;
@property (nonatomic,assign)    int64_t     userId;
@property (nonatomic,copy)      NSString    *username;
@property (nonatomic,copy)      NSString    *createAt;
@property (nonatomic,copy)      NSString    *avatarURLString;
@property (nonatomic,copy)      NSString    *text;
@property (nonatomic,strong)    NSArray     *images;
@property (nonatomic,assign)    NSInteger   commentCount;
@property (nonatomic,assign)    NSInteger   repostCount;
@property (nonatomic,assign)    NSInteger   likeCount;

+ (instancetype)feed:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
