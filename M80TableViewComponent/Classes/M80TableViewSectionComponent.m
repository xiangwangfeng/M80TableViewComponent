//
//  M80TableViewSectionComponent.m
//  M80TableViewComponent
//
//  Created by amao on 2017/4/6.
//
//

#import "M80TableViewSectionComponent.h"
#import "M80TableViewComponent.h"
#import "M80TableViewViewComponent.h"
#import "UITableView+M80.h"
#import "M80ListDiff.h"

@interface M80TableViewSectionComponent ()
@property (nonatomic,strong)    NSMutableArray<M80TableViewCellComponent *>  *cellComponents;
@end

@implementation M80TableViewSectionComponent
#pragma mark - M80TableViewSectionComponent Protocol
- (void)prepareData
{
    //基类不实现，继承类实现重置 cell components 流程即可
}

#pragma mark - lazy load
- (NSMutableArray<M80TableViewCellComponent *> *)cellComponents
{
    if (_cellComponents == nil)
    {
        _cellComponents = [NSMutableArray array];
    }
    return _cellComponents;
}

- (UITableView *)tableView
{
    return self.superComponent.tableView;
}


- (NSUInteger)sectionIndex
{
    return [self.superComponent.sections indexOfObject:self];
}

- (CGFloat)sectionHeight
{
    //简单版本，直接遍历现价，不进行缓存，有需要再做
    CGFloat cellsHeight = 0;
    for (M80TableViewCellComponent *component in self.cellComponents)
    {
        cellsHeight += component.height;
    }
    return _header.height + _footer.height + cellsHeight;
}

- (M80TableViewComponentContext *)context
{
    return self.superComponent.context;
}

#pragma mark - set
- (void)setComponents:(NSArray<M80TableViewCellComponent *> *)components
{
    for (M80TableViewCellComponent *component in self.cellComponents)
    {
        component.superComponent = nil;
    }
    [self.cellComponents removeAllObjects];
    if (components)
    {
        for (M80TableViewCellComponent *component in components)
        {
            component.superComponent = self;
        }
        [self.cellComponents addObjectsFromArray:components];
    }
    [self reloadSection];
}

- (NSArray<M80TableViewCellComponent *> *)components
{
    return self.cellComponents;
}

#pragma mark - add
- (void)addComponent:(M80TableViewCellComponent *)component
{
    [self addComponent:component
      withRowAnimation:UITableViewRowAnimationNone];
}
- (void)addComponent:(M80TableViewCellComponent *)component
    withRowAnimation:(UITableViewRowAnimation)animation
{
    if (component)
    {
        [self addComponents:@[component]
           withRowAnimation:animation];
    }
    
}

- (void)addComponents:(NSArray<M80TableViewCellComponent *> *)components
{
    [self addComponents:components
       withRowAnimation:UITableViewRowAnimationNone];
}


- (void)addComponents:(NSArray<M80TableViewCellComponent *> *)components
     withRowAnimation:(UITableViewRowAnimation)animation
{
    [self insertComponents:components
                   atIndex:self.cellComponents.count
          withRowAnimation:animation];
}

- (void)insertComponents:(NSArray<M80TableViewCellComponent *> *)components
                 atIndex:(NSUInteger)index
{
    [self insertComponents:components
                   atIndex:index
          withRowAnimation:UITableViewRowAnimationNone];
}

- (void)insertComponents:(NSArray<M80TableViewCellComponent *> *)components
                 atIndex:(NSUInteger)index
        withRowAnimation:(UITableViewRowAnimation)animation
{
    NSUInteger count = [components count];
    if (count && index <= self.cellComponents.count) //insert 需要判断 <= 而不是 <
    {
        for (M80TableViewCellComponent *component in components)
        {
            component.superComponent = self;
        }
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, count)];
        [self.cellComponents insertObjects:components
                                 atIndexes:indexSet];
        UITableView *tableView = self.tableView;
        if(tableView)
        {
            NSUInteger section = self.sectionIndex;
            if (section != NSNotFound)
            {
                NSMutableArray *indexPaths = [NSMutableArray array];
                for (NSUInteger i = index; i < index + count; i++)
                {
                    [indexPaths addObject:[NSIndexPath indexPathForRow:i
                                                             inSection:section]];
                }
                [tableView m80_insertRowsAtIndexPaths:indexPaths
                                      withRowAnimation:animation];
            }
        }
    }
}


#pragma mark - remove
- (void)removeComponent:(M80TableViewCellComponent *)component
{
    [self removeComponent:component
         withRowAnimation:UITableViewRowAnimationNone];
}

