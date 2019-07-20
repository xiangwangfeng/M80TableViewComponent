//
//  M80TableViewComponentProtocol.h
//  M80TableViewComponent
//
//  Created by amao on 2017/4/7.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class M80TableViewComponentEvent;

//ListDiff 协议
@protocol M80ListDiffable <NSObject>
@required
- (NSString *)diffableHash;
@end


//Cell 协议
@protocol M80TableViewCellComponent <NSObject>

@required
- (CGFloat)height;
- (void)configure:(UITableViewCell *)cell;

@optional
//高度缓存
- (BOOL)shouldCacheHeight;

//UI 相关
- (Class)cellClass;
- (UINib *)cellNib;
- (BOOL)nonReusable;

//选择
- (void)didSelect:(UITableViewCell *)cell;
- (void)didDeselect:(UITableViewCell *)cell;

//显示
- (void)willDisplayCell:(UITableViewCell *)cell;

//编辑
- (BOOL)canEditComponent;
- (NSArray<UITableViewRowAction *> *)editActions;
@end


//View 协议
@protocol M80TableViewViewComponent <NSObject>

@required
- (CGFloat)height;
- (void)configure:(UITableViewHeaderFooterView *)view;

@optional
//kindof UITableViewHeaderFooterView
- (Class)viewClass;
- (UINib *)viewNib;
@end



//Section 协议
@protocol M80TableViewSectionComponent <NSObject>
@optional
- (void)prepareData;
@end


NS_ASSUME_NONNULL_END





