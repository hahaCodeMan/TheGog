//
//  SetingViewController.m
//  TheGog
//
//  Created by qianfeng on 15/7/11.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "SetingViewController.h"
#import "CExpandHeader.h"
#import "FavoriteViewController.h"
#import "LZXHelper.h"
#import "SDImageCache.h"

@interface SetingViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
//    UITableView*_tableView;
//    NSMutableArray*_SetDataArray;
    CExpandHeader *_header;
}
@property(nonatomic,strong)UITableView*tableView;
//@property(nonatomic,strong)NSMutableArray*SetDataArray;
@end

@implementation SetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavgationBar];
    [self creatTableView];
}
-(void)creatNavgationBar
{
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    imageview.userInteractionEnabled=YES;
    imageview.alpha=0.5;
    imageview.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:imageview];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
   // [button setImage:[UIImage imageNamed:@"设置_1.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"返回_1.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(20, 5, 40, 35);
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:button];

    
}
-(void)creatTableView
{
    
   // self.SetDataArray=[[NSMutableArray alloc]initWithObjects:@"我的收藏", "清除缓存","联系我们",nil];
    
    UIView*hView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableHeaderView=hView;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 200)];
    imageView.image=[UIImage imageNamed:@"a20.jpg"];
    _header=[CExpandHeader expandWithScrollView:_tableView expandView:imageView];
    [self.view addSubview:self.tableView];
    
    
}
-(void)btnClick:(UIButton*)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma --<UItableViewDelegate,UITableViewDataSoucedelegate>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cellID=@"CellID";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
  
   // UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(cell.contentView.frame.size.height/2, cell.contentView.frame.size.height/4, cell.contentView.frame.size.height/2, cell.contentView.frame.size.height/2)];
    UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width+100, cell.contentView.frame.size.height)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10+cell.contentView.frame.size.height, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
    switch (indexPath.row) {
        case 0:{
            imageView.image = [UIImage imageNamed:@"上_1.png"];
            label.text = @"我的收藏";
        }
            break;
        case 1:{
            imageView.image = [UIImage imageNamed:@"上_1.png"];
            label.text = @"清除缓存";
        }
            break;
        case 2:{
            imageView.image = [UIImage imageNamed:@"上_1.png"];
            label.text = @"联系我们:909820361@qq.com";
        }
            break;
        default:
            break;
    }
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:label];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            FavoriteViewController*favrites=[[FavoriteViewController alloc]init];
            [self presentViewController:favrites animated:YES completion:nil];
            
        }
            break;
        case 1:{
            
            NSString *title = [NSString stringWithFormat:@"删除缓存文件:%.6fM",[self getCachesSize]];
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除"otherButtonTitles:nil];
            
            [sheet showInView:self.view];
 
            
            
        }
            break;
        case 2:{
           
        }
            break;
        default:
            break;
    }

}
#pragma mark - 获取缓存大小
- (double)getCachesSize {
    double sdSize = [[SDImageCache sharedImageCache] getSize];
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/MyCaches"];
    NSDirectoryEnumerator * enumerator = [[NSFileManager defaultManager] enumeratorAtPath:myCachePath];
    double mySize = 0;
    for (NSString *fileName in enumerator) {
        NSString *filePath = [myCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        mySize += dict.fileSize;
    }
    //1M = 1024k = 1024*1024Byte
    double totalSize = (mySize+sdSize)/1024/1024;//转化为M
    return totalSize;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDisk];
        
        NSString *myCachePath = [NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/MyCaches"];
        [[NSFileManager defaultManager] removeItemAtPath:myCachePath error:nil];
    }
}

@end
