//
//  RequestViewModel.m
//  MVVM+RAC请求网络数据
//
//  Created by Tix Xie on 2017/9/30.
//  Copyright © 2017年 TixXie. All rights reserved.
//

#import "RequestViewModel.h"
#import <AFNetworking.h>
#import "Book.h"

@implementation RequestViewModel
/** 初始化时绑定 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialBind];
    }
    return self;
}

/** 绑定 */
- (void)initialBind
{
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            
            parameters[@"q"] = @"基础";
            // 网络请求
            [[AFHTTPSessionManager manager] GET:@"https://api.douban.com/v2/book/search" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                // 请求成功调用
                // 把数据用信号传递出去
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"网络请求失败");
                
            }];
            return nil;
        }];
        // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
        return [requestSignal map:^id _Nullable(id  _Nullable value) {
            NSMutableArray *dictArr = value[@"books"];
            // 字典转模型，遍历字典中的所有元素，全部映射成模型，并且生成数组
            NSArray *modelArr = [[dictArr.rac_sequence map:^id _Nullable(id  _Nullable value) {
                
                return [Book bookWithDict:value];
                
            }] array];
            
            return modelArr;
        }];
    }];
    
    // 获取请求的数据
    [_requestCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        // 有了新数据，赋值并刷新表格
        _models = x;
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    Book *book = self.models[indexPath.row];
    
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.price;
    
    return cell;
}

@end
