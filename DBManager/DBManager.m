//
//  DBManager.m
//  LimitFreeProject
//


#import "DBManager.h"
#import "ArticleModel.h"

//NSString * const kLZXFavorite = @"favorites";
//NSString * const kLZXDownloads = @"downloads";
//NSString * const kLZXBrowses = @"browese";
//
/*
 数据库
 1.导入 libsqlite3.dylib
 2.导入 fmdb
 3.导入头文件
 fmdb 是对底层C语言的sqlite3的封装
 
 */
@implementation DBManager
{
    //数据库对象
    FMDatabase *_database;
}
//非标准单例
+ (DBManager *)sharedManager {
    static DBManager *manager = nil;
    @synchronized(self) {//同步 执行 防止多线程操作
        if (manager == nil) {
            manager = [[self alloc] init];
        }
    }
    return manager;
}
- (id)init {
    if (self = [super init])
    {
        //1.获取数据库文件app.db的路径
        NSString *filePath =
        [self getFileFullPathWithFileName:@"articleModel.db"];
        //2.创建database
        _database =
        [[FMDatabase alloc] initWithPath:filePath];
        //3.open
        //第一次 数据库文件如果不存在那么 会创建并且打开
        //如果存在 那么直接打开
        if ([_database open])
        {
            NSLog(@"数据库打开成功");
            //创建表 不存在 则创建
            [self creatTable];
        }else
        {
            NSLog(@"database open failed:%@",_database.lastErrorMessage);
        }
    }
    return self;
}
#pragma mark - 创建表
- (void)creatTable {
    
    //字段:title ,id,des,content,icon,adddate,
    NSString *sql1=@"create table if not exists ArticleModel (serial integer Primary Key Autoincrement, articeName Varchar(2048), articleId varchar(1024),des Varchar(10240),content Varchar(10240),icon Varchar(1024),adddate Varchar(1024))";
    //NSString*sql2=@"create table if not exists ArticleModel2 (serial integer Primary Key Autoincrement, articeName Varchar(2048), articleId varchar(1024))";
    //创建表 如果不存在就创建新的表
    BOOL isSuccess1=[_database executeUpdate:sql1];
   // BOOL isSuccess2=[_database executeUpdate:sql2];
    if (!isSuccess1)
    {
        NSLog(@"creatTable error:%@",_database.lastErrorMessage);
    }
//    BOOL isSuccess2=[_database executeUpdate:sql2];
//    if (!isSuccess2)
//    {
//        NSLog(@"creatTable error:%@",_database.lastErrorMessage);
//    }

}
#pragma mark - 获取文件的全路径

//获取文件在沙盒中的 Documents中的路径
- (NSString *)getFileFullPathWithFileName:(NSString *)fileName
{
    NSString *docPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:docPath])
    {
        
        //文件的全路径
        return [docPath stringByAppendingFormat:@"/%@",fileName];
       
    }else
    {
        //如果不存在可以创建一个新的
        NSLog(@"Documents不存在");
        return nil;
    }
}

- (BOOL)add:(ArticleModel *)model
{
    if (![_database open])
    {
        
        return NO;
    }
    NSString *sql = @"insert into ArticleModel  values(?,?,?,?,?,?)";
    BOOL success = [_database executeUpdate:sql,model.title,
                    model.id,
                    model.des,
                    model.content,
                    model.icon,
                    model.adddate];                
                   
    if (success)
    {
        NSLog(@"成功插入一条数据");
    }
    [_database close];
    return success;
}
-(BOOL)add:(NSString*)articleName articleId:(NSString*)articleId des:(NSString*)des icon:(NSString*)icon 
{
    if (![_database open]) {
        
        NSLog(@"数据库又问了");
        return NO;
    }
    NSString *sql = @"insert into ArticleModel (articeName,articleId,des,icon) values(?,?,?,?)";
    BOOL success = [_database executeUpdate:sql,articleName,articleId,des,icon];
    
    if (success)
    {
        NSLog(@"成功插入一条数据");
    }
    [_database close];
    return success;
}
- (BOOL)delete:(ArticleModel *)model
{
    return [self deleteById:model.id];
}
-(BOOL)deleteById:(NSString *)articleId
{
    if (![_database open]) {
        return NO;
    }
    NSString *sql=@"delete from ArticleModel where articleId=?";
//    BOOL success=[_database executeUpdate:sql,
//                  model.title,
//                  model.id,
//                  model.des,
//                  model.content,
//                  model.icon,
//                  model.adddate,
//                  ];
    
    BOOL success=[_database executeUpdate:sql,articleId];
    [_database close];
    
    
    return success;
    
}
-(BOOL)update:(ArticleModel *)model
{
    if (![_database open])
    {
        return NO;
    }
    NSString*sql=@"update ArticleModel set articeName=?, des=?,content=?,icon =?,adddate=?, where articleId=?";

    BOOL success =[_database executeUpdate:sql,model.title,model.id,model.des,
                   model.content, model.icon,model.adddate];
    
    [_database close];
    return success;

}
-(BOOL)updateById:(NSString *)articleId
{
    return YES;
}
-(NSMutableArray*)selectAll
{
    if (![_database open]) {
        return nil;
    }
    NSString *sql=@"select* from ArticleModel";
    FMResultSet *set =[_database executeQuery:sql];
    NSMutableArray*array=[NSMutableArray array];
    while ([set next]) {
        ArticleModel*articleModel=[[ArticleModel alloc]init];
        
        articleModel.title=[set stringForColumn:@"articeName"];
        articleModel.id=[set stringForColumn:@"articleId"];
        articleModel.des=[set stringForColumn:@"des"];
        articleModel.content=[set stringForColumn:@"content"];
        articleModel.icon=[set stringForColumn:@"icon"];
        articleModel.adddate=[set stringForColumn:@"adddate"];
        [array addObject:articleModel];
    }
    
    return array;

}
-(BOOL)isExistArticleModelWithPid:(NSString *)pid
{
    NSString*sql=@"select * from ArticleModel where articleId=? ";
    FMResultSet *rs=[_database executeQuery:sql,pid];
    if ([rs next])
    {   //查看是否存在 下条记录 如果存在 肯定 数据库中有记录
        return YES;
    }else
    {
        return NO;
    }
    
}

@end
