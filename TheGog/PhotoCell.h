//
//  PhotoCell.h
//  TheGog
//
//  Created by qianfeng on 15/7/6.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Live4Model.h"

@interface PhotoCell : UITableViewCell
-(void)ShowDataWithPhoto:(Live4Model*)model;
@property (weak, nonatomic) IBOutlet UIImageView *faceimageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
- (IBAction)topCountClick:(id)sender;
- (IBAction)ShareClick:(id)sender;
- (IBAction)downImageClick:(id)sender;
- (IBAction)CommentClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *topcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topcountAddImage;

@end
