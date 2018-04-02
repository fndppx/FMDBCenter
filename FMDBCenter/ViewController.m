//
//  ViewController.m
//  FMDBCenter
//
//  Created by k12 on 2018/4/2.
//  Copyright © 2018年 k12. All rights reserved.
//

#import "ViewController.h"
#import "FMDBCenter.h"
#import "DBModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[FMDBCenter instance]fetchDBModelsAll];
    
    DBModel * model = [DBModel new];
    model.userID = @"1";
    model.age = 18;
    model.name = @"测试";
    model.sex = @"男";

    [[FMDBCenter instance]instertDataModel:model];
    
//    [[FMDBCenter instance]deleteDataWithUserId:@"1"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
