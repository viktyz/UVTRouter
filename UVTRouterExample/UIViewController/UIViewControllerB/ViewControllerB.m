//
//  ViewControllerB.m
//  UVTRouter
//
//  Created by viktyz on 2017/7/13.
//  Copyright © 2017年 UVT. All rights reserved.
//

#import "ViewControllerB.h"

@interface ViewControllerB ()

@end

@implementation ViewControllerB

- (instancetype)initWithA:(NSString *)a B:(NSString *)b C:(NSString *)c
{
    self = [super init];
    if (self) {
        NSLog(@"A : %@",a);
        NSLog(@"B : %@",b);
        NSLog(@"C : %@",c);
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)URL
{
    self = [self init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
