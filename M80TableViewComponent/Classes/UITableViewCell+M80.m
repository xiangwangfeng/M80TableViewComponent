//
//  UITableViewCell+M80.m
//  M80TableViewComponent
//
//  Created by amao on 2019/5/14.
//

#import "UITableViewCell+M80.h"
#import <objc/runtime.h>
#import "M80TableViewComponentWeakValue.h"
#import "NSObject+M80.h"
#import "M80TableViewCellComponent.h"


@implementation UITableViewCell (M80)
static const void *M80TableViewCellComponentKey = &M80TableViewCellComponentKey;

- (M80TableViewCellComponent *)m80_cellComponent
{
    id object = objc_getAssociatedObject(self,M80TableViewCellComponentKey);
    M80TableViewComponentWeakValue *value = (M80TableViewComponentWeakValue *)[object m80_asObject:[M80TableViewComponentWeakValue class]];
    return [value.item m80_asObject:[M80TableViewCellComponent class]];
}

- (void)setM80_cellComponent:(M80TableViewCellComponent *)m80_cellComponent
{
    M80TableViewComponentWeakValue *value = [M80TableViewComponentWeakValue valueWithItem:m80_cellComponent];
    objc_setAssociatedObject(self, M80TableViewCellComponentKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
