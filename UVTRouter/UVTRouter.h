//
//  UVTRouter.h
//  UVTRouter
//
//  Created by viktyz on 2017/7/13.
//  Copyright © 2017年 UVT. All rights reserved.
//

#import <Foundation/Foundation.h>

// URL 格式: scheme://target/action(/type?key1=value1&key2=value2&...)

// router 方法:
// 作用 - 用于调用类方法，也用于获取类实例
// 规则 - router://classname/method(?key1=value1&key2=value2&...)
// 说明 - key1,key2,... 等为目标 class 对应 Action 扩展的字典参数

extern NSString *const UVTRouterParameterCompletion;

@interface UVTRouter : NSObject

+ (id)openURL:(NSString *)URL;
+ (id)openURL:(NSString *)URL completion:(void (^)(id result))completion;
+ (id)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion;

@end
