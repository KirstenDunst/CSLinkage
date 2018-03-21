//
//  CSCollectionModel.m
//  Linkage
//
//  Created by 曹世鑫 on 2018/3/21.
//  Copyright © 2018年 曹世鑫. All rights reserved.
//

#import "CSCollectionModel.h"

@implementation CSCollectionModel

//yymodel的方法 解析完成后调用 返回指定数据类型
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"subcategories" : @"CSCollectionNextModel"};
}
@end


@implementation CSCollectionNextModel

@end
