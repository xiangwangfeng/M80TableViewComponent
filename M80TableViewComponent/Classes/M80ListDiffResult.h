//
//  M80ListDiffResult.h
//  M80TableViewComponent
//
//  Created by amao on 2018/7/3.
//

#import <Foundation/Foundation.h>

@interface M80ListDiffMove : NSObject
- (instancetype)initWithFrom:(NSIndexPath *)from
                          to:(NSIndexPath *)to;

@property (nonatomic,strong)    NSIndexPath *from;
@property (nonatomic,strong)    NSIndexPath *to;
@end


@interface M80ListDiffResult : NSObject   
@property (nonatomic,strong)    NSArray<NSIndexPath *>  *inserts;

@property (nonatomic,strong)    NSArray<NSIndexPath *>  *deletes;

@property (nonatomic,strong)    NSArray<M80ListDiffMove *>  *moves;

@property (nonatomic,assign,readonly) NSInteger changeCount;


@end
