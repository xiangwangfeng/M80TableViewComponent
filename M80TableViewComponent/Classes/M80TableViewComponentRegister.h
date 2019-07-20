//
//  M80TableViewComponentRegister.h
//  M80TableViewComponent
//
//  Created by amao on 2017/4/7.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class M80TableViewCellComponent;
@class M80TableViewViewComponent;

@interface M80TableViewComponentRegister : NSObject
- (instancetype)initWithTableView:(UITableView *)tableView;
- (void)registerTableViewCellComponent:(M80TableViewCellComponent *)component;
- (void)registerTableViewViewComponent:(M80TableViewViewComponent *)component;
@end


NS_ASSUME_NONNULL_END
