//
//  M80Sentinel.m
//  M80TableViewComponent
//
//  Created by amao on 2018/9/19.
//

#import "M80Sentinel.h"
#import <libkern/OSAtomic.h>

@interface M80Sentinel ()
{
    int32_t _value;
}
@end

@implementation M80Sentinel
- (int32_t)value
{
    return OSAtomicIncrement32Barrier(&_value);
}
@end
