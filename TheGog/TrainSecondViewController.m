//
//  TrainSecondViewController.m
//  TheGog
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "TrainSecondViewController.h"
#import "AFNetworking.h"
#import "ZLGModel.h"
#import "Live4Model.h"
#import "TrainThreeViewController.h"

@interface TrainSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITextView*_textView;
    UITableView*_tableView;
    NSMutableArray*_dataArray;
    
}
@property(nonatomic,strong)UITextView*textView;
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@end

@implementation TrainSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavgationBar];
    [self creatUI];
    [self getDataWithTableView ];
    
}
-(void)creatNavgationBar
{
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    imageview.userInteractionEnabled=YES;
    imageview.alpha=0.5;
    imageview.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:imageview];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
    //[button setImage:[UIImage imageNamed:@"设置_1.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"返回_1.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(20, 5, 40, 35);
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:button];

}
-(void)creatUI
{  //self.dataArray=[[NSMutableArray alloc]initWithObjects:@"这样真的好吗感觉不是太好,怎额马上就会对你说地方 科鲁兹;是否合理控制撒娇电话不上课;",@"这样真的好吗感觉不是太好,怎额马上就会对你说地方 科鲁兹;是否合理控制撒娇电话不上课;",@"这样真的好吗感觉不是太好,怎额马上就会对你说地方 科鲁兹;是否合理控制撒娇电话不上课;", nil];
    UILabel*titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    titlelabel.textAlignment=NSTextAlignmentCenter;
    titlelabel.text=self.title;
    [self.view addSubview:titlelabel];
    UILabel*deslabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+40, self.view.frame.size.width, 40)];
    deslabel.text=self.des;
    [self.view addSubview:deslabel];
    
    //数组初始化
    self.dataArray=[[NSMutableArray alloc]init];
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 64+80, self.view.frame.size.width, 100)];
    //self.textView.backgroundColor=[UIColor redColor];
    self.textView.editable=NO;
    self.textView.text=self.content;
    
    [self.view addSubview:self.textView];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+80+100, self.view.frame.size.width, self.view.frame.size.height-164-100) style:UITableViewStylePlain];
   self.tableView.scrollEnabled =NO;
    //设置tableview 不能滚动
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
    
}
-(void)getDataWithTableView
{   [self.dataArray removeAllObjects];
    NSString*str1=@"http://cwsjgm.cms.palmtrends.com/api_v2.php?action=cover&id=";
    NSString*urlstr=[str1 stringByAppendingString:[NSString stringWithFormat:@"%@&sa=zhuliugoulist&offset=0&count=15&uid=13654938&platform=a&mobile=Coolpad+8297W&pid=10089&e=b5b2f484359604eb5d65c75b8114a85d",self.id ]];
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        if (responseObject)
        {
            NSDictionary*resdic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray*arr=resdic[@"list"];
            for(NSDictionary*dic in arr)
           {   ZLGModel*model=[[ZLGModel alloc]init];
               
                              model.id=dic[@"id"];
                model.title=dic[@"title"];
                [self.dataArray addObject:model];
                
            }
          
             
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
    }];

}
-(void)btnClick:(UIButton*)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
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
   static  NSString*cellID=@"CellID";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
        //左方箭头
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, cell.contentView.frame.size.height-5, cell.contentView.frame.size.width, 5)];
        label.font=[UIFont systemFontOfSize:6];
    label.text=@"................................................................................................................................................................................................................................................................................................................";
        label.textColor=[UIColor redColor];
        //label.backgroundColor=[UIColor blueColor];
        
        
        //cell.textLabel.frame=CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
        [cell.contentView addSubview:label];
    }
   ZLGModel*model=self.dataArray[indexPath.row];
    //cell.textLabel.text=@"这样真的好吗感觉不是太好,怎额马上就会对你说地方 科鲁兹;是否合理控制撒娇电话不上课; ";
    UILabel*label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, 40)];
    //label2.backgroundColor=[UIColor blueColor];
    [cell.contentView addSubview:label2];
    label2.textAlignment=NSTextAlignmentCenter;
   
    label2.text=model.title;
    
    return cell;
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   ZLGModel*model=self.dataArray[indexPath.row];
    TrainThreeViewController*three=[[TrainThreeViewController alloc]init];
    three.id=model.id;
    three.title=model.title;
    
    
    [self presentViewController:three animated:YES completion:nil];
    
    
}
@end
