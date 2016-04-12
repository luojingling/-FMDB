//
//  GetTableViewData.m
//  XLNetwork
//
//  Created by Shelin on 15/11/10.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "GetTableViewData.h"
#import "XLDataBase.h"
#import "ItemModel.h"
@implementation GetTableViewData

//重写父类方法
+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass {
    
    NSArray *lists = responseObj[@"data"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in lists) {
        ItemModel *model = [[ItemModel alloc]initWithDataDic:dict];
//        [modelClass setupReplacedKeyFromPropertyName:^NSDictionary *{
//            return @{ @"ID" : @"id" };
//        }];
        [array addObject:model];
        
        //先判断数据是否存储过，如果没有，网络请求新数据存入数据库
        if (![XLDataBase isExistWithId:dict[@"id"]]) {
            //存数据库
            NSLog(@"存入数据库");
            [XLDataBase saveItemDict:dict ];
        }
    }
    return array;
}

@end
