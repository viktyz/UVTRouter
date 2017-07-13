//
//  UVTRouter.h
//  UVTRouter
//
//  Created by viktyz on 2017/7/13.
//  Copyright © 2017年 UVT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UVTViewController.h"

extern NSString *const UVTRouterParameterCompletion;

@interface UVTRouter : NSObject

+ (id)openURL:(NSString *)URL;
+ (id)openURL:(NSString *)URL completion:(void (^)(id result))completion;
+ (id)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion;

@end
