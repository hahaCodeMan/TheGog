//
//  ThisMonthSecondViewController.m
//  TheGog
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "ThisMonthSecondViewController.h"
#import "UMSocial.h"
#import "DBManager.h"

@interface ThisMonthSecondViewController ()<UIWebViewDelegate>
{
    UILabel*_commentLabel;
    UIWebView*_webView;
    NSString*_Path;
    
}
@property(nonatomic,strong)UIWebView*webView;
@end

@implementation ThisMonthSecondViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavgationBar];
    [self webViewData];
    
}

-(void)creatNavgationBar
{
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    imageview.userInteractionEnabled=YES;
    imageview.alpha=0.5;
     imageview.image=[UIImage imageNamed:@"头图标题栏底.png"];
    [self.view addSubview:imageview];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
    //[button setImage:[UIImage imageNamed:@"设置_1.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"返回_1.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(20, 5, 40, 35);
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:button];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-49, self.view.frame.size.width, 49)];
   //imageView2.image=[UIImage imageNamed:@"头图标题栏底.png"];
    imageView2.backgroundColor=[UIColor cyanColor];
    imageView2.alpha=0.1;
    imageView2.userInteractionEnabled = YES;
    NSArray*imageNames=@[@"图片转发_1",@"图片收藏_1"];
    CGFloat width = imageView2.frame.size.width/3.0;
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width+100, 5, width-80, 35);
        [button setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal]; // 普通图片
        //[button setBackgroundImage:[UIImage imageNamed:selectedNames[i]] forState:UIControlStateSelected]; // 选中时图片
        [imageView2 addSubview:button];
        button.tag = 101+i;
       button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49)];
        
        [self.view addSubview:self.webView];
        
    }
//    _commentLabel=[[UILabel alloc]initWithFrame:CGRectMake(2*width+40+width-80, 5, 20, 10)];
//    _commentLabel.textColor=[UIColor blackColor];
//    _commentLabel.textAlignment=NSTextAlignmentLeft;
//    _commentLabel.font=[UIFont systemFontOfSize:8];
//    _commentLabel.text=[NSString stringWithFormat:@"(%d)",10];
//    [imageView2 addSubview:_commentLabel];
    [self.view addSubview:imageView2];
    
}
-(void)webViewData
{
    //添加网址
    NSString*str1=@"http://cwsjgm.cms.palmtrends.com//api_v2.php?action=article&uid=11003130&pid=10089&id=";
    
    _Path = [str1  stringByAppendingString:[NSString stringWithFormat:@"%f&mobile=iphone4&e=9dbea54ffe5e7a985c6873c71fab8866&platform=i&fontsize=m",self.IDnumber] ];
    //NSLog(@"+++%@",self.id);
    //转化成NSURL
    NSURL * url = [NSURL URLWithString:_Path];
    //将URL封装成request对象
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    //将解析的数据显示在webView上
    
    
    self.webView.delegate =self;
    [self.webView loadRequest:request];
}
-(void)btnClick:(UIButton*)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)buttonClick:(UIButton*)button
{

  
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@",request);
    if (![request.URL isEqual:[NSURL URLWithString:_Path]])
    {
        return NO;
    }
    return YES;
}
@end

