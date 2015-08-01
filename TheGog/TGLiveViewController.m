//
//  TGLiveViewController.m
//  TheGog
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "TGLiveViewController.h"
#import "DeliciousDetailViewController.h"
#import "FashionCell.h"
#import "AFNetworking.h"
#import "Live4Model.h"
#import   "DeliciousCell.h"
#import "DeliciousModel.h"
#import "DetailLiveController.h"
//#import "MyCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#define CELL_IDENTIFIER @"WaterfallCell"
#import "Define.h" 
@interface TGLiveViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _num;
    UITableView*_tableView;
    NSMutableArray*_dataArry;
    NSString*_Kstr;
    UICollectionView*_collectionView;
    NSMutableArray* _arr1;
    NSMutableArray* _arr2;
    BOOL isOne;
    NSInteger _OffSet;
    NSString*_UrlStr;
}
@property(nonatomic,strong)UICollectionView*collectionView;
//@property (nonatomic, assign) UIButton *lastSelectButton;
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*dataArry;
@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadMore;
@property(nonatomic)NSInteger OffSet;
@end

@implementation TGLiveViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isOne=NO;
    //self.view.backgroundColor=[UIColor redColor];
    self.dataArry=[[NSMutableArray alloc]init];
    self.navigationController.navigationBar.hidden=YES;
    
    [self creatnavgation];
    [self CreatUI];
    _Kstr=Kmeiwei;
    [self addTaskWithUrl:_Kstr offSet:0];
    
    //isOne=YES;
    [self creatCollectionView];

    [self creatRefreshView];
    
    //[self FetchWebData];
}
-(void)creatnavgation
{
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width-58, 44)];
    imageview.userInteractionEnabled=YES;
    imageview.alpha=0.5;
    imageview.image=[UIImage imageNamed:@"文字底.png"];
    
    [self.view addSubview:imageview];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:@"setting_1"] forState:UIControlStateNormal];
    button.alpha=0.6;
    button.frame=CGRectMake(self.view.frame.size.width-60, 20, 60, 45);
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIButton*AddDataBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    AddDataBtn.frame=CGRectMake(150, 5, 120, 35);
    AddDataBtn.font=[UIFont systemFontOfSize:14];
    [AddDataBtn setBackgroundImage:[UIImage imageNamed:@"伯者介绍框.png"] forState:UIControlStateNormal];
    [AddDataBtn setTitle:@"更多信息" forState:UIControlStateNormal];
    [AddDataBtn addTarget:self action:@selector(addbtn:) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:AddDataBtn];
    UIButton*refreshBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    refreshBtn.frame=CGRectMake(10, 5, 120, 35);
    [refreshBtn setTitle:@"获得最新信息" forState:UIControlStateNormal];
    refreshBtn.font=[UIFont systemFontOfSize:14];
    [refreshBtn setBackgroundImage:[UIImage imageNamed:@"伯者介绍框.png"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreashbtn:) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:refreshBtn];
    
}
-(void)refreashbtn:(UIButton*)button
{
    _OffSet=0;
    [self addTaskWithUrl:_Kstr offSet:_OffSet];
}
-(void)addbtn:(UIButton*)button
{
    _OffSet+=8;
    [self addTaskWithUrl:_Kstr offSet:_OffSet];
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
    CGFloat width = imageView.frame.size.width/3.0;
    NSArray*btntitles=@[@"美味关系",@"玩转地球",@"实验室"];
    for (int i = 0; i < 3; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width+10, 0, width-20, 39);
        //        [button setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal]; // 普通图片
        //        [button setBackgroundImage:[UIImage imageNamed:selectedNames[i]] forState:UIControlStateSelected]; // 选中时图片
        button.font=[UIFont systemFontOfSize:14];
        [button setTitle:btntitles[i] forState:UIControlStateNormal];
        button.tag = 101+i;
        //button.backgroundColor=[UIColor purpleColor];
        //button.alpha=0.5;
        [button addTarget:self action:@selector(buttonClick2:)forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
        
    }
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(10, 1, width-35, 39)];
    view.layer.cornerRadius=10;
    view.layer.borderColor=[[UIColor blueColor]CGColor];
    view.layer.borderWidth=0.5;
    view.alpha=0.4;
    
    view.tag=123;
    [imageView addSubview:view];
    
    
}
-(void)creatCollectionView
{
    //布局对象
    UICollectionViewFlowLayout*flowlayout=[[UICollectionViewFlowLayout alloc]init];
    flowlayout.itemSize=CGSizeMake(self.view.frame.size.width/2.0-40, 200);
    
    flowlayout.sectionInset=UIEdgeInsetsMake(5, 5,5, 5);
    //新建collectionView,并关联布局对象
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake( 0,104,
[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-109) collectionViewLayout:flowlayout];
    
    self.collectionView.delegate=self;self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:@"DeliciousCell" bundle:nil] forCellWithReuseIdentifier:@"DeliciousCell"];

    
}
-(void)creatTableview
{
    
    //tableView
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-104-49) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"FashionCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DeliciousCell" bundle:nil] forCellReuseIdentifier:@"DeliciousCell"];
}
-(void)buttonClick2:(UIButton*)button
{
    
    switch (button.tag) {
       
        case 101:
        { [self.dataArry removeAllObjects];
            _Kstr=Kmeiwei;
            [self addTaskWithUrl:_Kstr offSet:0];
            
            //isOne=YES;
            [self creatCollectionView];

        }
            break;
        case 102:
           

        {
             [self.dataArry removeAllObjects];
            
            _Kstr=Kwanzhuan;
            [self addTaskWithUrl:_Kstr offSet:0];
            [self creatTableview];
            [self creatRefreshView];
        }
            break;
        case 103:
        {
             [self.dataArry removeAllObjects];
             [self creatTableview];
            _Kstr=KShiyansi;
             [self creatRefreshView];
            [self addTaskWithUrl:_Kstr offSet:0];
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
        view.frame=CGRectMake(button.frame.origin.x+10, 1, self.view.frame.size.width/3-35, 39);
        view.layer.cornerRadius=10;
        view.layer.borderColor=[[UIColor blueColor]CGColor];
        view.layer.borderWidth=0.5;

        
        view.alpha=0.4;
    }];
    
    
}
-(void)FetchDeliciousData:(NSString*)url
{   //[self creatTableview];
    //[self.dataArry removeAllObjects];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showDeterminateProgressWithTitle:@"请稍等" status:@"正在加载..."];
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"下载成功");
         if (responseObject) {
             
             NSDictionary*resdict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
             NSArray*arr=resdict[@"list"];
             for (NSDictionary*dic in arr) {
//            DeliciousModel*model=[[DeliciousModel alloc]init];
//                [model setValuesForKeysWithDictionary:dic];
//               [self.dataArry addObject:model];
        //DeliciousModel*model=[[DeliciousModel alloc]init];
                 Live4Model*model=[[Live4Model alloc]init];
                 model.title=dic[@"title"];
                
                 model.icon=dic[@"icon"];
                 
                 model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];
                 
                 NSLog(@"呵呵%@",model.gid);

                 [self.dataArry addObject:model];
                 
             }
   [self.collectionView reloadData];
    [MMProgressHUD dismissWithSuccess:@"成功" title:@"加载完成"];
             
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"下载失败");
         [MMProgressHUD dismissWithError:@"加载失败" title:@"请检查网络!"];
    

         
     }];
   
}
-(void)addTaskWithUrl:(NSString*)url offSet:(NSInteger)offset
{
    _UrlStr=[NSString stringWithFormat:url,offset];
    
    if ([url isEqual:Kmeiwei]) {
        [self FetchDeliciousData:_UrlStr];
    }else
    {
        [self FetchWebData:_UrlStr];
    }
    NSLog(@"%@",_UrlStr);
}

