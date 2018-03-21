//
//  CSCollectionViewCell.m
//  Linkage
//
//  Created by 曹世鑫 on 2018/3/20.
//  Copyright © 2018年 曹世鑫. All rights reserved.
//

#import "CSCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface CSCollectionViewCell()
{
    UIImageView *_topImage;
    UILabel *_botlabel;
}
@end

@implementation CSCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 70, 70)];
        _topImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_topImage];
        
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 70, 30)];
        _botlabel.textAlignment = NSTextAlignmentCenter;
        _botlabel.textColor = [UIColor blueColor];
        _botlabel.font = [UIFont systemFontOfSize:15];
        _botlabel.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_botlabel];
    }
    return self;
}
- (void)setModel:(CSCollectionNextModel *)model{
    if (_model!=model) {
        _model = model;
    }
    [_topImage sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
    _botlabel.text = model.name;
}
@end
