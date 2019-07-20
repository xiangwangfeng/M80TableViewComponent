//
//  M80TableViewCellHeightCache.h
//  M80TableViewComponent
//
//  Created by amao on 2018/6/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class M80TableViewCellComponent;

@interface M80TableViewCellHeightCache : NSObject
- (CGFloat)cellHeight:(M80TableViewCellComponent *)component;

- (void)setCellHeight:(CGFloat)height
            component:(M80TableViewCellComponent *)component;

- (void)cleanCellHeightCache:(M80TableViewCellComponent *)component;
@end

NS_ASSUME_NONNULL_END