-(void)FetchWebData:(NSString*)url
{
    
   // [self.dataArry removeAllObjects];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
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
        [MMProgressHUD dismissWithSuccess:@"成功" title:@"本地数据下载完成"];
        
        return;
    }
    

    
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"下载成功");
        if (responseObject)
        {
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
    if (isOne==YES) {
        FashionCell*cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        Live4Model*model=self.dataArry[indexPath.row];
        [cell ShowDataWithLive:model isOne:YES];
        return cell;

    }
    else{
       FashionCell*cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Live4Model*model=self.dataArry[indexPath.row];
    [cell ShowDataWithLive:model isOne:NO];
    return cell;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailLiveController*detail=[[DetailLiveController alloc]init];
    //detail.hidesBottomBarWhenPushed=YES;
    Live4Model*model=self.dataArry[indexPath.row];
       detail.id=model.id;
    detail.title=model.title;
    detail.des=model.des;
    detail.icon=model.icon;
    NSLog(@"______%@",model.id);
    
    [self presentViewController:detail animated:YES completion:nil];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArry.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DeliciousCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"DeliciousCell" forIndexPath:indexPath];
  Live4Model*model=self.dataArry[indexPath.row];
    [cell ShowDataWithDelicious:model];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(170, 200);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DeliciousDetailViewController*DelDetal=[[DeliciousDetailViewController alloc]init];
   Live4Model*model=self.dataArry[indexPath.row];
    
    DelDetal.gid=model.gid;
    NSLog(@"++++%@",model.title);
     NSLog(@"看卡%@",model.gid);
    NSLog(@"gundan:%@",DelDetal.gid);
    [self presentViewController:DelDetal animated:YES completion:nil];
    
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
        weakSelf.OffSet +=8;//页码加1
        
        
        
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
