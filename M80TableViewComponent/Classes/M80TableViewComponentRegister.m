//
//  M80TableViewComponentRegister.m
//  M80TableViewComponent
//
//  Created by amao on 2017/4/7.
//
//

#import "M80TableViewComponentRegister.h"
#import "M80TableViewCellComponent.h"
#import "M80TableViewViewComponent.h"

@interface M80TableViewComponentRegister ()
@property (nonatomic,weak)      UITableView     *tableView;
@property (strong,nonatomic)    NSMutableSet    *cellReuseIdentifiers;
@property (strong,nonatomic)    NSMutableSet    *viewReuseIdentifiers;
@end

@implementation M80TableViewComponentRegister
- (instancetype)initWithTableView:(UITableView *)tableView
{
    if (self = [super init])
    {
        _cellReuseIdentifiers = [[NSMutableSet alloc] init];
        _viewReuseIdentifiers = [[NSMutableSet alloc] init];
        _tableView = tableView;
    }
    return self;
}

- (void)registerTableViewCellComponent:(M80TableViewCellComponent *)component
{
    UITableView *tableView = self.tableView;
    NSString *reuseIdentifier = [component reuseIdentifier];
    if (tableView == nil ||
        [reuseIdentifier length] == 0 ||
        [_cellReuseIdentifiers containsObject:reuseIdentifier])
    {
        return;
    }
    if ([component respondsToSelector:@selector(cellNib)])
    {
        UINib *nib = [component cellNib];
        NSAssert(nib, @"cell nib should not be nil");
        if (nib)
        {
            [tableView registerNib:nib
            forCellReuseIdentifier:reuseIdentifier];
        }
    }
    else
    {
        Class cls = [component cellClass];
        NSAssert(cls, @"cell class should not be nil");
        if (cls)
        {
            [tableView registerClass:cls
              forCellReuseIdentifier:reuseIdentifier];
        }
    }
    [_cellReuseIdentifiers addObject:reuseIdentifier];
}

- (void)registerTableViewViewComponent:(M80TableViewViewComponent *)component
{
    UITableView *tableView = self.tableView;
    NSString *reuseIdentifier = [component reuseIdentifier];
    if (tableView == nil ||
        [reuseIdentifier length] == 0 ||
        [_viewReuseIdentifiers containsObject:reuseIdentifier])
    {
        return;
    }
    if ([component respondsToSelector:@selector(viewNib)])
    {
        UINib *nib = [component viewNib];
        NSAssert(nib, @"view nib should not be nil");
        if (nib)
        {
            [tableView registerNib:nib
forHeaderFooterViewReuseIdentifier:reuseIdentifier];
        }
    }
    else
    {
        Class cls = [component viewClass];
        NSAssert(cls, @"view class should not be nil");
        if (cls)
        {
            [tableView registerClass:cls
  forHeaderFooterViewReuseIdentifier:reuseIdentifier];
        }
    }
    [_viewReuseIdentifiers addObject:reuseIdentifier];
}

@end
