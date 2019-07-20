//
//  M80TableViewViewComponent.h
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

@interface M80TableViewViewComponent : NSObject<M80TableViewViewComponent>
@property (nonatomic,weak,nullable)              M80TableViewSectionComponent   *superComponent;
@property (nonatomic,weak,readonly,nullable)     UITableView                     *tableView;
@property (nonatomic,strong,readonly,nullable)   M80TableViewComponentContext   *context;
@property (nonatomic,copy,readonly)              NSString                        *reuseIdentifier;

- (void)reload;
- (void)remove;

- (CGRect)rect;
@end

NS_ASSUME_NONNULL_END
