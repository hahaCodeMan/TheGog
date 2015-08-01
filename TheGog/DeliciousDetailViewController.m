//
//  DeliciousDetailViewController.m
//  TheGog
//
//  Created by qianfeng on 15/7/14.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "DeliciousDetailViewController.h"
#import "AFNetworking.h"
#import "Live4Model.h"
#import "UIImageView+WebCache.h"
#import "Define.h"

@interface DeliciousDetailViewController ()
{
    NSMutableArray* _dataArry;
    UIScrollView* _scrollView;
    UITextView* _textView;
    NSInteger _num;
}
@property(nonatomic)NSMutableArray*dataArry;
@property(nonatomic)UIScrollView*scrollView;
@property(nonatomic)UITextView*textView;

@end

@implementation DeliciousDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavgationBar];
    [self addTaskWithUrl:nil gid:self.gid];
    
    
    
}
-(void)creatNavgationBar
{
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    imageview.userInteractionEnabled=YES;
    imageview.alpha=0.5;
    imageview.backgroundColor=[UIColor blueColor];
    [self.view addSubview:imageview];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
    //[button setImage:[UIImage imageNamed:@"设置_1.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"返回_1.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(20, 5, 40, 35);
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:button];
   
//    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-49, self.view.frame.size.width, 49)];
//    imageView2.backgroundColor = [UIColor blueColor];
//    
//    imageView2.userInteractionEnabled = YES;
//    NSArray*imageNames=@[@"图片转发_2",@"图片收藏_2",@"图片评论_2",];
//    CGFloat width = imageView2.frame.size.width/3.0;
//    for (int i = 0; i < 3; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(i*width+40, 5, width-80, 35);
//        [button setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal]; // 普通图片
//        //[button setBackgroundImage:[UIImage imageNamed:selectedNames[i]] forState:UIControlStateSelected]; // 选中时图片
//        [imageView2 addSubview:button];
//        button.tag = 101+i;
//        button.backgroundColor=[UIColor clearColor];
//        [button addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    }
-(void)creattextView
{
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 250)];
    //self.textView.backgroundColor=[UIColor redColor];
    self.textView.text=[self.dataArry[_num] des];
    self.textView.font=[UIFont systemFontOfSize:17];
    self.textView.editable=NO;
    [self.view addSubview:self.textView];
}
-(void)creatScrollView
{
    
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-300)];
    self.scrollView.userInteractionEnabled=YES;
    //self.scrollView.backgroundColor=[UIColor redColor];
    
    
    for (NSInteger i=0; i<self.dataArry.count; i++)
    {
       
        
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width,self.scrollView.frame.size.height)];
        imageView.userInteractionEnabled=YES;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cwsjgm.cms.palmtrends.com/%@",[self.dataArry[i] icon]]]placeholderImage:[UIImage imageNamed:@"图片内文底.png"]];
        
        
        [self.scrollView addSubview:imageView];
        self.textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 250)];
        //self.textView.backgroundColor=[UIColor redColor];
        self.textView.text=[self.dataArry[i] des];
        self.textView.font=[UIFont systemFontOfSize:17];
        self.textView.editable=NO;
        self.textView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:self.textView];
    
  
    }
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width*self.dataArry.count, self.scrollView.frame.size.height);
    //分页打开
    self.scrollView.pagingEnabled=YES;
    self.scrollView.bounces=NO;
    self.scrollView.backgroundColor=[UIColor yellowColor];
    //self.scrollView.alpha=0.3;
    [self.view addSubview:self.scrollView];
    //[self.dataArry removeAllObjects];
}
-(void)addTaskWithUrl:(NSString*)url gid:(NSString*)gid
{
    NSString*urlStr=[NSString stringWithFormat:@"http://cwsjgm.cms.palmtrends.com/api_v2.php?action=picture&gid=%@&offset=0&count=100&uid=13654938&platform=a&mobile=Coolpad+8297W&pid=10089&e=b5b2f484359604eb5d65c75b8114a85d",gid];
    NSLog(@"+++++%@----",urlStr);
    [self FetchWebData:urlStr];
  }

-(void)FetchWebData:(NSString*)url
{  self.dataArry=[[NSMutableArray alloc]init];
   // [self.dataArry removeAllObjects];
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showDeterminateProgressWithTitle:@"请稍等" status:@"正在加载..."];
    //------------------------------------------
    
    NSString *path =[LZXHelper getFullPathWithFile:url];
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    //是否超时 一天
    BOOL isTimeout = [LZXHelper isTimeOutWithFile:url timeOut:24*60*60];
    if ((isExist == YES)&&(isTimeout == NO) ) {
        //同时成立
        //走本地缓存数据
        NSData *data = [NSData dataWithContentsOfFile:[LZXHelper getFullPathWithFile:url]];
        //解析二进制数据
        //        if (self.OffSet == 0) {
        //            [self.dataArr removeAllObjects];
        //        }
        NSMutableArray*arr=[NSJSONSerialization JSONObjectWithData:data options:  NSJSONReadingMutableContainers error:nil];
        for (NSDictionary*dict in arr)
        {
            Live4Model*model=[[Live4Model alloc]init];
            model.des=dict[@"des"];
            model.icon=dict[@"icon"];
            model.id=dict[@"id"];
            [self.dataArry addObject:model];
        }
        [self creatScrollView];        //关闭特效
        [MMProgressHUD dismissWithSuccess:@"成功" title:@"本地数据下载完成"];
        
        return;
    }
    
    //[self.dataArry removeAllObjects];
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"下载成功");
         if (responseObject) {
             
             //缓存第一页
             NSData *data = (NSData *)responseObject;
             //把二进制数据保存到本地
             //把url 地址作为缓存文件的名字(内部用md5加密)
             //YES 是否考虑安全(会创建临时文件)
             
             [data writeToFile:[LZXHelper getFullPathWithFile:url] atomically:YES];
             NSMutableArray*arr=[NSJSONSerialization JSONObjectWithData:responseObject options:  NSJSONReadingMutableContainers error:nil];
             for (NSDictionary*dict in arr)
             {
                 Live4Model*model=[[Live4Model alloc]init];
                 model.des=dict[@"des"];
                 model.icon=dict[@"icon"];
                 model.id=dict[@"id"];
                 [self.dataArry addObject:model];
             }
             [self creatScrollView];
             [MMProgressHUD dismissWithSuccess:@"加载完成" title:@"OK"];
             
             
            
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"下载失败");
         [MMProgressHUD dismissWithError:@"加载失败" title:@"请检查网络!"];
     }];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
     _num= scrollView.contentOffset.x / scrollView.frame.size.width;
    
}
-(void)btnClick:(UIButton*)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
