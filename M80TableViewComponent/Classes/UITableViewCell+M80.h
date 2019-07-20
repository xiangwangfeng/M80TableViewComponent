//
//  UITableViewCell+M80.h
//  M80TableViewComponent
//
//  Created by amao on 2019/5/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class M80TableViewCellComponent;

@interface UITableViewCell (M80)
@property (nullable,nonatomic,weak)  M80TableViewCellComponent  *m80_cellComponent;
@end

NS_ASSUME_NONNULL_END