- (void)removeComponent:(M80TableViewCellComponent *)component
       withRowAnimation:(UITableViewRowAnimation)animation
{
    if (component)
    {
        NSUInteger row = [self.cellComponents indexOfObject:component];
        if (row != NSNotFound)
        {
            component.superComponent = nil;
            [self.cellComponents removeObjectAtIndex:row];
            UITableView *tableView = self.tableView;
            if (tableView)
            {
                NSUInteger section = self.sectionIndex;
                if(section != NSNotFound)
                {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row
                                                                inSection:section];
                    [tableView m80_deleteRowsAtIndexPaths:@[indexPath]
                                          withRowAnimation:animation];
                }
            }
        }
    }
}

#pragma mark - insert
- (void)insertComponent:(M80TableViewCellComponent *)component
                atIndex:(NSUInteger)index
{
    [self insertComponent:component
                  atIndex:index
         withRowAnimation:UITableViewRowAnimationNone];
}

- (void)insertComponent:(M80TableViewCellComponent *)component
                atIndex:(NSUInteger)index
       withRowAnimation:(UITableViewRowAnimation)animation
{
    if (component && index <= self.cellComponents.count)
    {
        component.superComponent = self;
        [self.cellComponents insertObject:component
                                  atIndex:index];
        UITableView *tableView = self.tableView;
        if (tableView)
        {
            NSUInteger section = self.sectionIndex;
            if (section != NSNotFound)
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index
                                                            inSection:section];
                [tableView m80_insertRowsAtIndexPaths:@[indexPath]
                                      withRowAnimation:animation];
            }
        }
    }
}


#pragma mark - reload
- (void)reloadComponent:(M80TableViewCellComponent *)component
{
    [self reloadComponent:component
         withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadComponent:(M80TableViewCellComponent *)component
       withRowAnimation:(UITableViewRowAnimation)animation
{
    if (component)
    {
        NSUInteger row = [self.cellComponents indexOfObject:component];
        if (row != NSNotFound)
        {
            UITableView *tableView = self.tableView;
            if (tableView)
            {
                NSUInteger section = self.sectionIndex;
                if(section != NSNotFound)
                {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row
                                                                inSection:section];
                    [tableView m80_reloadRowsAtIndexPaths:@[indexPath]
                                          withRowAnimation:animation];
                }
            }
        }
    }
}

#pragma mark - scroll
- (void)scrollToComponent:(M80TableViewCellComponent *)component
         atScrollPosition:(UITableViewScrollPosition)position
                 animated:(BOOL)animated
{
    UITableView *tableView = self.tableView;
    if (component && tableView)
    {
        NSUInteger row = [self.cellComponents indexOfObject:component];
        if (row != NSNotFound)
        {
            NSUInteger section = self.sectionIndex;
            if(section != NSNotFound)
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row
                                                            inSection:section];
                
                if (!animated)
                {
                    [UIView setAnimationsEnabled:NO];
                }
                [tableView scrollToRowAtIndexPath:indexPath
                                 atScrollPosition:position
                                         animated:animated];
                if (!animated)
                {
                    [UIView setAnimationsEnabled:YES];
                }
            }
        }
    }
}

#pragma mark - reload
- (void)reload
{
    [self reload:UITableViewRowAnimationNone];
}

- (void)reload:(UITableViewRowAnimation)animation
{
    [self.superComponent reloadSection:self
                      withRowAnimation:animation];
}

#pragma mark - remove
- (void)remove
{
    [self remove:UITableViewRowAnimationNone];
}

- (void)remove:(UITableViewRowAnimation)animation
{
    [self.superComponent removeSection:self
                      withRowAnimation:animation];
}

- (void)removeComponentsInRange:(NSRange)range
{
    [self removeComponentsInRange:range
                 withRowAnimation:UITableViewRowAnimationNone];
}

- (void)removeComponentsInRange:(NSRange)range
withRowAnimation:(UITableViewRowAnimation)animation
{
    NSUInteger count = [self.cellComponents count];
    NSUInteger location = range.location;
    if (location < count)
    {
        NSUInteger length = location + range.length > count ? count - location : range.length;
        NSRange removedRange = NSMakeRange(location,length);
        
        NSArray *components = [self.cellComponents subarrayWithRange:removedRange];
        for (M80TableViewCellComponent *component in components)
        {
            component.superComponent = nil;
        }
        [self.cellComponents removeObjectsInRange:removedRange];
        
        UITableView *tableView = self.tableView;
        if (tableView)
        {
            NSUInteger section = self.sectionIndex;
            if(section != NSNotFound)
            {
                NSMutableArray *indexPaths = [NSMutableArray array];
                for (NSUInteger i = location; i < location + length; i++)
                {
                    [indexPaths addObject:[NSIndexPath indexPathForRow:i
                                                             inSection:section]];
                }
                [tableView m80_deleteRowsAtIndexPaths:indexPaths
                                      withRowAnimation:animation];
            }
        }
        
    }
}

