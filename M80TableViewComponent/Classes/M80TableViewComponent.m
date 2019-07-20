//
//  M80TableViewComponent.m
//  M80TableViewComponent
//
//  Created by amao on 2017/4/6.
//
//

#import "M80TableViewComponent.h"
#import "M80TableViewComponentRegister.h"
#import "UITableView+M80.h"
#import "M80TableViewCellHeightCache.h"
#import "UITableViewCell+M80.h"
#import "UITableViewHeaderFooterView+M80.h"


static BOOL M80TableViewCleanCache = NO;

@interface M80TableViewComponent ()
@property (nonatomic,strong)    NSMutableArray<M80TableViewSectionComponent *>             *sectionComponents;
@property (nonatomic,strong)    M80TableViewComponentRegister                              *componentRegister;
@property (nonatomic,strong)    M80TableViewCellHeightCache                                *heightCache;

@end


@implementation M80TableViewComponent
- (instancetype)initWithTableView:(UITableView *)tableView
{
    if (self = [super init])
    {
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _deselectCellAutomatically = YES;
    
        [_tableView m80_disableSelfSizingCells];
        
        _context = [M80TableViewComponentContext new];
        
    }
    return self;
}


#pragma mark - sections
- (NSArray *)sections
{
    return self.sectionComponents;
}

- (void)setSections:(NSArray<M80TableViewSectionComponent *> *)sections
{
    for (M80TableViewSectionComponent *section in sections)
    {
        section.superComponent = nil;
    }
    [self.sectionComponents removeAllObjects];
    if (sections)
    {
        for (M80TableViewSectionComponent *section in sections)
        {
            section.superComponent = self;
        }
        [self.sectionComponents addObjectsFromArray:sections];
    }
    [self.tableView reloadData];
    
}

- (NSMutableArray *)sectionComponents
{
    if (_sectionComponents == nil)
    {
        _sectionComponents = [NSMutableArray array];
    }
    return _sectionComponents;
}

- (void)reload
{
    NSArray *sections = self.sectionComponents;
    if ([sections count])
    {
        for (M80TableViewSectionComponent *section in sections)
        {
            //prepareData 之前设空 superComponent 避免 prepareData 导致的 UI 刷新
            section.superComponent = nil;
            [section prepareData];
            section.superComponent = self;
        }
        [self.tableView reloadData];
    }
}

- (void)performReloadAction:(dispatch_block_t)block
{
    UITableView *tableView = _tableView;
    if (tableView)
    {
        _tableView = nil;
        if (block)
        {
            block();
        }
        _tableView = tableView;
        [tableView reloadData];
    }
}

#pragma mark - add
- (void)addSection:(nullable M80TableViewSectionComponent *)section
{
    [self addSection:section
    withRowAnimation:UITableViewRowAnimationNone];
}

- (void)addSection:(nullable M80TableViewSectionComponent *)section
  withRowAnimation:(UITableViewRowAnimation)animation
{
    if (section)
    {
        [self addSections:@[section]
         withRowAnimation:animation];
    }
}


- (void)addSections:(NSArray<M80TableViewSectionComponent *> *)sections
{
    [self addSections:sections
     withRowAnimation:UITableViewRowAnimationNone];
}

- (void)addSections:(NSArray<M80TableViewSectionComponent *> *)sections
   withRowAnimation:(UITableViewRowAnimation)animation
{
    [self insertSections:sections
                 atIndex:self.sectionComponents.count
        withRowAnimation:animation];
}


- (void)insertSections:(NSArray<M80TableViewSectionComponent *> *)sections
               atIndex:(NSUInteger)index
{
    [self insertSections:sections
                 atIndex:index
        withRowAnimation:UITableViewRowAnimationNone];
}


- (void)insertSections:(NSArray<M80TableViewSectionComponent *> *)sections
               atIndex:(NSUInteger)index
      withRowAnimation:(UITableViewRowAnimation)animation
{
    NSUInteger count = [sections count];
    if (count && index <= [self.sectionComponents count]) //insert 需要判断 <= 而不是 <
    {
        for (M80TableViewSectionComponent *section in sections)
        {
            section.superComponent = self;
        }
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, count)];
        [self.sectionComponents insertObjects:sections
                                    atIndexes:indexSet];
        [self.tableView m80_insertSections:indexSet
                           withRowAnimation:animation];
    }
}

#pragma mark - remove
- (void)removeSection:(M80TableViewSectionComponent *)section
{
    [self removeSection:section
       withRowAnimation:UITableViewRowAnimationNone];
}

- (void)removeSection:(M80TableViewSectionComponent *)section
     withRowAnimation:(UITableViewRowAnimation)animation
{
    NSUInteger index = [self.sectionComponents indexOfObject:section];
    if (index != NSNotFound)
    {
        section.superComponent = nil;
        [self.sectionComponents removeObjectAtIndex:index];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
        [self.tableView m80_deleteSections:indexSet
                           withRowAnimation:animation];
    }
}

