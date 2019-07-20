//
//  M80FeedTextCell.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/6/13.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80FeedTextCell.h"

@interface M80FeedTextCell ()
@property (nonatomic,strong)    UILabel *contentLabel;
@end

@implementation M80FeedTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [M80FeedTextCell cellFont];
        _contentLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _contentLabel.text = text;
}


+ (CGFloat)height:(NSString *)text width:(CGFloat)width
{
    UIFont *font = [M80FeedTextCell cellFont];
    CGFloat contraintWidth = width - 15 - 15;
    CGRect rect = [text boundingRectWithSize:CGSizeMake(contraintWidth, CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    CGFloat height =  ceil(rect.size.height) + 1 + 1;
    return height;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _contentLabel.frame = CGRectMake(15, 1, self.bounds.size.width - 15 - 15, self.bounds.size.height - 1 - 1);
}




+ (UIFont *)cellFont
{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        font = [UIFont fontWithName:@"PingFangSC-Regular" size: 17];
    });
    return font;
}
@end
