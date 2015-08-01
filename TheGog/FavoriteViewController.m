//
//  FavoriteViewController.m
//  TheGog
//
//  Created by qianfeng on 15/7/11.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "FavoriteViewController.h"
#import "FashionCell.h"
#import "ArticleModel.h"
#import "DBManager.h"
#import "FavoriteDetailViewController.h"
#define kScreen [UIScreen mainScreen].bounds.size

@interface FavoriteViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *_emptyPageLabel;
    NSIndexPath *_indexPath;
    NSMutableArray *_deleteArr;
    UITableView* _tableView;
    NSMutableArray*_dataArray;
   
}
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavgationBar];
    [self creatUI];
    [self createtable];
    //[self createDeleteButton];
    
}
-(void)creatNavgationBar
{
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    imageview.userInteractionEnabled=YES;
    imageview.alpha=0.5;
    imageview.backgroundColor=[UIColor blueColor];
    [self.view addSubview:imageview];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:@"返回_1.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(20, 5, 40, 35);
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:button];
    //取消收藏的 button
    UIButton*editButton= [UIButton buttonWithType:UIButtonTypeSystem];
    editButton.frame=CGRectMake(kScreen.width-65, 5, 65, 29);
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editButton setTitle:@"编辑中" forState:UIControlStateDisabled];
    [editButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [editButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:editButton];
}
-(void)btnClick:(UIButton*)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)creatUI
{
    _deleteArr=[[NSMutableArray alloc]init];
    self.dataArray=[NSMutableArray array];
   
    [self.dataArray addObjectsFromArray:[[DBManager sharedManager]selectAll]];
   
}
-(void)createtable
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=98;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"FashionCell" bundle:nil] forCellReuseIdentifier:@"FashionCell"];
    if (self.dataArray.count==0) {
        [self setemptyPage];
    }
    }
-(void)setemptyPage
{
    self.tableView.hidden=YES;
    _emptyPageLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, kScreen.width, 200)];
    _emptyPageLabel.text=@"暂无收藏的数据";
    _emptyPageLabel.numberOfLines=0;
    _emptyPageLabel.textAlignment=NSTextAlignmentCenter;
    _emptyPageLabel.font=[UIFont fontWithName:@"Courier" size:20];
    _emptyPageLabel.textColor=[UIColor lightGrayColor];
    _emptyPageLabel.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:_emptyPageLabel];
    
}
-(void)editButtonClick:(UIButton*)button
{
    [self setEditing:YES animated:YES];
    [self createDeleteButton];
}
#pragma ---<UITableViewDelegate,UITableViewdatasoucedelegate>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _indexPath=indexPath;
    FashionCell*cell;
    if (self.dataArray.count==0) {
        
         [self setemptyPage];
    }
    else
         {
            cell=[tableView dequeueReusableCellWithIdentifier:@"FashionCell" forIndexPath:indexPath];
             ArticleModel*model=self.dataArray[indexPath.row];
             [cell ShowDataWithFavrite:model Indexpath:indexPath isOne:NO];
//              UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width+100, cell.contentView.frame.size.height)];
//             [cell.contentView addSubview:imageView];
 
         }
    if (self.dataArray.count==0) {
        [self setemptyPage];
    }
        return cell;
}
#pragma mark- Tableview的编辑状态
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (self.tableView.editing&&self.tableView.tableFooterView==nil)
    {
    
        [self createDeleteButton];
    }
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}
#pragma mark -TableView的多选删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleInsert| UITableViewCellEditingStyleDelete ;
}
//选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    ArticleModel*model=self.dataArray[indexPath.row];
    if (self.tableView.editing) {
        
    
    if (![_deleteArr containsObject:model])
    {
        [_deleteArr addObject:model];
    }
    }
    else{
        
        FavoriteDetailViewController*detail=[[FavoriteDetailViewController alloc]init];
        
        detail.id=model.id;
        [self presentViewController:detail animated:YES completion:nil];
        
    }
}
//取消选中cell

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleModel*model=self.dataArray[indexPath.row];
    if ([_deleteArr containsObject:model]) {
        [_deleteArr removeObject:model];
    }
    self.tableView.tableFooterView=nil;
}
#pragma -->删除按钮
 -(void)createDeleteButton
   {
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(0, 0, self.view.frame.size.width, 30);
    [button setTitle:@"删除" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor=[UIColor orangeColor];
    self.tableView.tableFooterView=button;
}
- (void)deleteBtnClick:(UIButton*)button
{
    [self.dataArray removeObjectsInArray:_deleteArr];
     [self.tableView  reloadData];
    if (self.dataArray.count==0)
    {
        [self setemptyPage];
    }
    for (ArticleModel* model in _deleteArr)
    {
        [[DBManager sharedManager]delete:model];
    }
    [_deleteArr removeAllObjects];
    
}

@end
