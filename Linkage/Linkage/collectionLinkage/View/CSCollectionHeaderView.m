//
//  CSCollectionHeaderView.m
//  Linkage
//
//  Created by 曹世鑫 on 2018/3/20.
//  Copyright © 2018年 曹世鑫. All rights reserved.
//

#import "CSCollectionHeaderView.h"
@interface CSCollectionHeaderView()
{
    UILabel *_label;
}
@end
@implementation CSCollectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    self.backgroundColor =[UIColor grayColor];
    _label = [[UILabel alloc] initWithFrame:self.bounds];
    
    _label.font = [UIFont systemFontOfSize:20];
    [self addSubview:_label];
}
-(void)setModel:(CSCollectionModel *)model{
    if (_model!= model) {
        _model = model;
    }
    _label.text = model.name;
}
@end
