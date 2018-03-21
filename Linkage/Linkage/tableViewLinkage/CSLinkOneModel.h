//
//  CSLinkOneModel.h
//  Linkage
//
//  Created by 曹世鑫 on 2018/3/20.
//  Copyright © 2018年 曹世鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSLinkOneModel : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *ProvinceName;
@property(strong,nonatomic)NSArray * cities;

@end

@interface CSCityModel : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *PID;
@property (nonatomic,copy) NSString *ZipCode;
@property (nonatomic,copy) NSString *CityName;
@end

