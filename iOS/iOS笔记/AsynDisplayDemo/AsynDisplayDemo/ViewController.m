//
//  ViewController.m
//  AsynDisplayDemo
//
//  Created by tree on 2018/3/16.
//  Copyright © 2018年 treee. All rights reserved.
//

#import "ViewController.h"

/**
 异步实现方式： Runloop/开线程
 
 开线程：
     dispatch_queue_t queue;
     dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, 0);
     queue = dispatch_queue_create("com.treee.render", attr);
 使用Runloop：
 
 */
@interface ViewController ()

@end



@implementation ViewController
static void YYRunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    NSLog(@"shishi");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"异步绘制";
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIView *a = [UIView new];
    a.frame = CGRectMake(0.0, 100.0, 100.0, 100.0);
    a.backgroundColor = [UIColor redColor];
    [self.view addSubview:a];
    
    UIView *content = [UIView new];
    content.backgroundColor = [UIColor whiteColor];
    content.frame = CGRectMake(0.0, 200.0, 320.0, 480.0);
    [self.view addSubview:content];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
