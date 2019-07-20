//
//  M80TableViewComponentWeakValue.h
//  M80TableViewComponent
//
//  Created by amao on 2019/5/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface M80TableViewComponentWeakValue : NSObject
@property (nonatomic,weak,nullable)  id  item;
+ (instancetype)valueWithItem:(nullable id)item;
@end

NS_ASSUME_NONNULL_END
