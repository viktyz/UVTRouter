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
    
    id instance = nil;
    
    if ([scheme isEqualToString:@"router"]) {
        instance = [self callIn:host withMethod:path withParameters:parameters];
    }
    
    if (!instance) {
        instance = [self openEmpty:@"UVTEmptyViewController" withMethod:@"initWithURL:" withFullURL:[URL stringByAppendingString:[[self sharedInstance] crateQuery:userInfo]]];
    }
    
    return instance;
}

+ (id)callIn:(NSString *)class withMethod:(NSString *)method withParameters:(NSDictionary *)parameters
{
    return ((id (*)(id, SEL, NSDictionary *))(void *)objc_msgSend)([NSClassFromString(class) alloc],NSSelectorFromString(method),parameters);
}

+ (id)openEmpty:(NSString *)class withMethod:(NSString *)method withFullURL:(NSString *)fullURL
{
    return ((id (*)(id, SEL, NSString *))(void *)objc_msgSend)([NSClassFromString(class) alloc],NSSelectorFromString(method),fullURL);
}

+ (BOOL)canOpenURL:(NSString *)URL
{
    return ([[self openURL:URL] class] == NSClassFromString(@"UVTEmptyViewController")) ? NO : YES;
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

- (NSString *)crateQuery:(NSDictionary *)parameters
{
    NSString *query = @"";
    NSArray *allkeys = parameters.allKeys;
    
    if ([allkeys count] == 0) {
        return query;
    }
    
    if ([allkeys count] == 1) {
        NSString *fkey = allkeys.firstObject;
        NSString *fvalue = parameters[fkey];
        query = [NSString stringWithFormat:@"%@=%@",fkey,fvalue];
        return query;
    }
    
    if ([allkeys count] > 1) {
        
        NSString *fkey = allkeys.firstObject;
        NSString *fvalue = parameters[fkey];
        query = [NSString stringWithFormat:@"%@=%@",fkey,fvalue];
        
        for (NSInteger i = 1; i < [allkeys count]; i++) {
            NSString *key = allkeys[i];
            NSString *value = parameters[key];
            query = [query stringByAppendingFormat:@"&%@=%@",key,value];
        }
    }
    
    return query;
}

@end
