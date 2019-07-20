//
//  M80ListDiff.h
//  M80TableViewComponent
//
//  Created by amao on 2018/7/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "M80TableViewComponentProtocol.h"
#import "M80ListDiffResult.h"


M80ListDiffResult *M80ListDiff(NSArray<id<M80ListDiffable>> *oldArray,
                               NSArray<id<M80ListDiffable>> *newArray,
                               NSInteger section);
