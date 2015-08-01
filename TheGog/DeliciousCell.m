//
//  DeliciousCell.m
//  TheGog
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "DeliciousCell.h"
#import "UIImageView+WebCache.h"


@implementation DeliciousCell

- (void)awakeFromNib {
    
    self.iconImageView.frame=CGRectMake(0, 0, 170, 200);
    
}
-(void)ShowDataWithDelicious:(Live4Model*)model;
{
    self.titleLabel.text=model.title;
    //[self.iconImageView sd_setImageWithURL:[NSURL URLWithString:@"http://cwsjgm.cms.palmtrends.com/upload/day_140212/201402121556533_listthumb_iphone4.jpg"] placeholderImage:[UIImage imageNamed:@"a8.jpg"]];
   [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cwsjgm.cms.palmtrends.com%@",model.icon]] placeholderImage:nil];
    //[self addSubview:self.iconImageView];
}
@end
