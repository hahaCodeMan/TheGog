//
//  DeliciousModel.h
//  TheGog
//
//  Created by qianfeng on 15/7/7.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeliciousModel : NSObject
@property(nonatomic,strong)NSMutableArray* ModelArr;
@property(nonatomic,copy)NSString*icon;
@property(nonatomic,copy)NSString*title;
@property(nonatomic,copy)NSString*gid;
@property(nonatomic,copy)NSString*timestamp;
@property(nonatomic,copy)NSString*list;
@end
