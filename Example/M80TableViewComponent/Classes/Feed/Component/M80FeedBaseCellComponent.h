//
//  M80FeedBaseCellComponent.h
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/30.
//  Copyright © 2019 amao. All rights reserved.
//

#import <M80TableViewComponent/M80TableViewComponent.h>
#import "M80Feed.h"

NS_ASSUME_NONNULL_BEGIN

@interface M80FeedBaseCellComponent : M80TableViewCellComponent
@property (nonatomic,strong)    M80Feed *feed;
@end

NS_ASSUME_NONNULL_END
