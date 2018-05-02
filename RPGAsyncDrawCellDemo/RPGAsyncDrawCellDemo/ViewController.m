//
//  ViewController.m
//  UCPlan
//
//  Created by 范杨 on 2018/4/25.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import "ViewController.h"
#import "CLoanFilterProductListModel.h"
#import "LoanCell.h"
#import "LoanCellLatout.h"
#import "YYFPSLabel.h"
#import <YYKit.h>
#import <GDPerformanceMonitor.h>

#define ScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight   [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray<LoanCellLatout *> *cellLayoutArray;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) YYFPSLabel *fpsLabel;
@end

@implementation ViewController

#pragma mark -life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self p_loadData];
}

#pragma mark - UI
- (void)initView{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.fpsLabel];
    [[GDPerformanceMonitor sharedInstance ] startMonitoring ];
}
#pragma mark - private
- (void)p_loadData{
    
    //模拟请求消耗时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CLoanFilterProductListModel *listModel = [self getData];
        
        //制造数据 6000条
        for (int j = 0; j < 200; j ++) {
            for (int i = 0; i < listModel.loanProducts.count; i ++) {
                LoanCellLatout *layout = [[LoanCellLatout alloc] initWithData:listModel.loanProducts[i]];
                [self.cellLayoutArray addObject:layout];
            }
        }
        
        [self.tableView reloadData];
    });
}

- (void)p_drawWithCell:(LoanCell *)cell{
    [cell clear];
    [cell draw];
}

#pragma mark - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellLayoutArray[indexPath.row].cellHeight;
}
#pragma mark datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellLayoutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LoanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoanCell" forIndexPath:indexPath];
    LoanCellLatout *layout = self.cellLayoutArray[indexPath.row];
    cell.cellLayout = layout;
    [self p_drawWithCell:cell];
    return cell;
    
}

#pragma mark - set && get
- (NSMutableArray<LoanCellLatout *> *)cellLayoutArray{
    if (!_cellLayoutArray) {
        _cellLayoutArray = [NSMutableArray array];
    }
    return _cellLayoutArray;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerClass:[LoanCell class] forCellReuseIdentifier:@"LoanCell"];
    }
    return _tableView;
}

- (YYFPSLabel *)fpsLabel{
    if (!_fpsLabel) {
        _fpsLabel = [YYFPSLabel new];
        [_fpsLabel sizeToFit];
        _fpsLabel.frame = CGRectMake(20, ScreenHeight - 30, 30, 20);
    }
    return _fpsLabel;
}

- (CLoanFilterProductListModel *)getData{
    
    NSDictionary *dict = @{
        @"data" : @{
                @"loanProducts" : @[@{
                                        @"creditLimit" : @"1000-1000元",
                                        @"productDesc" : @"费率:0.5%/7日|期限:7天",
                                        @"productIcon" : @"http://www.creditcat.cn/assets/images/product_icon/jiejitian.png",
                                        @"productLabel" : @"2小时放款,周转无忧",
                                        @"productName" : @"借几天",
                                        @"statisticalDesc" : @"1423000人成功申请",
                                    },
                                    @{
                                        @"creditLimit" : @"1000-5000元",
                                        @"productDesc" : @"费率:0.03%/日|期限:7天",
                                        @"productIcon" : @"http://www.creditcat.cn/assets/images/product_icon/hyb.png",
                                        @"productLabel" : @"只要芝麻分,不查征信",
                                        @"productName" : @"花赢宝",
                                        @"statisticalDesc" : @"2314人成功申请",
                                        },
                                    @{
                                        @"creditLimit" : @"500-2000元",
                                        @"productDesc" : @"费率:0.03%/日|期限:14、30天",
                                        @"productIcon" : @"http://www.creditcat.cn/assets/images/product_icon/dsq.png",
                                        @"productLabel" : @"低费率,放款快",
                                        @"productName" : @"贷上钱",
                                        @"statisticalDesc" : @"234114人成功申请",
                                        },
                                    
                                    ]
        },
        @"message" : @"请求数据成功",
        @"status" : @"000",
    };
    CLoanFilterProductListModel *listModel = [CLoanFilterProductListModel modelWithJSON:dict];
    return listModel;
}

@end
