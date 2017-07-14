//
//  ViewControllerA+Action.m
//  UVTRouter
//
//  Created by viktyz on 2017/7/14.
//  Copyright © 2017年 UVT. All rights reserved.
//

#import "ViewControllerA+Action.h"

@implementation ViewControllerA (Action)

- (instancetype)initWithDic:(NSDictionary *)dicInfo
{
    return [self initWithA:dicInfo[@"A"] B:dicInfo[@"B"] C:dicInfo[UVTRouterParameterCompletion]];
}

@end
