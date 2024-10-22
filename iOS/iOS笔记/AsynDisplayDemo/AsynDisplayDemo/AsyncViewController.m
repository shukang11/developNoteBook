//
//  AsyncViewController.m
//  AsynDisplayDemo
//
//  Created by tree on 2018/9/14.
//  Copyright © 2018年 treee. All rights reserved.
//

#import "AsyncViewController.h"
/**
 异步实现方式： Runloop/开线程
 
 开线程：
 dispatch_queue_t queue;
 dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, 0);
 queue = dispatch_queue_create("com.treee.render", attr);
 使用Runloop：
 
 */
#import "SxrLabel.h"
@interface AsyncViewController ()

@end

@implementation AsyncViewController
static void YYRunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    NSLog(@"shishi");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"异步绘制";
    UIView *a = [UIView new];
    a.frame = CGRectMake(0.0, 100.0, 100.0, 100.0);
    a.backgroundColor = [UIColor redColor];
    [self.view addSubview:a];
    
    UIView *content = [UIView new];
    content.backgroundColor = [UIColor whiteColor];
    content.frame = CGRectMake(0.0, 200.0, 320.0, 480.0);
    [self.view addSubview:content];
    
    SxrLabel *label = [SxrLabel new];
    label.text = @"hi";
    label.font = [UIFont boldSystemFontOfSize:34];
    label.backgroundColor = [UIColor grayColor];
    label.frame = CGRectMake(100.0, 100.0, 100.0, 100.0);
    [self.view addSubview:label];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
