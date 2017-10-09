//
//  RequestViewModel.h
//  MVVM+RAC请求网络数据
//
//  Created by Tix Xie on 2017/9/30.
//  Copyright © 2017年 TixXie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface RequestViewModel : NSObject<UITableViewDataSource>
/** 请求命令 */
@property(nonatomic, strong) RACCommand *requestCommand;
/** 模型数组 */
@property(nonatomic, copy) NSArray *models;
/** 控制器中的view */
@property(nonatomic, weak) UITableView *tableView;


@end
