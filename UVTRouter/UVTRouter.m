//
//  UVTRouter.m
//  UVTRouter
//
//  Created by viktyz on 2017/7/13.
//  Copyright © 2017年 UVT. All rights reserved.
//

#import "UVTRouter.h"
#import <objc/message.h>

NSString *const UVTRouterParameterCompletion = @"UVTRouterParameterCompletion";

@interface UVTRouter()

@property (nonatomic, strong) NSMutableDictionary *routerMap;

@end

@implementation UVTRouter

+ (instancetype)sharedInstance
{
    static UVTRouter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (id)openURL:(NSString *)URL
{
    return [self openURL:URL completion:nil];
}

+ (id)openURL:(NSString *)URL completion:(void (^)(id result))completion
{
    return [self openURL:URL withUserInfo:nil completion:completion];
}

+ (id)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion
{
    NSURL *mURL = [NSURL URLWithString:URL];
    
    NSString *scheme = mURL.scheme;
    
    if (!scheme || scheme.length == 0) {
        NSLog(@"Please input valid scheme name");
        return nil;
    }
    
    NSString *host = mURL.host;
    
    if (!host || host.length == 0) {
        NSLog(@"Please input valid class name");
        return nil;
    }
    
    NSString *path = [[mURL.path stringByReplacingOccurrencesOfString:@"/" withString:@""] stringByAppendingString:@":"];
    
    if (!path || path.length == 0) {
        NSLog(@"Please input valid method name");
        return nil;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[[self sharedInstance] parseQuery:mURL.query]];
    
    if (completion) {
        parameters[UVTRouterParameterCompletion] = completion;
    }
    if (userInfo) {
        [parameters addEntriesFromDictionary:userInfo];
    }
    
    if ([scheme isEqualToString:@"router"]) {
        return [self callIn:host withMethod:path withParameters:parameters];
    }
    else if([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) {
        //Jump to Web
        NSLog(@"Jump to Web : %@",URL);
        return nil;
    }
    else{
        NSLog(@"UVTRouter not match : %@",scheme);
    }
    
    return nil;
}

+ (id)callIn:(NSString *)class withMethod:(NSString *)method  withParameters:(NSDictionary *)parameters
{
    return ((id (*)(id, SEL, NSDictionary *))(void *)objc_msgSend)([NSClassFromString(class) alloc],NSSelectorFromString(method),parameters);
}

+ (BOOL)canOpenURL:(NSString *)URL
{
    return YES;
    //    return [[self sharedInstance] extractParametersFromURL:URL] ? YES : NO;
}

#pragma mark - Utils

- (NSDictionary *)parseQuery:(NSString *)query
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (query) {
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        for (NSString *pair in pairs) {
            NSArray *kv = [pair componentsSeparatedByString:@"="];
            NSString *key = [kv.firstObject stringByRemovingPercentEncoding];
            NSString *value = [kv.lastObject stringByRemovingPercentEncoding];
            
            [dict setObject:value forKey:key];
        }
    }
    
    return [dict copy];
}
@end
