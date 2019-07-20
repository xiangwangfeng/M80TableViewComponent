//
//  M80ListDiff.m
//  M80TableViewComponent
//
//  Created by amao on 2018/7/3.
//

#import "M80ListDiff.h"

@interface M80ListDiffMatchEntry : NSObject
@property (nonatomic,assign)    NSInteger   oldIndex;

@property (nonatomic,assign)    NSInteger   newIndex;
@end

@implementation M80ListDiffMatchEntry
- (instancetype)init
{
    if (self = [super init])
    {
        _oldIndex = -1;
        _newIndex = -1;
    }
    return self;
}
@end




M80ListDiffResult *M80ListDiff(NSArray<id<M80ListDiffable>> *oldArray,
                                 NSArray<id<M80ListDiffable>> *newArray,
                                 NSInteger section)
{
    //不考虑 update，因为上层会有重用 component 的操作，容易造成误用
    M80ListDiffResult *result = [M80ListDiffResult new];
    NSMutableArray<NSIndexPath *> *inserts = [NSMutableArray array];
    NSMutableArray<NSIndexPath *> *deletes = [NSMutableArray array];
    NSMutableArray<M80ListDiffMove *> *moves = [NSMutableArray array];
    NSInteger oldCount = (NSInteger)oldArray.count;
    NSInteger newCount = (NSInteger)newArray.count;
    
    //1.生成  [hash,index] table
    NSMutableDictionary<NSString *,M80ListDiffMatchEntry *> *table = [NSMutableDictionary dictionary];
    
    //遍历 oldArray 填充 table
    for (NSInteger i = 0; i < oldCount; i++)
    {
        id<M80ListDiffable> item = oldArray[i];
        NSString *key = [item diffableHash];
        if (key == nil)
        {
            assert(0);
            NSLog(@"diffable hash should not be nil");
            return nil;
        }
        M80ListDiffMatchEntry *entry = table[key];
        if (entry == nil)
        {
            entry = [M80ListDiffMatchEntry new];
            table[key] = entry;
        }
        entry.oldIndex = i;
    }
    
    //遍历 newArray 填充 table
    for (NSInteger i = 0; i < newCount; i++)
    {
        id<M80ListDiffable> item = newArray[i];
        NSString *key = [item diffableHash];
        if (key == nil)
        {
            assert(0);
            NSLog(@"diffable hash should not be nil");
            return nil;
        }
        M80ListDiffMatchEntry *entry = table[key];
        if (entry == nil)
        {
            entry = [M80ListDiffMatchEntry new];
            table[key] = entry;
        }
        entry.newIndex = i;
    }
    
    
    //2.寻找差异部分
    NSMutableArray *deleteOffsets = [NSMutableArray array];
    for (NSInteger i = 0; i < oldCount; i++)
    {
        deleteOffsets[i] = @0;
    }
    NSMutableArray *insertOffsets = [NSMutableArray array];
    for (NSInteger i = 0; i < newCount; i++)
    {
        insertOffsets[i] = @0;
    }
    NSInteger runningOffset = 0;
    
    //遍历 oldArray 找出删除的部分
    for (NSInteger i = 0; i < oldCount; i++)
    {
        deleteOffsets[i] = @(runningOffset);
        id<M80ListDiffable> item = oldArray[i];
        NSString *key = [item diffableHash];
        M80ListDiffMatchEntry *entry = table[key];
        //没有匹配项，则计为删除
        if (entry == nil ||
            entry.oldIndex != i ||
            entry.oldIndex == -1 ||
            entry.newIndex == -1)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i
                                                        inSection:section];
            [deletes addObject:indexPath];
            runningOffset++;
        }
    }
    
    //遍历 newArray 找出新增的部分
    runningOffset = 0;
    for (NSInteger i = 0; i < newCount; i++)
    {
        insertOffsets[i] = @(runningOffset);
        id<M80ListDiffable> item = newArray[i];
        NSString *key = [item diffableHash];
        M80ListDiffMatchEntry *entry = table[key];

        if(entry &&
           entry.oldIndex != -1 &&
           entry.newIndex == i)
        {
            NSInteger oldIndex = entry.oldIndex;
            NSInteger newIndex = entry.newIndex;
            NSInteger insertOffset = [insertOffsets[i] integerValue];
            NSInteger deleteOffset = [deleteOffsets[oldIndex] integerValue];
            if (oldIndex - deleteOffset + insertOffset != i) //已移位
            {
                NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:oldIndex
                                                               inSection:section];
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:newIndex
                                                               inSection:section];
                M80ListDiffMove *move = [M80ListDiffMove new];
                move.from = oldIndexPath;
                move.to = newIndexPath;
                [moves addObject:move];
            }
        }
        else
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i
                                                        inSection:section];
            [inserts addObject:indexPath];
            runningOffset++;
        }
    }

    
    //3. 更新 diff
    result.deletes = deletes;
    result.inserts = inserts;
    result.moves = moves;

    
    return result;
}