#pragma mark - reload list diff
- (void)reloadUsingListDiff:(NSArray<M80TableViewCellComponent *> *)components
{
    UITableView *tableView = self.tableView;
    BOOL shouldReset = tableView == nil ||
                       [self.cellComponents count] == 0 ||
                       [components count] == 0 ||
                       self.sectionIndex == NSNotFound;
    if (shouldReset)
    {
        self.components = components;
    }
    else
    {
        NSInteger section = self.sectionIndex;
        NSArray *oldArray = self.cellComponents;
        NSArray *newArray = components;
        M80ListDiffResult *result = M80ListDiff(oldArray, newArray,section);
        NSLog(@"list diff result %@",result);
        if (result == nil)
        {
            self.components = components;
            return;
        }
        for (M80TableViewCellComponent *component in self.cellComponents)
        {
            component.superComponent = nil;
        }
        [self.cellComponents removeAllObjects];
        if (components)
        {
            for (M80TableViewCellComponent *component in components)
            {
                component.superComponent = self;
            }
            [self.cellComponents addObjectsFromArray:components];
        }
        if (result.changeCount)
        {
            [tableView beginUpdates];
            if ([result.deletes count])
            {
                [tableView deleteRowsAtIndexPaths:result.deletes
                                 withRowAnimation:UITableViewRowAnimationNone];
            }
            
            if ([result.inserts count])
            {
                [tableView insertRowsAtIndexPaths:result.inserts
                                 withRowAnimation:UITableViewRowAnimationNone];
            }
            if ([result.moves count])
            {
                for (M80ListDiffMove *move in result.moves)
                {
                    [tableView moveRowAtIndexPath:move.from
                                      toIndexPath:move.to];
                }
            }
            [tableView endUpdates];
        }
    }
}

- (CGRect)rect
{
    NSUInteger sectionIndex = [self sectionIndex];
    UITableView *tableView = self.tableView;
    if (sectionIndex != NSNotFound && tableView)
    {
        return [tableView rectForSection:sectionIndex];
    }
    return CGRectZero;
}

- (CGRect)rectForCell:(M80TableViewCellComponent *)cellComponent
{
    NSUInteger sectionIndex = [self sectionIndex];
    UITableView *tableView = self.tableView;
    if (sectionIndex != NSNotFound && tableView && cellComponent)
    {
        NSUInteger cellIndex = [self.cellComponents indexOfObject:cellComponent];
        if (cellIndex != NSNotFound)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cellIndex
                                                        inSection:sectionIndex];
            return [tableView rectForRowAtIndexPath:indexPath];
        }
    }
    return CGRectZero;
}

- (CGRect)rectForView:(M80TableViewViewComponent *)viewComponent
{
    NSUInteger sectionIndex = [self sectionIndex];
    UITableView *tableView = self.tableView;
    if (sectionIndex != NSNotFound && tableView && viewComponent)
    {
        if (viewComponent == self.header)
        {
            return [tableView rectForHeaderInSection:sectionIndex];
        }
        else if(viewComponent == self.footer)
        {
            return [tableView rectForFooterInSection:sectionIndex];
        }
    }
    return CGRectZero;
}

#pragma mark - header/footer
- (void)setFooter:(M80TableViewViewComponent *)footer
{
    if (_footer != footer)
    {
        _footer.superComponent = nil;
        footer.superComponent = self;
        _footer = footer;
        [self reloadSection];
    }
}

- (void)setHeader:(M80TableViewViewComponent *)header
{
    if (_header != header)
    {
        _header.superComponent = nil;
        header.superComponent = self;
        _header = header;
        [self reloadSection];
    }
}


#pragma mark - reload section
- (void)reloadSection
{
    UITableView *tableView = self.tableView;
    if (tableView)
    {
        NSUInteger section = self.sectionIndex;
        if (section != NSNotFound)
        {
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
            [tableView m80_reloadSections:indexSet
                          withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

@end
