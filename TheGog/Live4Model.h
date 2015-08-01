//
//  Live4Model.h
//  TheGog
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Live4Model : NSObject
@property(nonatomic,copy)NSString*title;
@property(nonatomic,copy)NSString*des;
@property(nonatomic,copy)NSString*icon;
@property(nonatomic,copy)NSString*id;
@property(nonatomic,copy)NSString*gid;
@property(nonatomic,copy)NSString*topcount;
@property(nonatomic,copy)NSString*zipaicount;
@property(nonatomic,copy)NSString*adddate;
@property(nonatomic,copy)NSString*face;
@property(nonatomic,copy)NSString*timestamp;
@property(nonatomic) float width;
@property(nonatomic) float height;
@property(nonatomic,copy)NSString*content;
//{
//    "id": "2933",
//    "topcount": "6",
//    "zipaicount": "0",
//    "title": " ",
//    "des": "请问这是什么狗",
//    "icon": "/upload/day_150628/201506281203422.jpg",
//    "width": 490,
//    "height": 367,
//    "face": "/120",
//    "timestamp": "1435464222",
//    "adddate": "2015-06-28 12:03"
//},
//{
//    "id": "2931",
//    "topcount": "24",
//    "zipaicount": "3",
//    "title": "NO幸福的味道",
//    "des": "大家好，我叫多多。请大家多多关照额",
//    "icon": "/upload/day_150505/201505050018225.png",
//    "width": 331,
//    "height": 480,
//    "face": "http://tp4.sinaimg.cn/2121370095/180/5683088611/0",
//    "timestamp": "1430756302",
//    "adddate": "2015-05-05 00:18"
//},

@end
