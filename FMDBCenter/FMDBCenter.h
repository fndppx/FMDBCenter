//
//  FMDBCenter.h
//  FMDBCenter
//
//  Created by k12 on 2018/4/2.
//  Copyright © 2018年 k12. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DBModel;
@interface FMDBCenter : NSObject
+ (instancetype)instance;
- (void)instertDataModel:(DBModel*)model;
- (void)deleteDataWithUserId:(NSString*)userID;
- (NSArray<DBModel *> *)fetchDBModelsWithUserID:(NSString*)userID;
- (NSArray<DBModel *> *)fetchDBModelsAll;
- (void)updateDBModelName:(NSString*)name userID:(NSString*)userID;
@end
