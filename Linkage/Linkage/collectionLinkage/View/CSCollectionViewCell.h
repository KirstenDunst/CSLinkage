//
//  CSCollectionViewCell.h
//  Linkage
//
//  Created by 曹世鑫 on 2018/3/20.
//  Copyright © 2018年 曹世鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSCollectionModel.h"

@interface CSCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic)CSCollectionNextModel *model;
@end