//
//  UITableView+M80.h
//  M80TableViewComponent
//
//  Created by amao on 2018/6/8.
//

#import <UIKit/UIKit.h>

@interface UITableView (M80)
- (void)m80_insertSections:(NSIndexSet *)sections
           withRowAnimation:(UITableViewRowAnimation)animation;
- (void)m80_deleteSections:(NSIndexSet *)sections
           withRowAnimation:(UITableViewRowAnimation)animation;
- (void)m80_reloadSections:(NSIndexSet *)sections
           withRowAnimation:(UITableViewRowAnimation)animation;


- (void)m80_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                   withRowAnimation:(UITableViewRowAnimation)animation;
- (void)m80_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                   withRowAnimation:(UITableViewRowAnimation)animation;
- (void)m80_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                   withRowAnimation:(UITableViewRowAnimation)animation;

- (void)m80_disableSelfSizingCells;
@end
