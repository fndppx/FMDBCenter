//
//  DBModel.h
//  FMDBCenter
//
//  Created by k12 on 2018/4/2.
//  Copyright © 2018年 k12. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBModel : NSObject
@property (nonatomic,copy)NSString * userID;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * sex;
@property (nonatomic,assign)NSInteger age;

@end
