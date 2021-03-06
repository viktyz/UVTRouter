//
//  ViewController.m
//  UVTRouter
//
//  Created by viktyz on 2017/7/13.
//  Copyright © 2017年 UVT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickJumpA:(UIButton *)sender {
    
    UIViewController *aVC = [UVTRouter openURL:@"router://ViewControllerA/initWithDic?A=testA&B=testB" completion:^(id result) {
        NSLog(@"Completion Block Executed Success");
    }];
    
    [self.navigationController pushViewController:aVC animated:YES];
}

- (IBAction)clickJumpB:(UIButton *)sender {
    
    UIViewController *aVC = [UVTRouter openURL:@"router://ViewControllerB/initWithDic?A=testA&B=testB"];
    [self.navigationController pushViewController:aVC animated:YES];
}

- (IBAction)clickJumpEmpyt:(UIButton *)sender {
    
    [UVTRouter setDefaultVC:[UVTRouter openURL:@"router://ViewControllerB/initWithDic?A=testA&B=testB"]];
    
    if (![UVTRouter canOpenURL:@"router://AnyEmptyURL/initWithDic?A=testA&B=testB"]) {
        NSLog(@"Open URL Failed, Router to open default VC");
    }
    
    UIViewController *aVC = [UVTRouter openURL:@"router://AnyEmptyURL/initWithDic?A=testA&B=testB"];
    [self.navigationController pushViewController:aVC animated:YES];
}

@end
