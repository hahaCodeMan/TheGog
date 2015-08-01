//
//  Define.h
//  TheGog
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#ifndef TheGog_Define_h
#define TheGog_Define_h

#import "LZXHelper.h"
#import "MyControl.h"
//

#import "FashionCell.h"
#import "Live4Model.h"
#import "TrainSecondViewController.h"
#import "TrainThreeViewController.h"
#import "JHRefresh.h"
#import "MMProgressHUD.h"
#import "Define.h"
#import "SetingViewController.h"
//#define __UpLine__ // 上线的时候打开

#ifndef __UpLine__
//变参宏
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif




//流行时尚
#define KthisMonth @"http://cwsjgm.cms.palmtrends.com//api_v2.php?action=list&sa=benyueqiangdang&offset=%ld&count=7&e=9dbea54ffe5e7a985c6873c71fab8866&uid=11003130&pid=10089&mobile=iPhone3,1&platform=i"
//生活资讯
#define KShiyansi @"http://cwsjgm.cms.palmtrends.com//api_v2.php?action=list&sa=shiyanshi&offset%ld&count=15&e=a9ba49a86547852b7dc2596842d9f343&uid=11007766&pid=10089&mobile=iPhone5,2&platform=i"
#define Kwanzhuan @"http://cwsjgm.cms.palmtrends.com//api_v2.php?action=list&sa=wanzhuandiqu&offset=%ld&count=15&e=a9ba49a86547852b7dc2596842d9f343&uid=11007766&pid=10089&mobile=iPhone5,2&platform=i"
#define Kmeiwei @"http://cwsjgm.cms.palmtrends.com//api_v2.php?action=piclist&sa=meiweiuanxi&offset=%ld&count=8&e=a9ba49a86547852b7dc2596842d9f343&uid=11007766&pid=10089&mobile=iPhone5,2&platform=i"

//养护训练
//offset=0(初始),每次刷新加15条
#define KzhuliuDog @"http://cwsjgm.cms.palmtrends.com//api_v2.php?action=list&sa=zhuliugou&offset=%ld&count=15&e=a9ba49a86547852b7dc2596842d9f343&uid=11007766&pid=10089&mobile=iPhone5,2&platform=i"
#define Kzhengouxiu @"http://cwsjgm.cms.palmtrends.com//api_v2.php?action=list&sa=zhengouxiu&offset=%ld&count=15&e=a9ba49a86547852b7dc2596842d9f343&uid=11007766&pid=10089&mobile=iPhone5,2&platform=i"
#define KxiulianBaodain @"http://cwsjgm.cms.palmtrends.com//api_v2.php?action=list&sa=xunquanbaodian&offset=%ld&count=15&e=a9ba49a86547852b7dc2596842d9f343&uid=11007766&pid=10089&mobile=iPhone5,2&platform=i"
#define Kjiankang @"http://cwsjgm.cms.palmtrends.com//api_v2.php?action=list&sa=jiankangshouce&offset=%ld&count=15&e=a9ba49a86547852b7dc2596842d9f343&uid=11007766&pid=10089&mobile=iPhone5,2&platform=i"
//精彩自拍
#define KPhotoDog @"http://cwsjgm.cms.palmtrends.com//api_v2.php?action=zipailist&sa=22&offset=%ld&count=5&e=a9ba49a86547852b7dc2596842d9f343&uid=11007766&pid=10089&mobile=iPhone5,2&platform=i"
//微声音
#define Khoudong  @"http://cwsjgm.cms.palmtrends.com//api_v2.php?action=list&sa=huodongbaodao&offset=%ld&count=15&e=a9ba49a86547852b7dc2596842d9f343&uid=11007766&pid=10089&mobile=iPhone5,2&platform=i"
#define Kdarenzhi @"http://cwsjgm.cms.palmtrends.com/api_v2.php?action=list&sa=darenzhi&offset=%ld&count=15&uid=13654938&platform=a&mobile=Coolpad+8297W&pid=10089&e=b5b2f484359604eb5d65c75b8114a85d"
#define Kzhuanlan @"http://cwsjgm.cms.palmtrends.com/api_v2.php?action=zhuanlanlist&offset=%ld&count=15&uid=13654938&platform=a&mobile=Coolpad+8297W&pid=10089&e=b5b2f484359604eb5d65c75b8114a85d"


#endif
