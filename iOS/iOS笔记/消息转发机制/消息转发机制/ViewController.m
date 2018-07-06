//
//  ViewController.m
//  消息转发机制
//
//  Created by tree on 2018/5/8.
//  Copyright © 2018年 treee. All rights reserved.
//

#import "ViewController.h"
#import "EOCAutoDictionaryObject.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    EOCAutoDictionaryObject *obj = [EOCAutoDictionaryObject new];
    obj.number = @1;
    NSLog(@"%@", [obj.number stringValue]);
    NSLog(@"%@", obj.data);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
