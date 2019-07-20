//
//  M80ViewController.m
//  M80TableViewComponent
//
//  Created by amao on 05/23/2019.
//  Copyright (c) 2019 amao. All rights reserved.
//

#import "M80ViewController.h"
#import <M80TableViewComponent/M80TableViewComponent.h>

@interface M80ItemComponent : M80TableViewCellComponent
@property (nonatomic,copy)  NSString    *title;
@property (nonatomic,copy)  NSString    *vcName;
@end

@implementation M80ItemComponent

+ (instancetype)component:(NSString *)title vcName:(NSString *)vcName
{
    M80ItemComponent *instance = [M80ItemComponent new];
    instance.title = title;
    instance.vcName= vcName;
    return instance;
}

- (Class)cellClass
{
    return UITableViewCell.class;
}

- (CGFloat)height
{
    return 44.0;
}

- (void)configure:(UITableViewCell *)cell
{
    cell.textLabel.text = self.title;
}

- (void)didSelect:(UITableViewCell *)cell
{
    Class cls = NSClassFromString(self.vcName);
    UIViewController *vc = [cls new];
    [self.context.viewController.navigationController pushViewController:vc
                                                                animated:YES];
}

@end

@interface M80ViewController ()
@property (nonatomic,strong)    M80TableViewComponent *tableViewComponent;
@end

@implementation M80ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"Example";
    
    NSArray *components = @[[M80ItemComponent component:@"Text" vcName:@"M80TextViewController"],
                            [M80ItemComponent component:@"ListDiff" vcName:@"M80ListDiffViewController"],
                            [M80ItemComponent component:@"Feed" vcName:@"M80FeedViewController"]];
    
    M80TableViewSectionComponent *section = [M80TableViewSectionComponent new];
    section.components = components;
    
    M80TableViewComponentContext *context = [M80TableViewComponentContext new];
    context.viewController = self;
    
    M80TableViewComponent *tableViewComponent = [[M80TableViewComponent alloc] initWithTableView:self.tableView];
    tableViewComponent.sections = @[section];
    tableViewComponent.context = context;
    
    self.tableViewComponent = tableViewComponent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
