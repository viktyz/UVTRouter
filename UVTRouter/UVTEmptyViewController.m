//
//  UVTEmptyViewController.m
//  UVTRouter
//
//  Created by viktyz on 2017/7/14.
//  Copyright © 2017年 UVT. All rights reserved.
//

#import "UVTEmptyViewController.h"

@interface UVTEmptyViewController ()

@property (nonatomic, strong) NSString *URL;

@end

@implementation UVTEmptyViewController

- (instancetype)initWithURL:(NSString *)URL
{
    self = [self init];
    if (self) {
        _URL = URL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, CGRectGetWidth(self.view.frame) - 20, 100)];
    label.text = _URL;
    label.numberOfLines = 0;
    [self.view addSubview:label];
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
