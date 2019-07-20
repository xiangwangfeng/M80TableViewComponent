//
//  M80TextCellComponent.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/23.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80TextCellComponent.h"

@interface M80TextCellComponent ()
@property (nonatomic,copy)  NSString    *text;
@end

@implementation M80TextCellComponent
+ (instancetype)component:(NSString *)text
{
    M80TextCellComponent *instance = [M80TextCellComponent new];
    instance.text = text;
    return instance;
}

- (Class)cellClass
{
    return UITableViewCell.class;
}

- (CGFloat)height
{
    return 44.f;
}

- (void)configure:(UITableViewCell *)cell
{
    cell.textLabel.text = self.text;
}

- (BOOL)canEditComponent
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)editActions
{
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                      title:@"删除"
                                                                    handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                        [self remove];
                                                                    }];
    return @[delete];
}

@end
