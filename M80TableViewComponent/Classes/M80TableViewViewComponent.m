//
//  M80TableViewViewComponent.m
//  M80TableViewComponent
//
//  Created by amao on 2017/4/6.
//
//

#import "M80TableViewViewComponent.h"
#import "M80TableViewSectionComponent.h"
#import "M80Sentinel.h"

@interface M80TableViewViewComponent ()
@property (nonatomic,strong)            NSNumber *viewIdentifier;
@end

@implementation M80TableViewViewComponent
- (instancetype)init
{
    if (self = [super init])
    {
        _viewIdentifier = [M80TableViewViewComponent componentIndex];
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

#pragma mark - require protoocl
- (CGFloat)height
{
    NSAssert(0, @"should override");
    return CGFLOAT_MIN;
}

- (void)configure:(UITableViewHeaderFooterView *)view
{
    NSAssert(0, @"should override");
}

#pragma mark - optional protocol
- (Class)viewClass
{
    NSAssert(0, @"should override");
    return [UITableViewHeaderFooterView class];
}


#pragma mark - public api
- (void)reload
{
    [self.superComponent reload];
}


- (void)remove
{
    if (self.superComponent.header == self)
    {
        self.superComponent.header = nil;
    }
    else if(self.superComponent.footer == self)
    {
        self.superComponent.footer = nil;
    }
}

- (CGRect)rect
{
    M80TableViewSectionComponent *component = self.superComponent;
    return component ? [component rectForView:self] : CGRectZero;
}



@end
