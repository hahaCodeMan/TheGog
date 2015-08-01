//
//  TGFashionViewController.m
//  TheGog
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "Define.h"
#import "TGFashionViewController.h"
#import "FashionCell.h"
#import "UIImageView+WebCache.h"
#import "Live4Model.h"
#import "AFNetworking.h"
#import "ThisMonthSecondViewController.h"
#import "MMProgressHUD.h"


@interface TGFashionViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSInteger _num;
    UITableView*_tableView;
    NSMutableArray*_dataArry;
    UIScrollView*_scrollView;
    UIPageControl*_pageControl;
    NSString*_Kstr;
    
    UIButton*_refrashbutton;
    UIButton*_addDatabutton;
    UILabel*_label;
    NSInteger _offSet;
    NSString* _UrlStr;
    UILabel* _desLabel;

}
//@property (nonatomic, assign) UIButton *lastSelectButton;
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*dataArry;
@property(nonatomic,strong)UIScrollView*scrollView;
@property(nonatomic,strong)UIPageControl*pageControl;
@end

@implementation TGFashionViewController
//-(void)setLastSelectButton:(UIButton *)lastSelectButton
//{
//    if (_lastSelectButton==lastSelectButton) {
//        _lastSelectButton.selected=NO;
//        _lastSelectButton=lastSelectButton;
//        _lastSelectButton.selected=YES;
//        
//    }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor redColor];
    self.navigationController.navigationBar.hidden=YES;
    self.dataArry=[[NSMutableArray alloc]init];
    [self creatnavgation];
    [self CreatUI];
    [self creatrefrashButton];
    _Kstr=KthisMonth;
    _offSet=0;
    
    [self addTaskWithUrl:_Kstr offSet:0];
}
-(void)creatrefrashButton{

    _refrashbutton=[UIButton buttonWithType:UIButtonTypeSystem];
    _refrashbutton.frame=CGRectMake(-60, 150, 60, 30);
    //_refrashbutton.backgroundColor=[UIColor redColor];
    [_refrashbutton setTitle:@"点击刷新" forState:UIControlStateNormal];
    [_refrashbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_refrashbutton addTarget:self action:@selector(buttonreafrashClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refrashbutton];
    _addDatabutton=[UIButton buttonWithType:UIButtonTypeSystem];
    _addDatabutton.frame=CGRectMake(self.view.frame.size.width, 150, 60, 30);
    //_addDatabutton.backgroundColor=[UIColor redColor];
    [_addDatabutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_addDatabutton setTitle:@"点击加载" forState:UIControlStateNormal];
    [_addDatabutton addTarget:self action:@selector(addDataButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addDatabutton];
}
-(void)creatnavgation
{
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width-45, 44)];
    imageview.userInteractionEnabled=YES;
    imageview.alpha=0.5;
    imageview.image=[UIImage imageNamed:@"宠物世界logo.png"];
    [self.view addSubview:imageview];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
   
    [button setBackgroundImage:[UIImage imageNamed:@"setting_1.png"] forState:UIControlStateNormal];
    button.alpha=0.3;
    button.frame=CGRectMake(self.view.frame.size.width-50, 20, 50, 45);
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)btnClick:(UIButton*)button
{
    SetingViewController*set=[[SetingViewController alloc]init];
    [self presentViewController:set animated:YES completion:nil];

}
-(void)CreatUI
{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    imageView.userInteractionEnabled=YES;
    imageView.image=[UIImage imageNamed:@"头图标题栏底.png"];
    [self.view addSubview:imageView];
    CGFloat width = imageView.frame.size.width;
    NSArray*btntitles=@[@"本月强档"];
    for (int i = 0; i < 1; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width+10, 0, width-20, 39);
//        [button setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal]; // 普通图片
//        [button setBackgroundImage:[UIImage imageNamed:selectedNames[i]] forState:UIControlStateSelected]; // 选中时图片
        [button setTitle:btntitles[i] forState:UIControlStateNormal];
        button.tag = 101+i;
        button.font=[UIFont systemFontOfSize:14];
        //button.backgroundColor=[UIColor purpleColor];
        //button.alpha=0.5;
        [button addTarget:self action:@selector(buttonClick2:)forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
        
}
//    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(width, 0, width-20, 39)];
//    view.layer.cornerRadius=10;
//    view.layer.borderColor=[[UIColor yellowColor]CGColor];
//    view.layer.borderWidth=2;
//    
//    view.alpha=0.4;
//
//    view.tag=123;
//    [imageView addSubview:view];
   
}
-(void)creatTableView
{
    //tableView
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-104-49) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"FashionCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}
-(void)creatScrollView
{
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+40, self.view.frame.size.width, self.view.frame.size.height-64-40-49)];
    self.scrollView.userInteractionEnabled=YES;
    //self.scrollView.backgroundColor=[UIColor redColor];
    

    for (NSInteger i=0; i<self.dataArry.count; i++)
    {
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, 200)];
        imageView.userInteractionEnabled=YES;
       // NSLog(@"%@",[self.dataArry[i] icon]);
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cwsjgm.cms.palmtrends.com/%@",[self.dataArry[i] icon]]]placeholderImage:[UIImage imageNamed:@"图片内文底.png"]];
        
        self.scrollView.delegate=self;
        [self.scrollView addSubview:imageView];
        UILabel*titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 180, self.scrollView.frame.size.width, 20)];
        titlelabel.backgroundColor=[UIColor blueColor];
        titlelabel.alpha=0.5;
        titlelabel.textColor=[UIColor whiteColor];
        titlelabel.text=[self.dataArry[i] title];
        [imageView addSubview:titlelabel];
        _desLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 260, self.scrollView.frame.size.width, 200)];
        _desLabel.text=[NSString stringWithFormat:@"      %@",[self.dataArry[i] des]];
        _desLabel.backgroundColor=[UIColor whiteColor];
        _desLabel.numberOfLines=0;
        [imageView addSubview:_desLabel];
        UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.frame=CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [button addTarget:self action:@selector(SvbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=[[self.dataArry[i] id] doubleValue];
        //button.backgroundColor=[UIColor blueColor];
        [imageView addSubview:button];
    }
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width*self.dataArry.count, self.scrollView.frame.size.height);
    //分页打开
    self.scrollView.pagingEnabled=YES;
    self.scrollView.bounces=NO;
    //UIpageControll
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width-120, 164+100+40, 100, 40)];
    self.pageControl.numberOfPages=self.dataArry.count;
   //self.pageControl.backgroundColor=[UIColor cyanColor];
   self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
   self.pageControl.pageIndicatorTintColor = [UIColor grayColor];

    //[self.pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
  [self.view addSubview:self.scrollView];
    [self.dataArry removeAllObjects];
}
-(void)pageControlClick:(UIPageControl*)pageControl

