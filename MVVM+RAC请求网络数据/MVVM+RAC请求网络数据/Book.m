//
//  book.m
//  MVVM+RAC请求网络数据
//
//  Created by Tix Xie on 2017/10/1.
//  Copyright © 2017年 TixXie. All rights reserved.
//

#import "Book.h"

@implementation Book

/**
 字典转模型

 @param dict 字典
 @return 模型
 */
+ (instancetype)bookWithDict:(NSDictionary *)dict
{
    Book *book = [[self alloc] init];
    book.title = dict[@"title"];
    book.price = dict[@"price"];
    
    return book;
}

@end
