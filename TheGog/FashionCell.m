//
//  FashionCell.m
//  TheGog
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "FashionCell.h"
#import "UIImageView+WebCache.h"

@implementation FashionCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)ShowDataWithFavrite:(ArticleModel*)model Indexpath:(NSIndexPath*)indexPath isOne:(BOOL)isOne
{
    self.titleLabel.text=model.title;
    self.desLabel.text=model.des;
    [self.iconimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cwsjgm.cms.palmtrends.com%@",model.icon]] placeholderImage:nil];
}
-(void)ShowDataWithLive:(Live4Model*)model isOne:(BOOL)isOne
{
    
        self.desLabel.text=model.des;
    
    self.titleLabel.text=model.title;
    
    [self.iconimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cwsjgm.cms.palmtrends.com%@",model.icon]] placeholderImage:nil];
    //[self.iconimageView sd_setImageWithURL:[NSURL URLWithString:@"http://cwsjgm.cms.palmtrends.com/upload/day_140212/201402121556533_listthumb_iphone4.jpg"] placeholderImage:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
