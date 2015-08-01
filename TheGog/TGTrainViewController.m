//
//  TGTrainViewController.m
//  TheGog
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "TGTrainViewController.h"
#import "AFNetworking.h"

#import "FashionCell.h"
#import "Live4Model.h"
#import "TrainSecondViewController.h"
#import "TrainThreeViewController.h"
#import "JHRefresh.h"
#import "MMProgressHUD.h"
#import "Define.h" 
#import "SetingViewController.h"
@interface TGTrainViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _num;
    UITableView*_tableView;
    NSMutableArray*_dataArry;
    NSString* _Kstr;
    BOOL isOne;
    NSInteger _OffSet;
    NSString*_UrlStr;
    
    
}
//@property (nonatomic, assign) UIButton *lastSelectButton;
@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadMore;
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*dataArry;
@property(nonatomic)NSInteger OffSet;
@end

@implementation TGTrainViewController
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
    
    self.dataArry=[[NSMutableArray alloc]init];
    //self.view.backgroundColor=[UIColor redColor];
    self.navigationController.navigationBar.hidden=YES;
    [self creatnavgation];
    [self CreatUI];
    isOne=YES;
    _Kstr=KzhuliuDog;
     [self addTaskWithUrl:_Kstr offSet:0];
    [self creatRefreshView];
}
-(void)creatnavgation
{
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 15, self.view.frame.size.width-45, 44)];
    imageview.userInteractionEnabled=YES;
    imageview.alpha=1;
    //imageview.backgroundColor=[UIColor blueColor];
    imageview.image=[UIImage imageNamed:@"宠物世界logo.png"];
    [self.view addSubview:imageview];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
    //[button setImage:[UIImage imageNamed:@"setting_1.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"setting_1.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"setting_1.png"] forState:UIControlStateSelected];
    
    button.alpha=0.3;
    button.frame=CGRectMake(self.view.frame.size.width-45, 23, 45, 40);
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
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 40)];
//    imageView.layer.cornerRadius=10;
//    imageView.layer.borderColor=[[UIColor yellowColor]CGColor];
//    imageView.layer.borderWidth=2;
//    

    imageView.userInteractionEnabled=YES;
    //imageView.backgroundColor=[UIColor blueColor];
    imageView.image=[UIImage imageNamed:@"头图标题栏底.png"];
    //imageView.image=[UIImage imageNamed:@"一级栏目底.png"];
    imageView.layer.cornerRadius=10;
   imageView.layer.borderWidth=0.5;
    [self.view addSubview:imageView];
    CGFloat width = imageView.frame.size.width/4.0;
    NSArray*btntitles=@[@"主流狗",@"真狗秀",@"训犬宝典",@"健康手册"];
    for (int i = 0; i < 4; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width+10, 0, width-20, 39);
        //        [button setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal]; // 普通图片
        //        [button setBackgroundImage:[UIImage imageNamed:selectedNames[i]] forState:UIControlStateSelected]; // 选中时图片
        [button setTitle:btntitles[i] forState:UIControlStateNormal];
        button.tag = 101+i;
        //button.backgroundColor=[UIColor blueColor];
        //button.alpha=0.5;
        button.font=[UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(buttonClick2:)forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
        
    }
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(10, 0, width-20, 39)];
    view.layer.cornerRadius=10;
    view.layer.borderColor=[[UIColor blueColor]CGColor];
    view.layer.borderWidth=0.5;
    
    view.alpha=0.4;
    
    view.tag=123;
    [imageView addSubview:view];
   
    //tableView
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-104-49) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"FashionCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
}

