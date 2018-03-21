//
//  CSLinkOneModel.m
//  Linkage
//
//  Created by 曹世鑫 on 2018/3/20.
//  Copyright © 2018年 曹世鑫. All rights reserved.
//

#import "CSLinkOneModel.h"

@implementation CSLinkOneModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cities" : @"CSCityModel"};
}
@end


@implementation CSCityModel

@end
