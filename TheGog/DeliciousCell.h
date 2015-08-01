//
//  DeliciousCell.h
//  TheGog
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DeliciousModel.h"
#import "Live4Model.h"
@interface DeliciousCell : UICollectionViewCell
-(void)ShowDataWithDelicious:(Live4Model*)model;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
