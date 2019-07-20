//
//  M80ListDiffResult.m
//  M80TableViewComponent
//
//  Created by amao on 2018/7/3.
//

#import "M80ListDiffResult.h"

@implementation M80ListDiffMove

- (instancetype)initWithFrom:(NSIndexPath *)from
                          to:(NSIndexPath *)to
{
    if (self = [super init])
    {
        _from = from;
        _to = to;
    }
    return self;
}

- (NSUInteger)hash {
    return [_from hash] ^ [_to hash];
}

- (BOOL)isEqual:(id)object {
    if (object == self) {
        return YES;
    }
    if ([object isKindOfClass:[M80ListDiffMove class]]) {
        NSIndexPath *f1 = self.from, *f2 = [object from];
        NSIndexPath *t1 = self.to, *t2 = [object to];
        return [f1 isEqual:f2] && [t1 isEqual:t2];
    }
    return NO;
}

- (NSComparisonResult)compare:(id)object {
    return [[self from] compare:[object from]];
}

@end

@implementation M80ListDiffResult
- (NSInteger)changeCount
{
    return [_inserts count] + [_deletes count] + [_moves count];
}


- (NSString *)description
{
    NSMutableString *result = [NSMutableString new];
    
    [result appendFormat:@"\ndeletes: \n"];
    for (NSIndexPath *indexPath in _deletes)
    {
        [result appendFormat:@"[section %d row %d]\n",(int)indexPath.section,(int)indexPath.row];
    }
    [result appendFormat:@"inserts: \n"];
    for (NSIndexPath *indexPath in _inserts)
    {
        [result appendFormat:@"[section %d row %d]\n",(int)indexPath.section,(int)indexPath.row];
    }
    [result appendFormat:@"moves: \n"];
    for (M80ListDiffMove *move in _moves)
    {
        NSIndexPath *from = move.from;
        NSIndexPath *to = move.to;
        [result appendFormat:@"from [section %d row %d] to [section %d row %d]\n",(int)from.section,(int)from.row,(int)to.section,(int)to.row];
    }
    return result;
}

@end
