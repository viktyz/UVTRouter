//
//  UVTViewController.h
//  UVTRouter
//
//  Created by viktyz on 2017/7/13.
//  Copyright © 2017年 UVT. All rights reserved.
//

#import <UIKit/UIKit.h>

// 业务模块对外 VC 基类
// 独立业务模块之间不应该存在过多耦合
// 业务模块之间互相调用以传入初始参数方式唤起，以跳出方式终结
// 业务模块之间不应该存在 Delegate 与 DataSource 回调

@interface UVTViewController : UIViewController

@end
