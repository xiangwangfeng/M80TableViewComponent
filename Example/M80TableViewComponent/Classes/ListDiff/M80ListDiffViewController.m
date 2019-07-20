//
//  M80ListDiffViewController.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/27.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80ListDiffViewController.h"
#import "M80ListDiffCellComponent.h"

@interface M80ListDiffViewController ()
@property (nonatomic,strong)    M80TableViewComponent *component;
@property (nonatomic,strong)    NSArray *items;
@property (nonatomic,assign)    NSInteger index;
@end

@implementation M80ListDiffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.component = [[M80TableViewComponent alloc] initWithTableView:self.tableView];
    
    M80TableViewSectionComponent *section = [[M80TableViewSectionComponent alloc] init];
    [self.component addSections:@[section]];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(refresh)];
    
    _items = @[@[@1,@2,@3,@4,@5,@6,@7,@8,@9],
               @[@2,@3,@4,@5,@6,@7,@8,@9,@10],
               @[@4,@5,@6,@7,@8,@9,@2,@1,@3],
               @[@5,@11,@12,@23,@2,@4,@9,@7],
               @[@2,@9,@3,@1,@5,@6,@8],
               @[@2,@9,@3,@1,@5,@6,@8],
               @[@1,@2,@3,@4,@5,@6,@7],
               @[@1,@2,@3,@4,@5,@6,@7,@8,@9],
               @[@2,@3,@4,@5,@6,@7,@8,@9,@10],
               @[@4,@5,@6,@7,@8,@9,@2,@1,@3],
               @[@5,@11,@12,@23,@2,@4,@9,@7],
               @[@2,@9,@3,@1,@5,@6,@8],
               ];
    NSArray *components = [self componentsByNumbers:_items[0]];
    [[self.component sectionAt:0] setComponents:components];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(refresh)];
}

- (void)refresh
{
    _index++;
    if (_index >= [_items count])
    {
        _index = 0;
    }
    NSArray *numbers = [_items objectAtIndex:_index];
    NSArray *components = [self componentsByNumbers:numbers];
    [[self.component sectionAt:0] reloadUsingListDiff:components];
}


- (NSArray *)componentsByNumbers:(NSArray *)numbers
{
    NSMutableArray *components = [NSMutableArray array];
    for (NSNumber *number in numbers)
    {
        M80ListDiffCellComponent *component = [self componentByNumber:number];
        [components addObject:component];
    }
    return components;
}

- (M80ListDiffCellComponent *)componentByNumber:(NSNumber *)number
{
    M80ListDiffCellComponent *component = [[M80ListDiffCellComponent alloc] init];
    component.number = number;
    return component;
}

@end
