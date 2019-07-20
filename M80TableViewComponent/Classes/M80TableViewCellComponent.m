//
//  M80TableViewCellComponent.m
//  M80TableViewComponent
//
//  Created by amao on 2017/4/6.
//
//

#import "M80TableViewCellComponent.h"
#import "M80TableViewSectionComponent.h"
#import "M80Sentinel.h"

@interface M80TableViewCellComponent ()
@property (nonatomic,assign)    CGFloat disposableHeight;
@property (nonatomic,strong)    UITableViewCell *internalNonReusableCell;
@property (nonatomic,strong)    NSNumber *cellIdentifier;
@end

@implementation M80TableViewCellComponent

- (instancetype)init
{
    if (self = [super init])
    {
        _cellIdentifier = [M80TableViewCellComponent componentIndex];
    }
    return self;
}

+ (NSNumber *)componentIndex
{
    static M80Sentinel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [M80Sentinel new];
    });
    return @([instance value]);
}


- (UITableView *)tableView
{
    return self.superComponent.tableView;
}

- (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (M80TableViewComponentContext *)context
{
    return self.superComponent.context;
}

- (UITableViewCell *)nonReusableCell
{
    NSAssert([self respondsToSelector:@selector(nonReusable)] && [self nonReusable], @"make sure using in not reuse mode");
    if (_internalNonReusableCell == nil)
    {
        if ([self respondsToSelector:@selector(cellNib)])
        {
            UINib *nib = [self cellNib];
            id cell = [[nib instantiateWithOwner:nil options:nil] firstObject];
            _internalNonReusableCell = (UITableViewCell *)cell;
        }
        else
        {
            Class cls = [self cellClass];
            _internalNonReusableCell = [[cls alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:nil];
        }
    }
    return _internalNonReusableCell;
}

#pragma mark - M80TableViewCellComponent require protoocl
- (CGFloat)height
{
    NSAssert(0, @"should override");
    return 0;
}

- (void)configure:(UITableViewCell*)cell
{
    NSAssert(0, @"should override");
}


#pragma mark - M80TableViewCellComponent optional protocol
- (Class)cellClass
{
    NSAssert(0, @"should override");
    return [UITableViewCell class];
}

#pragma mark - M80ListDiffable
- (NSString *)diffableHash
{
    //m80 cell diffable hash
    return [NSString stringWithFormat:@"m80cdh_%@",_cellIdentifier];
}

#pragma mark - reload
- (void)reload
{
    [self reload:UITableViewRowAnimationNone];
}

- (void)reload:(UITableViewRowAnimation)animation
{
    [self.superComponent reloadComponent:self
                        withRowAnimation:animation];
}

#pragma mark - remove
- (void)remove
{
    [self remove:UITableViewRowAnimationNone];

}

- (void)remove:(UITableViewRowAnimation)animation
{
    [self.superComponent removeComponent:self
                        withRowAnimation:animation];
}


#pragma mark - scroll
- (void)scroll:(UITableViewScrollPosition)position
      animated:(BOOL)animated
{
    [self.superComponent scrollToComponent:self
                          atScrollPosition:position
                                  animated:animated];
}

#pragma mark - height
- (void)measure
{
    _disposableHeight = [self height];
}

- (CGFloat)measuredHeight
{
    CGFloat height = _disposableHeight;
    _disposableHeight = 0;
    return height;
}

- (CGFloat)internalHeight
{
    CGFloat height = [self measuredHeight];
    return  height ? height : [self height];
}

#pragma mark - rect
- (CGRect)rect
{
    M80TableViewSectionComponent *component = self.superComponent;
    return component ? [component rectForCell:self] : CGRectZero;
}

@end
