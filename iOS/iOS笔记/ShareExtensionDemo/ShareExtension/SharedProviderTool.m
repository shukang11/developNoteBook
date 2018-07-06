//
//  SharedProviderTool.m
//  ShareExtension
//
//  Created by tree on 2018/6/27.
//  Copyright © 2018年 treee. All rights reserved.
//

#import "SharedProviderTool.h"
#import <MobileCoreServices/MobileCoreServices.h>
@implementation SharedProviderTool

- (void)open:(NSURL *)url from:(UIViewController *)controller {
    if (!url) return;
    UIResponder *responder = controller;
    while (responder)
    {
        if ([responder respondsToSelector:@selector(openURL:)])
        {
            [responder performSelector:@selector(openURL:) withObject:url];
            break;
        }
        responder = [responder nextResponder];
    }
    
}
@end
