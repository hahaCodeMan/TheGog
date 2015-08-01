//
//  FavoriteDetailViewController.m
//  TheGog
//
//  Created by qianfeng on 15/7/12.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "FavoriteDetailViewController.h"

#import "Define.h"


@interface FavoriteDetailViewController()<UIWebViewDelegate>
{
    UILabel*_commentLabel;
    UIWebView*_webView;
    NSString*_Path;
    
}
@property(nonatomic,strong)UIWebView*webView;
@end

@implementation FavoriteDetailViewController

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
    imageview.backgroundColor=[UIColor blueColor];
    [self.view addSubview:imageview];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:[UIImage imageNamed:@"设置_1.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(20, 5, 40, 35);
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:button];
    
        self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
        
        [self.view addSubview:self.webView];
        
    

    
}
-(void)webViewData
{
    //添加网址
    NSString*str1=@"http://cwsjgm.cms.palmtrends.com//api_v2.php?action=article&uid=11003130&pid=10089&id=";
    
    _Path = [str1  stringByAppendingString:[NSString stringWithFormat:@"%@&mobile=iphone4&e=9dbea54ffe5e7a985c6873c71fab8866&platform=i&fontsize=m",self.id] ];
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
