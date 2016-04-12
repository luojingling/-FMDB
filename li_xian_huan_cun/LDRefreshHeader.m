//
//  LDRefreshHeader.m
//  LosAngeles
//
//  Created by yaoquafeng on 15/12/15.
//  Copyright © 2015年 狗民网. All rights reserved.
//

#import "LDRefreshHeader.h"

@implementation LDRefreshHeader
- (void)prepare {
    [super prepare];
    
    NSArray *pullingImages = @[
                               [UIImage imageNamed:@"icon_refresh_anim_1"],
                               [UIImage imageNamed:@"icon_refresh_anim_2"]
                               ];
    
    NSArray *refreshingImages = @[
                                  [UIImage imageNamed:@"icon_refresh_anim_3"],
                                  [UIImage imageNamed:@"icon_refresh_anim_4"]
                                  ];
    
    [self setImages:pullingImages forState:MJRefreshStatePulling];
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}
@end
