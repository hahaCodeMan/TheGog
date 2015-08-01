//
//  TGTabBarViewController.m
//  TheGog
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "TGTabBarViewController.h"
#import "TGFashionViewController.h"
#import "TGLiveViewController.h"
#import "TGTrainViewController.h"
#import "TGPhotoViewController.h"
#import "TGVoiceViewController.h"

@interface TGTabBarViewController ()
@property (nonatomic, assign) UIButton *lastSelectButton; // 如果这里写成retain, 那么要在dealloc中作相应的release操作
@property (nonatomic, assign) UILabel *lastHightlightedLabel;
@property(nonatomic,assign) UIImageView *lastHightlightedImageView;

@end

@implementation TGTabBarViewController
-(void)setLastSelectButton:(UIButton *)lastSelectButton
{
    if (_lastSelectButton==lastSelectButton) {
        _lastSelectButton.selected=NO;
                _lastSelectButton=lastSelectButton;
        _lastSelectButton.selected=YES;
        
    }
}
//-(void)setLastHightlightedImageView:(UIImageView *)lastHightlightedImageView
//{
//    if(_lastHightlightedImageView==lastHightlightedImageView)
//    {
//        return;
//    }
//    _lastHightlightedImageView.image=nil;
//    _lastHightlightedImageView=lastHightlightedImageView;
//    _lastHightlightedImageView.alpha=0.5;
//    _lastHightlightedImageView.image=[UIImage imageNamed:@"滑块.png"];
//    //lastHightlightedImageView.image=nil;
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden=YES;
    TGFashionViewController*fashion=[[TGFashionViewController alloc]init];
    //fashion.title=@"一";
    UINavigationController*nav1=[[UINavigationController alloc]initWithRootViewController:fashion];
    TGLiveViewController*live=[[TGLiveViewController alloc]init];
   // live.title=@"二";
    UINavigationController*nav2=[[UINavigationController alloc]initWithRootViewController:live];
    TGTrainViewController*train=[[TGTrainViewController alloc]init];
    UINavigationController*nav3=[[UINavigationController alloc]initWithRootViewController:train];
    TGPhotoViewController*photo=[[TGPhotoViewController alloc]init];
    UINavigationController*nav4=[[UINavigationController alloc]initWithRootViewController:photo];
    TGVoiceViewController*voice=[[TGVoiceViewController alloc]init];
    UINavigationController*nav5=[[UINavigationController alloc]initWithRootViewController:voice];
    self.viewControllers=@[nav1,nav2,nav3,nav4,nav5];
    [self creatTabBar];
  
}
-(void)creatTabBar
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-49, self.view.frame.size.width, 49)];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image=[UIImage imageNamed:@"一级栏目底.png"];
    imageView.userInteractionEnabled = YES;
    
    /** 49
     * UIButton height 39
     * UILabel height 10
     */
    NSArray *imageNames = @[@"潮流时尚_1",@"生活资讯_1",@"养护训练_1",@"精彩自拍_1",@"微声音_1"];
    NSArray *selectedNames = @[@"潮流时尚_2",@"生活资讯_2",@"养护训练_2",@"精彩自拍_2",@"微声音_2"];
   // NSArray *titles = @[@"限免", @"降价", @"免费", @"专题", @"热榜"];
    
    CGFloat width = imageView.frame.size.width/5.0;
    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width+10, 5, width-20, 39);
        [button setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal]; // 普通图片
        [button setBackgroundImage:[UIImage imageNamed:selectedNames[i]] forState:UIControlStateSelected]; // 选中时图片
        [imageView addSubview:button];
        button.tag = 101+i;
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
//        CGRect frame = button.frame;
//        frame.origin.y = CGRectGetMaxY(frame);
//        frame.size.height = 49 - frame.size.height - 5;
//        UILabel *label = [[UILabel alloc] initWithFrame:frame];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.backgroundColor = [UIColor clearColor];
//        label.font = [UIFont systemFontOfSize:12.0];
//        label.textColor = [UIColor darkGrayColor];
//        label.tag = 201 + i;
//        [imageView addSubview:label];
//        label.text = titles[i];
//        
//        UIImageView*imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(i*width+15, 0, width-30, 49)];
//        //  imageView2.userInteractionEnabled = YES;
//        imageView2.alpha=0.5;
//        imageView2.tag=301+i;
//        imageView2.image=[UIImage imageNamed:@"滑块.png"];
//        [imageView addSubview:imageView2];
        
    }
    
        UIImageView*imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(10, -2, width-30, 49)];
        //  imageView2.userInteractionEnabled = YES;
       imageView2.alpha=0.3;
        imageView2.tag=301;
        imageView2.image=[UIImage imageNamed:@"滑块.png"];
        [imageView addSubview:imageView2];
    [self.view addSubview:imageView];
  
}
- (void)buttonClick:(UIButton *)button {
    //self.lastSelectButton = button;
//    self.lastHightlightedLabel = (UILabel *)[self.view viewWithTag:button.tag + 100];
//    self.lastHightlightedImageView=(UIImageView*)[self.view viewWithTag:button.tag+200];
    
    UIImageView*view=(UIImageView*)[self.view viewWithTag:301];
    [UIView animateWithDuration:0.5 animations:^{
        view.frame=CGRectMake(button.frame.origin.x,-2, 50, 50);
       // view.layer.cornerRadius=10;
        //view.layer.borderColor=[[UIColor blueColor]CGColor];
        //view.layer.borderWidth=2;
    }];
    
    // 切换到相应的视图控制器
    self.selectedIndex = button.tag - 101;
}

@end
