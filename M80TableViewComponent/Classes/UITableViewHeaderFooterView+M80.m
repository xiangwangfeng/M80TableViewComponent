//
//  UITableViewHeaderFooterView+M80.m
//  M80TableViewComponent
//
//  Created by amao on 2019/5/14.
//

#import "UITableViewHeaderFooterView+M80.h"
#import <objc/runtime.h>
#import "M80TableViewComponentWeakValue.h"
#import "NSObject+M80.h"
#import "M80TableViewViewComponent.h"

@implementation UITableViewHeaderFooterView (M80)
static const void *M80TableViewFooterViewComponentKey = &M80TableViewFooterViewComponentKey;

- (M80TableViewViewComponent *)m80_viewComponent
{
    id object = objc_getAssociatedObject(self,M80TableViewFooterViewComponentKey);
    M80TableViewComponentWeakValue *value = (M80TableViewComponentWeakValue *)[object m80_asObject:[M80TableViewComponentWeakValue class]];
    return [value.item m80_asObject:[M80TableViewViewComponent class]];
}

- (void)setM80_viewComponent:(M80TableViewViewComponent *)m80_viewComponent
{
    M80TableViewComponentWeakValue *value = [M80TableViewComponentWeakValue valueWithItem:m80_viewComponent];
    objc_setAssociatedObject(self, M80TableViewFooterViewComponentKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
