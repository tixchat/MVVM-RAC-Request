//
//  ViewController.m
//  MVVM+RAC请求网络数据
//
//  Created by Tix Xie on 2017/9/30.
//  Copyright © 2017年 TixXie. All rights reserved.
//

#import "ViewController.h"
#import "RequestViewModel.h"

@interface ViewController ()
/** tableView */
@property(nonatomic, weak) UITableView * tableView;
/** VM */
@property(nonatomic, strong) RequestViewModel *requesetViewModel;

@end

@implementation ViewController

/** 懒加载VM */
- (RequestViewModel *)requesetViewModel
{
    if (_requesetViewModel == nil) {
        _requesetViewModel = [[RequestViewModel alloc] init];
    }
    return _requesetViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self.requesetViewModel;
    self.requesetViewModel.tableView = tableView;
    [self.view addSubview:tableView];
    // 执行请求
    [self.requesetViewModel.requestCommand execute:nil];
}

@end
