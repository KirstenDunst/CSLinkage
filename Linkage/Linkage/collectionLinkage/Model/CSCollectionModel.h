//
//  CSCollectionModel.h
//  Linkage
//
//  Created by 曹世鑫 on 2018/3/21.
//  Copyright © 2018年 曹世鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSCollectionModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *order;
@property (nonatomic,copy) NSString *status;
@property(strong,nonatomic)NSMutableArray * subcategories;

@end

@interface CSCollectionNextModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *order;
@property (nonatomic,copy) NSString *icon_url;

@end
