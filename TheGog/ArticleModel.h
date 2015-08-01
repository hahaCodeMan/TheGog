//
//  ArticleModel.h
//  TheGog
//
//  Created by qianfeng on 15/7/11.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject
@property(nonatomic,copy)NSString*id;
@property(nonatomic,copy)NSString*title;
@property(nonatomic,copy)NSString*des;
@property(nonatomic,copy)NSString*content;
@property(nonatomic,copy)NSString*icon;
@property(nonatomic,copy)NSString*author;
@property(nonatomic,copy)NSString*timestamp;
@property(nonatomic,copy)NSString*adddate;
@property(nonatomic,copy)NSString*qiandao;
@property(nonatomic,copy)NSString*qiandao_count;
@property(nonatomic,copy)NSString*mp3;
//
//{
//    "id": "2639",
//    "title": "可囧可萌  百变西施犬Shih Tzu ",
//    "des": "在人们的印象中，西施犬永远与中国古代宫闱庭院紧密相连，总是耳闻却难得一探究竟，神秘且令人充满好奇。但如果我们说其实它没有那么高贵，而是又囧又萌，会不会颠覆你对它的所有幻想？",
//    "content": "在人们的印象中，西施犬永远与中国古代宫闱庭院紧密相连，总是耳闻却难得一探究竟，神秘且令人充满好奇。但如果我们说其实它没有那么高贵，而是又囧又萌，会不会颠覆你对它的所有幻想？",
//    "icon": "/upload/day_140305/201403051646032_listthumb_iphone4.jpg",
//    "author": "",
//    "timestamp": "1394008620",
//    "adddate": "2014-03-05 16:37",
//    "qiandao": "0",
//    "qiandao_count": "0",
//    "mp3": 0
//},

@end
