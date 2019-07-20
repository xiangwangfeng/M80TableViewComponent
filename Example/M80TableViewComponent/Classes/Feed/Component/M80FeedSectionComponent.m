//
//  M80FeedSectionComponent.m
//  M80TableViewComponent_Example
//
//  Created by amao on 2019/5/30.
//  Copyright © 2019 amao. All rights reserved.
//

#import "M80FeedSectionComponent.h"
#import "M80FeedAvatarCellComponent.h"
#import "M80FeedTextCellComponent.h"
#import "M80FeedPaddingCellComponent.h"
#import "M80FeedToolbarCellComponent.h"
#import "M80FeedImageCellComponent.h"

@implementation M80FeedSectionComponent
+ (instancetype)sectionByFeed:(M80Feed *)feed
{
    M80FeedSectionComponent *section = [M80FeedSectionComponent new];
    section.feed = feed;
    
    NSMutableArray *components = [NSMutableArray array];
    
    //头像
    {
        M80FeedAvatarCellComponent *component = [M80FeedAvatarCellComponent new];
        [components addObject:component];
    }
    //8pt 间距
    {
        M80FeedPaddingCellComponent *component = [M80FeedPaddingCellComponent new];
        component.paddingHeight = 8;
        [components addObject:component];
    }
    
    //文本
    {
        if ([feed.text length])
        {
            M80FeedTextCellComponent *component = [M80FeedTextCellComponent new];
            component.feed = feed;
            [component measure];
            [components addObject:component];
        }
        
    }
    
    //图片
    {
        if ([feed.images count])
        {
            M80FeedImageCellComponent *component = [M80FeedImageCellComponent new];
            component.feed = feed;
            [component measure];
            [components addObject:component];
        }
    }
    
    //10pt 间距
    {
        M80FeedPaddingCellComponent *component = [M80FeedPaddingCellComponent new];
        component.paddingHeight = 10;
        [components addObject:component];
    }
    
    //1px 间距
    {
        M80FeedPaddingCellComponent *component = [M80FeedPaddingCellComponent new];
        component.paddingHeight = 1 / UIScreen.mainScreen.scale;
        component.color = [UIColor colorWithRed:240/255.0
                                          green:240/255.0
                                           blue:240/255.0
                                          alpha:1];
        [components addObject:component];
    }
    
    //toolbar
    {
        M80FeedToolbarCellComponent *component = [M80FeedToolbarCellComponent new];
        [components addObject:component];
    }
    
    //cell 间距
    {
        M80FeedPaddingCellComponent *component = [M80FeedPaddingCellComponent new];
        component.paddingHeight = 10;
        component.color = [UIColor colorWithRed:240/255.0
                                          green:240/255.0
                                           blue:240/255.0
                                          alpha:1];
        [components addObject:component];
    }
    
    section.components = components;
    return section;
}
@end
