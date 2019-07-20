//
//  M80TableViewComponentWeakValue.m
//  M80TableViewComponent
//
//  Created by amao on 2019/5/14.
//

#import "M80TableViewComponentWeakValue.h"

@implementation M80TableViewComponentWeakValue
+ (instancetype)valueWithItem:(id)item
{
    M80TableViewComponentWeakValue *instance = [M80TableViewComponentWeakValue new];
    instance.item = item;
    return instance;
}
@end
