//
//  ViewControllerA.h
//  UVTRouter
//
//  Created by viktyz on 2017/7/13.
//  Copyright © 2017年 UVT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerA : UIViewController

- (instancetype)initWithA:(NSString *)a B:(NSString *)b C:(void (^)(id result))completion;

@end