{
    NSInteger currentPage=pageControl.currentPage;
    [self.scrollView  setContentOffset:CGPointMake(currentPage*self.scrollView.frame.size.width, 0) animated:YES];
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
         NSLog(@"开始拖拽");
   
}
 // 滚动时调用此方法(手指离开屏幕后)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"滚动时调用此方法(手指离开屏幕后)");
}
// 完成拖拽(滚动停止时调用此方法，手指离开屏幕前)

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate

{    NSLog(@" 完成拖拽");
    


    // NSLog(@"scrollViewDidEndDragging");

   //_oldContentOffsetX = scrollView.contentOffset.x;

}
// 滑动结束，减速完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
   // _newContentOffsetX = scrollView.contentOffset.x;
    NSLog(@"滑动结束，减速完成");
    if(self.pageControl.currentPage==0){
    [UIView animateWithDuration:0.5 animations:^{

       _refrashbutton.frame=CGRectMake(0, 150, 60, 30);
        [_refrashbutton addTarget:self action:@selector(buttonreafrashClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_refrashbutton];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{

            [self performSelector:@selector(HiddenButton) withObject:nil afterDelay:1.2];

        }];
    }];
      
    }
    if (self.pageControl.currentPage==6) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _addDatabutton.frame=CGRectMake(self.view.frame.size.width-60, 150, 60, 30);
            [_addDatabutton addTarget:self action:@selector(addDataButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_addDatabutton];
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                 [self performSelector:@selector(HiddenButton2) withObject:nil afterDelay:1.2];
               
            }];
        }];

    }

    
}
-(void)HiddenButton
{
    [UIView animateWithDuration:0.5 animations:^{
        _refrashbutton.frame=CGRectMake(-60, 150, 60, 30);
        [_refrashbutton addTarget:self action:@selector(buttonreafrashClick:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
}
-(void)HiddenButton2
{
    [UIView animateWithDuration:0.5 animations:^{
        _addDatabutton.frame=CGRectMake(self.view.frame.size.width, 150, 60, 30);
        [_addDatabutton addTarget:self action:@selector(addDataButton:) forControlEvents:UIControlEventTouchUpInside];
    }];
   
}
-(void)buttonreafrashClick:(UIButton*)button
{
  //_desLabel.text=@" ";
    for (int i=0; i<7; i++) {
        [_desLabel removeFromSuperview];

    }
       _offSet=0;
    [self addTaskWithUrl:_Kstr offSet:_offSet];
}
-(void)addDataButton:(UIButton*)button
{
    _desLabel.text=@"";
    _offSet+=7;
    [self addTaskWithUrl:_Kstr offSet:_offSet];
    
 
}
-(void)buttonClick2:(UIButton*)button
{
    if (_num!=0) {
        UIButton *b =(UIButton *) [self.view viewWithTag:_num];//这是上一个button
        b.selected = NO;//把1置为No
    }
    button.selected = YES;//这是本次点击的额
    _num = button.tag;
    
//    
//    UIView *view=(UIView *)[self.view viewWithTag:123];
//    [UIView animateWithDuration:0.2 animations:^{
//        view.frame=CGRectMake(button.frame.origin.x, 0, self.view.frame.size.width, 39);
//        view.layer.cornerRadius=10;
//        view.layer.borderColor=[[UIColor yellowColor]CGColor];
//        
//        view.layer.borderWidth=2;
//        
//        view.alpha=0.4;
//    }];
//    
    switch (button.tag) {
        case 101:
        {
            NSLog(@"第一个按钮触发了");
            _Kstr=KthisMonth;
             [self addTaskWithUrl:_Kstr offSet:0];
            

        }
            break;
        
            
        default:
            break;
    }
    
  
}
-(void)addTaskWithUrl:(NSString*)url offSet:(NSInteger)offset
{
    _UrlStr=[NSString stringWithFormat:url,offset];
    [self FetchWebData:_UrlStr];
    NSLog(@"%@",_UrlStr);
}


-(void)FetchWebData:(NSString*)url
{
     [self.dataArry removeAllObjects];
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
        NSDictionary*resdict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray*arr=resdict[@"list"];
        for (NSDictionary*dic in arr)
        {
            Live4Model*model=[[Live4Model alloc]init];
            model.title=dic[@"title"];
            model.des=dic[@"des"];
            model.icon=dic[@"icon"];
            model.id=dic[@"id"];
            //model.content=dic[@"content"];
            [self.dataArry addObject:model];
            
        }
        //刷新表格
        //[self.tableView  reloadData];
        [self creatScrollView];
        //关闭特效
        [MMProgressHUD dismissWithSuccess:@"成功" title:@"加载完成"];
        
        return;
    }

    [self.dataArry removeAllObjects];    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
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
             

             NSDictionary*resdict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSArray*arr=resdict[@"list"];
             for (NSDictionary*dic in arr)
             {
                 Live4Model*model=[[Live4Model alloc]init];
                 model.title=dic[@"title"];
                 model.des=dic[@"des"];
                 model.icon=dic[@"icon"];
                 model.id=dic[@"id"];
                // model.content=dic[@"content"];
                 [self.dataArry addObject:model];
                // NSLog(@"%@",model.icon);
             }
              [self creatScrollView];
             [MMProgressHUD dismissWithSuccess:@"加载完成" title:@"OK"];

           
             //[self.tableView reloadData];
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"下载失败");
         [MMProgressHUD dismissWithError:@"加载失败" title:@"请检查网络!"];
     }];
    
}
-(void)SvbtnClick:(UIButton*)button
{
    ThisMonthSecondViewController*second=[[ThisMonthSecondViewController alloc]init];
    second.IDnumber=button.tag;
    [self presentViewController:second animated:YES completion:nil];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.dataArry.count;
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FashionCell*cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
@end
