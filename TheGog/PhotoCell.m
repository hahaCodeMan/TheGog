//
//  PhotoCell.m
//  TheGog
//
//  Created by qianfeng on 15/7/6.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "PhotoCell.h"
#import "UIImageView+WebCache.h"

@implementation PhotoCell

- (void)awakeFromNib {
    // Initialization code
    //Live4Model*model=[[Live4Model alloc]init];
    //self.iconImageView.frame=CGRectMake(31, 63, model.width,model.height);
}
-(void)ShowDataWithPhoto:(Live4Model*)model
{
    self.titleLabel.text=model.title;
    self.desLabel.text=model.des;
    [self.faceimageView sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:[UIImage imageNamed:@"缺省_1.png"]];
   [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cwsjgm.cms.palmtrends.com%@",model.icon] ]placeholderImage:[UIImage imageNamed:@"a11.jpg"]];
    //[self.iconImageView sd_setImageWithURL:[NSURL URLWithString:@"http://cwsjgm.cms.palmtrends.com/upload/day_140212/201402121556533_listthumb_iphone4.jpg"] placeholderImage:[UIImage imageNamed:@"a8.jpg"]];
  
    self.dateLabel.text=[NSString stringWithFormat:@"%@",model.adddate];
    self.topcountLabel.text=model.topcount;
    self.commentLabel.text=model.zipaicount;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)topCountClick:(id)sender {
}

- (IBAction)ShareClick:(id)sender {
}

- (IBAction)downImageClick:(id)sender {
}

- (IBAction)CommentClick:(id)sender {
}
@end
