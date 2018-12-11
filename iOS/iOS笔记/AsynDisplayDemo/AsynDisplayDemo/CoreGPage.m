//
//  CoreGPage.m
//  AsynDisplayDemo
//
//  Created by tree on 2018/9/14.
//  Copyright © 2018年 treee. All rights reserved.
//

#import "CoreGPage.h"
#import <CoreGraphics/CoreGraphics.h>

#define TopY self.view.layoutMargins.top
#define Width self.view.frame.size.width
@interface CoreGPage ()

@end

@implementation CoreGPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)demo1 {
    CGRect rectRange = CGRectMake(0.0, TopY, Width, self.view.frame.size.height - TopY);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
}
@end
