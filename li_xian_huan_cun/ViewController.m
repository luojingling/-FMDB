//
//  ViewController.m
//  li_xian_huan_cun
//
//  Created by 罗精灵 on 16/2/23.
//  Copyright © 2016年 luojingling. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "XLDataBase.h"
#import "GetTableViewData.h"
#import "ItemModel.h"
#import "ItemCell.h"
#import "LDRefreshHeader.h"
#import "LDRefreshFooter.h"
#import "LDIndicatorView.h"
#import "TwoViewController.h"

#define URL_TABLEVIEW @"http://192.168.1.138/interface/roadshow/list.aspx?pageno=%ld&pagecount=4&projecttype="

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    NSInteger _currentPage;
    NSInteger _pagecount;
}
@property (strong, nonatomic) LDIndicatorView * indicatorView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _currentPage = 1;
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 150.0;
    [self.view addSubview:_tableView];
    
    _tableView.header = [LDRefreshHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    _tableView.footer = [LDRefreshFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
     _dataArray = [NSMutableArray array];


    // Do any additional setup after loading the view, typically from a nib.
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated {
 
    [super viewDidAppear:animated];
    self.indicatorView = [[LDIndicatorView alloc] init];
    //    self.indicatorView.backgroundColor = [UIColor redColor];
    [self.indicatorView show];
    
    NSRange range = NSMakeRange(0, 10);
    //如果数据库有数据则读取，不发送网络请求
    if ([[XLDataBase listWithRange:range] count]) {
        [_dataArray addObjectsFromArray:[XLDataBase listWithRange:range]];
        NSLog(@"从数据库加载");
        [_tableView reloadData];
        [self.indicatorView gone];
    }else{
        [self getTableViewDataWithPage:_currentPage];
    }

}

#pragma mark GetDataSoure
//字典转模型
- (void)getTableViewDataWithPage:(NSInteger)page {
    NSLog(@"发送网络请求！");
    NSString *url = [NSString stringWithFormat:URL_TABLEVIEW, (long)page];
    [GetTableViewData getWithUrl:url param:nil modelClass:[ItemModel class] responseBlock:^(id dataObj, NSError *error) {
        [self.indicatorView gone];
        [_dataArray addObjectsFromArray:dataObj];
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    }];
}

//下拉刷新
- (void)loadNewData {
    NSLog(@"下拉刷新");
    _currentPage = 1;
    [_dataArray removeAllObjects];
    [self getTableViewDataWithPage:_currentPage];
}

//上拉加载
- (void)loadMoreData {
    NSLog(@"上拉加载");
    _currentPage ++;
    NSRange range = NSMakeRange(_currentPage * 10, 10);
    if ([[XLDataBase listWithRange:range] count]) {
        [_dataArray addObjectsFromArray:[XLDataBase listWithRange:range]];
        [_tableView reloadData];
        [_tableView.footer endRefreshing];
        NSLog(@"数据库加载%lu条更多数据",(unsigned long)[[XLDataBase listWithRange:range] count]);
    }else{
        //数据库没更多数据时再网络请求
        [self getTableViewDataWithPage:_currentPage];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = [ItemCell itemCellWithTableView:tableView];
    cell.item = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TwoViewController *autoLayoutVC = [[TwoViewController alloc]init];
    [self presentViewController:autoLayoutVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"当前控制器被销毁了");
}

@end
