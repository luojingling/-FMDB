//
//  ItemModel.m
//  li_xian_huan_cun
//
//  Created by 罗精灵 on 16/2/23.
//  Copyright © 2016年 luojingling. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel
- (id)initWithDataDic:(NSDictionary *)data
{
    self = [super initWithDataDic:data];
    if (self) {
        self.ID = data[@"id"];
        
    }
    return  self;
}
@end
