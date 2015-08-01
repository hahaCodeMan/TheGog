//
//  DetailLiveController.m
//  TheGog
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "DetailLiveController.h"
#import "Define.h"
#import "DBManager.h"
#import "ArticleModel.h"
#import "UMSocial.h"


@interface DetailLiveController ()<UIWebViewDelegate>
{
    UILabel*_commentLabel;
    UIWebView*_webView;
    NSString*_Path;
    
}
@property(nonatomic,strong)UIWebView*webView;
@end

@implementation DetailLiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavgationBar];
    [self webViewData];
    
}

-(void)creatNavgationBar
{
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    imageview.userInteractionEnabled=YES;
    
    imageview.backgroundColor=[UIColor cyanColor];
    imageview.alpha=0.3;
    imageview.image=[UIImage imageNamed:@"头图标题栏底.png"];
    [self.view addSubview:imageview];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
   // [button setImage:[UIImage imageNamed:@"设置_1.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"返回_1.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(20, 5, 40, 35);
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:button];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-49, self.view.frame.size.width, 49)];
    imageView2.backgroundColor = [UIColor cyanColor];
    
    imageView2.userInteractionEnabled = YES;
    NSArray*imageNames=@[@"图片转发_2",@"图片收藏_2"];
    CGFloat width = imageView2.frame.size.width/3.0;
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width+100, 5, width-80, 35);
        [button setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal]; // 普通图片
        //[button setBackgroundImage:[UIImage imageNamed:selectedNames[i]] forState:UIControlStateSelected]; // 选中时图片
        [imageView2 addSubview:button];
        button.tag = 101+i;
       // button.backgroundColor=[UIColor cyanColor];
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
    switch (button.tag)
    {
        case 101:
        {
            //方法3 友盟
            //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
            //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
            
            NSString *text = [NSString stringWithFormat:@"我在宠物世界看到一篇不错的关于狗狗的文章%@",_Path];
            
            [UMSocialSnsService presentSnsIconSheetView:self appKey:@"507fcab25270157b37000010"
                                              shareText:text
                                             shareImage:[UIImage imageNamed: @"宠物世界logo.png"]
                                        shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToEmail,UMShareToRenren]
                                               delegate:self];
            
            
        }
            break;
        case 102:
        {
            //            BOOL isExist = [[DBManager sharedManager] isExistAppForAppId:self.articleId];
            //            //禁用状态的标题
            //            [self.favoriteButton setTitle:@"已收藏" forState:UIControlStateDisabled];
            //            [self.favoriteButton setTitle:@"收藏" forState:UIControlStateNormal];
            //
            //            if (isExist) {//收藏过
            //                //禁用
            //                self.favoriteButton.enabled = NO;
            //            }else{
            //                //
            //                self.favoriteButton.enabled = YES;
            //            }
            
            //收藏之后要把按钮禁用
            UIButton *btn = button;
            //禁用
            btn.enabled = NO;
            //收藏 记录到本地数据库
            
            //[[DBManager sharedManager] add:self.title articleId:self.id];
            [[DBManager sharedManager]add:self.title articleId:self.id des:self.des icon:self.icon];
            
            
        }
            break;
        case 103:
        {
            
            
            
        }
            break;
            
        default:
            break;
    }
 
    
}
#pragma mark - UM
//方法3:友盟
//弹出列表方法presentSnsIconSheetView需要设置delegate为self
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
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
