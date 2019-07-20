//
//  M80TableViewCellComponent.h
//  M80TableViewComponent
//
//  Created by amao on 2017/4/6.
//
//

#import <Foundation/Foundation.h>
#import "M80TableViewComponentProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class M80TableViewSectionComponent;
@class M80TableViewComponentContext;

@interface M80TableViewCellComponent : NSObject<M80TableViewCellComponent,M80ListDiffable>
@property (nonatomic,weak,nullable)             M80TableViewSectionComponent   *superComponent;
@property (nonatomic,weak,readonly,nullable)    UITableView *tableView;
@property (nonatomic,strong,readonly,nullable)  M80TableViewComponentContext *context;
@property (nonatomic,copy,readonly)             NSString *reuseIdentifier;
@property (nonatomic,strong,readonly)           UITableViewCell *nonReusableCell;       //只有设置 cell 不重用时当前方法才有效
@property (nonatomic,assign)                    BOOL deselectCellAutomaticallyDisabled; //针对当前 component 关闭自动反选功能

- (void)reload;
- (void)reload:(UITableViewRowAnimation)animation;

- (void)remove;
- (void)remove:(UITableViewRowAnimation)animation;

- (void)scroll:(UITableViewScrollPosition)position
      animated:(BOOL)animated;

- (void)measure;
- (CGFloat)internalHeight;

- (CGRect)rect;

@end

NS_ASSUME_NONNULL_END
