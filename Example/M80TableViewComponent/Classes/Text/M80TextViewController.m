//
//  M80TextViewController.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/23.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80TextViewController.h"
#import <M80TableViewComponent/M80TableViewComponent.h>
#import "M80TextCellComponent.h"

@interface M80TextViewController ()
@property (nonatomic,strong)    M80TableViewComponent *tableViewComponent;
@property (nonatomic,assign)    NSInteger index;
@end

@implementation M80TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Text";
    
    M80TableViewSectionComponent *section = [M80TableViewSectionComponent new];
    M80TableViewComponent *tableViewComponent = [[M80TableViewComponent alloc] initWithTableView:self.tableView];
    tableViewComponent.sections = @[section];
    
    self.tableViewComponent = tableViewComponent;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                           target:self
                                                                                           action:@selector(edit:)];
    
}

- (void)edit:(id)sender
{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"编辑"
                                                                message:nil
                                                         preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *actions = @[[self addCellAction],
                         [self addCellsAction],
                         [self insertCellAction],
                         [self insertCellsAction],
                         [self addSectionAction],
                         [self addSectionsAction],
                         [self insertSectionAction],
                         [self insertSectionsAction],
                         [self cancelAction]];
    
    for(UIAlertAction *action in actions)
    {
        [vc addAction:action];
    }
    [self presentViewController:vc
                       animated:YES
                     completion:nil];
    
}

#pragma mark - action
- (UIAlertAction *)cancelAction
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    return action;
}
    

- (UIAlertAction *)addCellAction
{
    return [self action:@"往后添加 cell"
                handler:^(UIAlertAction *action) {
                    M80TableViewSectionComponent *section = [self.tableViewComponent sectionAt:0];
                    M80TextCellComponent *component = [self textCellComponent];
                    [section addComponent:component];
                    [component scroll:UITableViewScrollPositionTop
                             animated:YES];
                }];
}

- (UIAlertAction *)addCellsAction
{
    return [self action:@"往后添加 cells"
                handler:^(UIAlertAction *action) {
                    M80TableViewSectionComponent *section = [self.tableViewComponent sectionAt:0];
                    NSArray *components = [self textCellComponents];
                    [section addComponents:components];
                    [components.firstObject scroll:UITableViewScrollPositionTop
                                          animated:YES];
                }];
}

- (UIAlertAction *)insertCellAction
{
    return [self action:@"随机插入 cell"
                handler:^(UIAlertAction *action) {
                    M80TableViewSectionComponent *section = [self.tableViewComponent sectionAt:0];
                    NSUInteger count = section.components.count;
                    NSUInteger index = count == 0 ? 0 : (NSUInteger)(arc4random() % count);
                    M80TextCellComponent *component = [self textCellComponent];
                    [section insertComponents:@[component] atIndex:index];
                    [component scroll:UITableViewScrollPositionTop
                             animated:YES];
                }];
}


- (UIAlertAction *)insertCellsAction
{
    return [self action:@"随机插入 cells"
                handler:^(UIAlertAction *action) {
                    M80TableViewSectionComponent *section = [self.tableViewComponent sectionAt:0];
                    NSUInteger count = section.components.count;
                    NSUInteger index = count == 0 ? 0 : (NSUInteger)(arc4random() % count);
                    NSArray *components = [self textCellComponents];
                    [section insertComponents:components atIndex:index];
                    [components.firstObject scroll:UITableViewScrollPositionTop
                                          animated:YES];
                }];
}

- (UIAlertAction *)addSectionAction
{
    return [self action:@"往后添加 section"
                handler:^(UIAlertAction *action) {
                    
                    M80TableViewSectionComponent *section = [self textCellSection];
                    [self.tableViewComponent addSection:section];
                    M80TableViewCellComponent *component = section.components.lastObject;
                    [component scroll:UITableViewScrollPositionTop
                                animated:YES];
                }];
}

- (UIAlertAction *)addSectionsAction
{
    return [self action:@"往后添加 sections"
                handler:^(UIAlertAction *action) {
                    NSArray<M80TableViewSectionComponent *> *sections = [self textCellSections];
                    [self.tableViewComponent addSections:sections];
                    M80TableViewCellComponent *component = sections.lastObject.components.lastObject;
                    [component scroll:UITableViewScrollPositionTop
                             animated:YES];
                }];
}

- (UIAlertAction *)insertSectionAction
{
    return [self action:@"随机插入 section"
                handler:^(UIAlertAction *action) {
                    
                    M80TableViewSectionComponent *section = [self textCellSection];
                    NSInteger index = (NSUInteger)(arc4random() % self.tableViewComponent.sections.count);
                    [self.tableViewComponent insertSections:@[section] atIndex:index];
                    M80TableViewCellComponent *component = section.components.lastObject;
                    [component scroll:UITableViewScrollPositionTop
                             animated:YES];
                }];
}

- (UIAlertAction *)insertSectionsAction
{
    return [self action:@"随机插入 sections"
                handler:^(UIAlertAction *action) {
                    NSArray<M80TableViewSectionComponent *> *sections = [self textCellSections];
                    NSInteger index = (NSUInteger)(arc4random() % self.tableViewComponent.sections.count);
                    [self.tableViewComponent insertSections:sections atIndex:index];
                    M80TableViewCellComponent *component = sections.lastObject.components.lastObject;
                    [component scroll:UITableViewScrollPositionTop
                             animated:YES];
                }];
}



- (UIAlertAction *)action:(NSString *)title handler:(void (^)(UIAlertAction *action))handler
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                     style:UIAlertActionStyleDefault
                                                   handler:handler];
    return action;
}


#pragma mark - component
- (M80TextCellComponent *)textCellComponent
{
    self.index++;
    NSString *text = [NSString stringWithFormat:@"Text Cell No.%d",(int)self.index];
    return [M80TextCellComponent component:text];
}

- (NSArray<M80TextCellComponent *> *)textCellComponents
{
    NSMutableArray *components = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++)
    {
        self.index++;
        NSString *text = [NSString stringWithFormat:@"Text Cell No.%d",(int)self.index];
        [components addObject:[M80TextCellComponent component:text]];
    }
    return components;
}

- (M80TableViewSectionComponent *)textCellSection
{
    NSArray *components = [self textCellComponents];
    M80TableViewSectionComponent *section = [M80TableViewSectionComponent new];
    section.components = components;
    return section;
}

- (NSArray<M80TableViewSectionComponent *> *)textCellSections
{
    NSMutableArray *sections = [NSMutableArray array];
    for (NSInteger i = 0; i < 3 ; i++)
    {
        M80TableViewSectionComponent *section = [M80TableViewSectionComponent new];
        section.components = [self textCellComponents];
        [sections addObject:section];
    }
    return sections;
}
@end
