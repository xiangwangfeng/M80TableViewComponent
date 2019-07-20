//
//  NSObject+M80m
//  M80TableViewComponent
//
//  Created by amao on 2016/12/15.
//
//

#import "NSObject+M80.h"


@implementation NSObject (M80)

- (id)m80_asObject:(Class)cls
{
    return [self isKindOfClass:cls] ? self : nil;
}

@end
