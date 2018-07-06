//
//  SharedProviderTool.h
//  ShareExtension
//
//  Created by tree on 2018/6/27.
//  Copyright © 2018年 treee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SharedProviderTool : NSObject
- (void)open:(nullable NSURL *)url from:(nonnull UIViewController *)controller;
@end