-(void)buttonClick2:(UIButton*)button
{
    
    switch (button.tag) {
        case 101:
        {
            
            [self.dataArry removeAllObjects];
            isOne=YES;
            _Kstr = KzhuliuDog;
            [self addTaskWithUrl:_Kstr offSet:0];
        }
            break;
        case 102:
        {
            [self.dataArry removeAllObjects];
            isOne=NO;
            _Kstr= Kzhengouxiu;
            [self addTaskWithUrl:_Kstr offSet:0];;
    
        }
            break;
        case 103:
        {
            [self.dataArry removeAllObjects];
            isOne=NO;
            _Kstr=KxiulianBaodain;
            [self addTaskWithUrl:_Kstr offSet:0];;
        }
            break;
        case 104:
        {
            [self.dataArry removeAllObjects];
            isOne=NO;
            _Kstr=Kjiankang;
            [self addTaskWithUrl:_Kstr offSet:0];;
        }
            break;
            
        default:
            break;
    }
    if (_num!=0) {
        UIButton *b =(UIButton *) [self.view viewWithTag:_num];//这是上一个button
        b.selected = NO;//把1置为No
    }
    button.selected = YES;//这是本次点击的额
    _num = button.tag;
    
    
    UIView *view=(UIView *)[self.view viewWithTag:123];
    [UIView animateWithDuration:0.2 animations:^{
        view.frame=CGRectMake(button.frame.origin.x, 0, self.view.frame.size.width/4-20, 39);
        view.layer.cornerRadius=10;
        view.layer.borderColor=[[UIColor blueColor]CGColor];
        
        view.layer.borderWidth=0.5;
        
        view.alpha=0.4;
          }];
    
    
}
-(void)addTaskWithUrl:(NSString*)url offSet:(NSInteger)offset
{
    _UrlStr=[NSString stringWithFormat:url,offset];
    [self FetchWebData:_UrlStr];
    NSLog(@"%@",_UrlStr);
}
-(void)FetchWebData:(NSString*)url
{     [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showDeterminateProgressWithTitle:@"请稍等" status:@"正在加载..."];
    //------------------------------------------
    
    NSString *path =[LZXHelper getFullPathWithFile:url];
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    //是否超时 一天
    BOOL isTimeout = [LZXHelper isTimeOutWithFile:url timeOut:24*60*60];
    if ((self.isRefreshing == NO)&&(isExist == YES)&&(isTimeout == NO) ) {
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
            model.content=dic[@"content"];
            [self.dataArry addObject:model];
            
        }
        //刷新表格
        [self.tableView  reloadData];
        //关闭特效
        [MMProgressHUD dismissWithSuccess:@"成功" title:@"加载完成"];
        
        return;
    }
    
    
    
    //------------------------------------------
    
   
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
             
              //[self.dataArry removeAllObjects];
             NSDictionary*resdict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSArray*arr=resdict[@"list"];
             for (NSDictionary*dic in arr)
             {
                 Live4Model*model=[[Live4Model alloc]init];
                 model.title=dic[@"title"];
                 model.des=dic[@"des"];
                 model.icon=dic[@"icon"];
                 model.id=dic[@"id"];
                 model.content=dic[@"content"];
                 [self.dataArry addObject:model];
                 
             }
             
             [self.tableView reloadData];
             [self endRefreshing];
             [MMProgressHUD dismissWithSuccess:@"加载完成" title:@"OK"];
             
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"下载失败");
         [MMProgressHUD dismissWithError:@"加载失败" title:@"请检查网络!"];
     }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArry.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FashionCell*cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Live4Model*model=self.dataArry[indexPath.row];
    [cell ShowDataWithLive:model isOne:NO];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Live4Model*model=self.dataArry[indexPath.row];
    
    if(isOne){
    TrainSecondViewController*second=[[TrainSecondViewController alloc]init];
    second.id=model.id;
    second.title=model.title;
    second.des=model.des;
    
    
    second.content=model.content;
    [self presentViewController:second animated:YES completion:nil];}
   else{
       
       TrainThreeViewController*three=[[TrainThreeViewController alloc]init];
       three.id=model.id;
       three.title=model.title;
       [self presentViewController:three animated:YES completion:nil];
       
    }
}
//刷新
- (void)creatRefreshView {
    //增加下拉刷新
    
    //下面使用block 如果内部对self 进行操作 会存在 两个强引用 这样两个对象都不会释放导致内存泄露 (或者死锁就是两个对象不释放)
    //只要出现了循环引用 必须一强一弱 这样用完之后才会释放
    //arc 用 __weak  mrc __block
    
    __weak typeof (self) weakSelf = self;//弱引用
    
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        //重新下载数据
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.isRefreshing = YES;//标记正在刷新
          weakSelf.OffSet = 0;
        
       // NSString *url = nil;
        //注意 热榜接口和其他接口不一样
//        if ([weakSelf.categoryType isEqualToString:kHotType]) {
//            
//            url = [NSString stringWithFormat:weakSelf.requestUrl,weakSelf.currentPage];
//        }else {
//            url = [NSString stringWithFormat:weakSelf.requestUrl,weakSelf.currentPage,weakSelf.categoryId];
//        }
       // url=_Kstr;
        
        [weakSelf addTaskWithUrl:_UrlStr offSet:nil];
        
    }];
    
    //上拉加载更多
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        //重新下载数据
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;//标记正在刷新
        weakSelf.OffSet +=15;//页码加1
        
       // NSString *url = nil;
        //注意 热榜接口和其他接口不一样
                
        [weakSelf addTaskWithUrl:_Kstr offSet:weakSelf.OffSet];
    }];
    
}
- (void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;//标记刷新结束
        //正在刷新 就结束刷新
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultNone];
    }
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.tableView footerEndRefreshing];
    }
}
@end
