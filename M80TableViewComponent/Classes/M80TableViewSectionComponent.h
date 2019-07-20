//
//  M80TableViewSectionComponent.h
//  M80TableViewComponent
//
//  Created by amao on 2017/4/6.
//
//

#import <Foundation/Foundation.h>
#import "M80TableViewComponentProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class M80TableViewViewComponent;
@class M80TableViewCellComponent;
@class M80TableViewComponent;
@class M80TableViewComponentContext;

@interface M80TableViewSectionComponent : NSObject<M80TableViewSectionComponent>
@property (nonatomic,weak,readonly,nullable)         UITableView *tableView;
@property (nonatomic,weak,nullable)                  M80TableViewComponent *superComponent;
@property (nonatomic,strong,nullable)                NSArray<M80TableViewCellComponent *> *components;
@property (nonatomic,strong,nullable)                M80TableViewViewComponent  *header;
@property (nonatomic,strong,nullable)                M80TableViewViewComponent  *footer;
@property (nonatomic,assign,readonly)                CGFloat sectionHeight;
@property (nonatomic,strong,readonly,nullable)       M80TableViewComponentContext *context;

- (void)addComponent:(nullable M80TableViewCellComponent *)component;
- (void)addComponent:(nullable M80TableViewCellComponent *)component
     withRowAnimation:(UITableViewRowAnimation)animation;

- (void)addComponents:(nullable NSArray<M80TableViewCellComponent *> *)components;
- (void)addComponents:(nullable NSArray<M80TableViewCellComponent *> *)components
     withRowAnimation:(UITableViewRowAnimation)animation;

- (void)insertComponents:(nullable NSArray<M80TableViewCellComponent *> *)components
                 atIndex:(NSUInteger)index;
- (void)insertComponents:(nullable NSArray<M80TableViewCellComponent *> *)components
                 atIndex:(NSUInteger)index
       withRowAnimation:(UITableViewRowAnimation)animation;


- (void)removeComponent:(nullable M80TableViewCellComponent *)component;
- (void)removeComponent:(nullable M80TableViewCellComponent *)component
       withRowAnimation:(UITableViewRowAnimation)animation;

- (void)removeComponentsInRange:(NSRange)range;
- (void)removeComponentsInRange:(NSRange)range
       withRowAnimation:(UITableViewRowAnimation)animation;

- (void)reloadComponent:(nullable M80TableViewCellComponent *)component;
- (void)reloadComponent:(nullable M80TableViewCellComponent *)component
       withRowAnimation:(UITableViewRowAnimation)animation;

- (void)scrollToComponent:(nullable M80TableViewCellComponent *)component
         atScrollPosition:(UITableViewScrollPosition)position
                 animated:(BOOL)animated;


- (void)reload;
- (void)reload:(UITableViewRowAnimation)animation;

- (void)remove;
- (void)remove:(UITableViewRowAnimation)animation;

- (void)reloadUsingListDiff:(nullable NSArray<M80TableViewCellComponent *> *)components;

- (CGRect)rect;
- (CGRect)rectForCell:(M80TableViewCellComponent *)cellComponent;
- (CGRect)rectForView:(M80TableViewViewComponent *)viewComponent;
@end

NS_ASSUME_NONNULL_END
