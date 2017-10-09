//
//  book.h
//  MVVM+RAC请求网络数据
//
//  Created by Tix Xie on 2017/10/1.
//  Copyright © 2017年 TixXie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
/** 标题 */
@property(nonatomic, copy) NSString *title;
/** 价格 */
@property(nonatomic, copy) NSString *price;

+ (instancetype)bookWithDict:(NSDictionary *)dict;

@end
