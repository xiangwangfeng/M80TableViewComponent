//
//  M80TableViewComponent.h
//  M80TableViewComponent
//
//  Created by amao on 2017/4/6.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "M80TableViewCellComponent.h"
#import "M80TableViewViewComponent.h"
#import "M80TableViewSectionComponent.h"
#import "M80TableViewComponentContext.h"
#import "UITableViewCell+M80.h"
#import "UITableViewHeaderFooterView+M80.h"

NS_ASSUME_NONNULL_BEGIN


@class M80TableViewComponent;


@interface M80TableViewComponent : NSObject<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign)                        BOOL deselectCellAutomatically;     //自动反选，默认为 YES
@property (nonatomic,weak,readonly,nullable)        UITableView *tableView;
@property (nonatomic,strong,nullable)               NSArray<M80TableViewSectionComponent *> *sections;
@property (nonatomic,strong,nullable)               M80TableViewComponentContext *context;


- (instancetype)initWithTableView:(UITableView *)tableView;

//刷新数据
//调用该接口后，会先移除所有 section 并进行遍历调用相应的 [section prepareData] 接口
//完成后，将所有 section 重新加入 component 并调用 [UITableView reloadData] 完整刷新界面
//上层需要实现 prepareData 的流程进行 cell component 的组装
- (void)reload;

//全刷新
- (void)performReloadAction:(dispatch_block_t)block;

- (void)addSection:(nullable M80TableViewSectionComponent *)section;
- (void)addSection:(nullable M80TableViewSectionComponent *)section
  withRowAnimation:(UITableViewRowAnimation)animation;

- (void)addSections:(nullable NSArray<M80TableViewSectionComponent *> *)sections;
- (void)addSections:(nullable NSArray<M80TableViewSectionComponent *> *)sections
   withRowAnimation:(UITableViewRowAnimation)animation;

- (void)insertSections:(nullable NSArray<M80TableViewSectionComponent *> *)sections
               atIndex:(NSUInteger)index;
- (void)insertSections:(nullable NSArray<M80TableViewSectionComponent *> *)sections
               atIndex:(NSUInteger)index
      withRowAnimation:(UITableViewRowAnimation)animation;

- (void)removeSection:(nullable M80TableViewSectionComponent *)section;
- (void)removeSection:(nullable M80TableViewSectionComponent *)section
     withRowAnimation:(UITableViewRowAnimation)animation;

- (void)reloadSection:(nullable M80TableViewSectionComponent *)section;
- (void)reloadSection:(nullable M80TableViewSectionComponent *)section
     withRowAnimation:(UITableViewRowAnimation)animation;

- (nullable M80TableViewSectionComponent *)sectionAt:(NSUInteger)index;
- (nullable M80TableViewCellComponent *)cellComponent:(NSIndexPath *)indexPath;
- (nullable M80TableViewViewComponent *)headerComponent:(NSUInteger)section;
- (nullable M80TableViewViewComponent *)footerComponent:(NSUInteger)section;

+ (void)performCacheClean:(dispatch_block_t)block;
@end


NS_ASSUME_NONNULL_END