#pragma mark - reload
- (void)reloadSection:(M80TableViewSectionComponent *)section
{
    [self reloadSection:section
       withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadSection:(M80TableViewSectionComponent *)section
     withRowAnimation:(UITableViewRowAnimation)animation
{
    NSUInteger index = [self.sectionComponents indexOfObject:section];
    if (index != NSNotFound)
    {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
        [self.tableView m80_reloadSections:indexSet
                           withRowAnimation:animation];
    }
}

#pragma mark - getter
- (M80TableViewSectionComponent *)sectionAt:(NSUInteger)index
{
    NSAssert([self.sectionComponents count] > index, @"sections overflow");
    return [self.sectionComponents count] > index ? self.sectionComponents[index] : nil;
}


- (M80TableViewCellComponent *)cellComponent:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSAssert([self.sectionComponents count] > section && section >= 0, @"sections overflow");
    M80TableViewSectionComponent *sectionComponent = [self.sectionComponents count] > section && section >= 0 ? self.sectionComponents[section] : nil;
    NSAssert([sectionComponent.components count] > row && row >= 0, @"cell overflow");
    M80TableViewCellComponent *cellComponent = [sectionComponent.components count] > row && row >= 0 ? sectionComponent.components[row] : nil;
    return cellComponent;
}

- (M80TableViewViewComponent *)headerComponent:(NSUInteger)section
{
    NSAssert([self.sectionComponents count] > section, @"sections overflow");
    M80TableViewSectionComponent *sectionComponent = [self.sectionComponents count] > section ? self.sectionComponents[section] : nil;
    return sectionComponent.header;
}

- (M80TableViewViewComponent *)footerComponent:(NSUInteger)section
{
    NSAssert([self.sectionComponents count] > section, @"sections overflow");
    M80TableViewSectionComponent *sectionComponent = [self.sectionComponents count] > section ? self.sectionComponents[section] : nil;
    return sectionComponent.footer;
}



#pragma mark - lazy load
- (M80TableViewComponentRegister *)componentRegister
{
    if (_componentRegister == nil)
    {
        _componentRegister = [[M80TableViewComponentRegister alloc] initWithTableView:self.tableView];
    }
    return _componentRegister;
}

- (M80TableViewCellHeightCache *)heightCache
{
    if (_heightCache == nil)
    {
        _heightCache = [[M80TableViewCellHeightCache alloc] init];
    }
    return _heightCache;
}


#pragma mark - UITableView DataSource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionComponents.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSAssert([self.sectionComponents count] > section && section >= 0, @"sections overflow");
    M80TableViewSectionComponent *sectionComponent = [self.sectionComponents count] > section && section >=0 ? self.sectionComponents[section] : nil;
    return [sectionComponent.components count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M80TableViewCellComponent *component = [self cellComponent:indexPath];
    return [self heightForCellComponent:component];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M80TableViewCellComponent *cellComponent = [self cellComponent:indexPath];
    //如果 cell 要求不重用，那么直接从 cell component 中获取
    if ([cellComponent respondsToSelector:@selector(nonReusable)] &&
        [cellComponent nonReusable])
    {
        UITableViewCell *cell = [cellComponent nonReusableCell];
        cell.m80_cellComponent = cellComponent;
        [cellComponent configure:cell];
        return cell;
    }
    else
    {
        [self.componentRegister registerTableViewCellComponent:cellComponent];
        NSString *reuseIdentifier = [cellComponent reuseIdentifier];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        cell.m80_cellComponent = cellComponent;
        [cellComponent configure:cell];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [[self headerComponent:section] height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    M80TableViewViewComponent *headerComponent = [self headerComponent:section];
    [self.componentRegister registerTableViewViewComponent:headerComponent];
    NSString *reuseIdentifier = [headerComponent reuseIdentifier];
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    view.m80_viewComponent = headerComponent;
    [headerComponent configure:view];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [[self footerComponent:section] height];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    M80TableViewViewComponent *footerComponent = [self footerComponent:section];
    [self.componentRegister registerTableViewViewComponent:footerComponent];
    NSString *reuseIdentifier = [footerComponent reuseIdentifier];
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    view.m80_viewComponent = footerComponent;
    [footerComponent configure:view];
    return view;
}

#pragma mark - 缓存高度管理
- (CGFloat)heightForCellComponent:(M80TableViewCellComponent *)component
{
    if ([component respondsToSelector:@selector(shouldCacheHeight)] &&
        [component shouldCacheHeight])
    {
        CGFloat height = 0;
        if (M80TableViewCleanCache)
        {
            [self.heightCache cleanCellHeightCache:component];
        }
        else
        {
            height = [self.heightCache cellHeight:component];
        }
        if (height == 0)
        {
            height = [component internalHeight];
            [self.heightCache setCellHeight:height
                                  component:component];
        }
        return height;
    }
    else
    {
        return [component internalHeight];
    }
}

#pragma mark - 选择
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M80TableViewCellComponent *component = [self cellComponent:indexPath];
    if (component)
    {
        if (self.deselectCellAutomatically && !component.deselectCellAutomaticallyDisabled)
        {
            [tableView deselectRowAtIndexPath:indexPath
                                     animated:YES];
        }
        
        if ([component respondsToSelector:@selector(didSelect:)])
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [component didSelect:cell];
        }
    }
}

- (void)tableView:(UITableView *)tableView
didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M80TableViewCellComponent *component = [self cellComponent:indexPath];
    if (component)
    {
        if ([component respondsToSelector:@selector(didDeselect:)])
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [component didDeselect:cell];
        }
    }
}


#pragma mark - 编辑
- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    M80TableViewCellComponent *component = [self cellComponent:indexPath];
    if (component && [component respondsToSelector:@selector(canEditComponent)])
    {
        return [component canEditComponent];
    }
    return NO;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
                  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M80TableViewCellComponent *component = [self cellComponent:indexPath];
    if (component && [component respondsToSelector:@selector(editActions)])
    {
        return [component editActions];
    }
    return nil;
}


#pragma mark - 显示
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    M80TableViewCellComponent *component = [self cellComponent:indexPath];
    if (component && [component respondsToSelector:@selector(willDisplayCell:)])
    {
        [component willDisplayCell:cell];
    }
}


#pragma mark - 缓存清理
+ (void)performCacheClean:(dispatch_block_t)block
{
    M80TableViewCleanCache = YES;
    if(block) {block();}
    M80TableViewCleanCache = NO;
}

@end
