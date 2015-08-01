//
//  TGPhotoViewController.m
//  TheGog
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "TGPhotoViewController.h"
#import "Live4Model.h"
#import "AFNetworking.h"
#import "PhotoCell.h"
#import "Define.h"
@interface TGPhotoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView*_tableView;
    NSMutableArray*_dataArry;
    NSString* _UrlStr;
    NSString* _Kstr;
    
}
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*dataArry;
@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadMore;
@property(nonatomic)NSInteger OffSet;
@end

@implementation TGPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    //self.view.backgroundColor=[UIColor cyanColor];
    [self creatnavgation];
    _Kstr=KPhotoDog;
    [self addTaskWithUrl:_Kstr offSet:0];
    [self createTableView];
    [self creatRefreshView];
    
}
-(void)creatnavgation
{
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width-45, 44)];
    imageview.userInteractionEnabled=YES;
    imageview.alpha=0.5;
    imageview.image=[UIImage imageNamed:@"宠物世界logo.png"];
    //imageview.backgroundColor=[UIColor blueColor];
    [self.view addSubview:imageview];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
    //[button setImage:[UIImage imageNamed:@"setting_1.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"setting_1.png"] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor cyanColor]];
    button.alpha=0.3;
    button.frame=CGRectMake(self.view.frame.size.width-45, 20, 45, 40);
    [button addTarget:self action:@selector(BackbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
//    UIButton*leftbutton=[UIButton buttonWithType:UIButtonTypeSystem];
//    [leftbutton setImage:[UIImage imageNamed:@"设置_1.png"] forState:UIControlStateNormal];
//    leftbutton.frame=CGRectMake(20, 5, 40, 35);
//    [leftbutton addTarget:self action:@selector(photoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //[imageview addSubview:leftbutton];
}
-(void)createTableView
{    self.dataArry=[[NSMutableArray alloc]init];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellReuseIdentifier:@"PhotoCell"];
}
-(void)BackbtnClick:(UIButton*)button
{
    SetingViewController*set=[[SetingViewController alloc]init];
    [self presentViewController:set animated:YES completion:nil];
    

}
//-(void)photoBtnClick:(UIButton*)button
//{
//    
//}
-(void)addTaskWithUrl:(NSString*)url offSet:(NSInteger)offset
{
    _UrlStr=[NSString stringWithFormat:url,offset];
    [self FetchWebData:_UrlStr];
    NSLog(@"%@",_UrlStr);
}
-(void)FetchWebData:(NSString*)url
{
    [self.dataArry removeAllObjects];
    //[self.dataArry removeAllObjects];
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showDeterminateProgressWithTitle:@"当前网速较慢,请稍等!" status:@"正在加载..."];
    //------------------------------------------
    
//    NSString *path =[LZXHelper getFullPathWithFile:url];
//    
//    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
//    //是否超时 一天
//    BOOL isTimeout = [LZXHelper isTimeOutWithFile:url timeOut:24*60*60];
//    if ((self.isRefreshing == NO)&&(isExist == YES)&&(isTimeout == NO) ) {
//        //同时成立
//        //走本地缓存数据
//        NSData *data = [NSData dataWithContentsOfFile:[LZXHelper getFullPathWithFile:url]];
//        //解析二进制数据
//        //        if (self.OffSet == 0) {
//        //            [self.dataArr removeAllObjects];
//        //        }
//        NSDictionary*resdict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSArray*arr=resdict[@"list"];
//        for (NSDictionary*dic in arr)
//        {
//            Live4Model*model=[[Live4Model alloc]init];
//            model.title=dic[@"title"];
//            model.des=dic[@"des"];
//            model.icon=dic[@"icon"];
//            model.id=dic[@"id"];
//            model.content=dic[@"content"];
//            [self.dataArry addObject:model];
//            
//        }
//        //刷新表格
//        [self.tableView  reloadData];
//        //关闭特效
//        [MMProgressHUD dismissWithSuccess:@"成功" title:@"本地数据下载完成"];
//        
//        return;
//    }
//    

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
             

             NSDictionary*resdict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSArray*arr=resdict[@"list"];
             for (NSDictionary*dic in arr)
             {
                 Live4Model*model=[[Live4Model alloc]init];
                 model.title=dic[@"title"];
                 model.des=dic[@"des"];
                 model.icon=dic[@"icon"];
                 model.topcount=dic[@"topcount"];
                 model.zipaicount=dic[@"zipaicount"];
                 model.face=dic[@"face"];
                 model.adddate=dic[@"adddate"];
                // model.width=[dic[@"width"] floatValue ];
                // model.height=[dic[@"height"] floatValue];
                 model.id=dic[@"id"];
                 model.timestamp=dic[@"timestamp"];
                 
                 [self.dataArry addObject:model];
                 NSLog(@"%@",model.icon);
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
    PhotoCell*cell=[tableView dequeueReusableCellWithIdentifier:@"PhotoCell" forIndexPath:indexPath];
    Live4Model*model=self.dataArry[indexPath.row];
   [cell ShowDataWithPhoto:model];
    return cell;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 340;
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
        weakSelf.OffSet +=2;//页码加1
        
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
