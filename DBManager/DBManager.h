
#import <Foundation/Foundation.h>
/*
 数据管理
 按照单例设计模式 进行 设计
 存储 收藏/下载/浏览记录
 //增删改查数据
 */

#import "FMDatabase.h"
#import "ArticleModel.h"

@interface DBManager : NSObject
//非标准单例
+ (DBManager *)sharedManager;
- (BOOL)add:(ArticleModel*)model;
- (BOOL)delete:(ArticleModel*)model;
- (BOOL)deleteById:(NSString*)articleId ;
- (BOOL)update:(ArticleModel*)model;
- (BOOL)updateById:(NSString*)articleId;
-(BOOL)add:(NSString*)articleName articleId:(NSString*)articleId des:(NSString*)des icon:(NSString*)icon;
//-(BOOL)add:(NSString*)articleName articleId:(NSString*)articleId ;
-(NSMutableArray*)selectAll;
- (BOOL)isExistArticleModelWithPid:(NSString *)pid;
@end


