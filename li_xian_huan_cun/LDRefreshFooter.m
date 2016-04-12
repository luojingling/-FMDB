//
//  LDRefreshFooter.m
//  LosAngeles
//
//  Created by yaoquafeng on 15/12/15.
//  Copyright © 2015年 狗民网. All rights reserved.
//

#import "LDRefreshFooter.h"

@implementation LDRefreshFooter
- (void)prepare {
    [super prepare];
    NSArray *pullingImages = @[
                               [UIImage imageNamed:@"FooterRefresh1"],
                               ];
    NSMutableArray * refreshingImages = [NSMutableArray array];
    for (int i = 1; i < 18; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"FooterRefresh%d",i]];
        [refreshingImages addObject:image];
    }
    
    [self setImages:pullingImages forState:MJRefreshStatePulling];
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}
@end
