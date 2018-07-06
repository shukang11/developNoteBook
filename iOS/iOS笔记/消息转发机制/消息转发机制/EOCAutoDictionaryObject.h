//
//  EOCAutoDictionaryObject.h
//  消息转发机制
//
//  Created by tree on 2018/5/8.
//  Copyright © 2018年 treee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCAutoDictionaryObject : NSObject

@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) id opaqueObject;
@end
