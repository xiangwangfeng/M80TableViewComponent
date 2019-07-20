//
//  M80TableViewCellHeightCache.m
//  M80TableViewComponent
//
//  Created by amao on 2018/6/14.
//

#import "M80TableViewCellHeightCache.h"
#import "M80TableViewCellComponent.h"



@interface M80TableViewCellHeightCache ()
@property (nonatomic,strong)    NSMutableDictionary *cache;
@end

@implementation M80TableViewCellHeightCache
- (instancetype)init
{
    if (self = [super init])
    {
        _cache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (CGFloat)cellHeight:(M80TableViewCellComponent *)component
{
    NSString *key = component ? component.diffableHash : nil;
    NSNumber *height = key ? _cache[key] : nil;
    return height != nil ? [height doubleValue] : 0.0f;

}

- (void)setCellHeight:(CGFloat)height
           component:(M80TableViewCellComponent *)component
{
    NSString *key = [component diffableHash];
    if (key)
    {
        [_cache setObject:@(height)
                   forKey:key];
    }
}

- (void)cleanCellHeightCache:(M80TableViewCellComponent *)component
{
    NSString *key = [component diffableHash];
    if (key)
    {
        [_cache removeObjectForKey:key];
    }
}


@end
