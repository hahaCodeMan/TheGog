//
//  FashionCell.h
//  TheGog
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Live4Model.h"
#import "ArticleModel.h"

@interface FashionCell : UITableViewCell
-(void)ShowDataWithFavrite:(ArticleModel*)model Indexpath:(NSIndexPath*)indexPath isOne:(BOOL)isOne;

-(void)ShowDataWithLive:(Live4Model*)model isOne:(BOOL)isOne;
@property (weak, nonatomic) IBOutlet UIImageView *iconimageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end
