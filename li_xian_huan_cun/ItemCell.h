//
//  ItemCell.h
//  OffLineCache
//
//  Created by Shelin on 15/11/19.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemModel;
@interface ItemCell : UITableViewCell
@property (nonatomic, strong) ItemModel *item;

+ (ItemCell *)itemCellWithTableView:(UITableView *)tableView;
@end
