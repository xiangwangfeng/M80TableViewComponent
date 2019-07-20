//
//  UITableView+M80.m
//  M80TableViewComponent
//
//  Created by amao on 2018/6/8.
//

#import "UITableView+M80.h"

@implementation UITableView (M80)

- (void)m80_insertSections:(NSIndexSet *)sections
           withRowAnimation:(UITableViewRowAnimation)animation
{
    [self m80_performAnimation:animation
                    withActions:^{
                        [self insertSections:sections
                            withRowAnimation:animation];
                    }];
}

- (void)m80_deleteSections:(NSIndexSet *)sections
           withRowAnimation:(UITableViewRowAnimation)animation
{
    [self m80_performAnimation:animation
                    withActions:^{
                        [self deleteSections:sections
                            withRowAnimation:animation];
                    }];
}

- (void)m80_reloadSections:(NSIndexSet *)sections
           withRowAnimation:(UITableViewRowAnimation)animation
{
    [self m80_performAnimation:animation
                    withActions:^{
                        [self reloadSections:sections
                            withRowAnimation:animation];
                    }];
}


- (void)m80_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                   withRowAnimation:(UITableViewRowAnimation)animation
{
    [self m80_performAnimation:animation
                    withActions:^{
                        [self insertRowsAtIndexPaths:indexPaths
                                    withRowAnimation:animation];
                    }];
}

- (void)m80_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                   withRowAnimation:(UITableViewRowAnimation)animation
{
    [self m80_performAnimation:animation
                    withActions:^{
                        [self deleteRowsAtIndexPaths:indexPaths
                                    withRowAnimation:animation];
                    }];
}
- (void)m80_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                   withRowAnimation:(UITableViewRowAnimation)animation
{
    [self m80_performAnimation:animation
                    withActions:^{
                        [self reloadRowsAtIndexPaths:indexPaths
                                    withRowAnimation:animation];
                    }];
}


- (void)m80_disableSelfSizingCells
{
    self.estimatedRowHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
}

#pragma mark - misc
- (void)m80_performAnimation:(UITableViewRowAnimation)animation
                  withActions:(void (^)(void))actions
{
    dispatch_block_t block = ^(){
        [self beginUpdates];
        actions();
        [self endUpdates];
    };
    
    if (animation == UITableViewRowAnimationNone)
    {
        [UIView performWithoutAnimation:block];
    }
    else
    {
        block();
    }
}

@end
