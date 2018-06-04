//
//  ViewController.m
//  BZCustomAlert
//
//  Created by 郑伟 on 2018/6/4.
//  Copyright © 2018年 郑伟. All rights reserved.
//

#import "ViewController.h"
#import "BZCustomAlert.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BZCustomAlert *alert = [[BZCustomAlert alloc] init];
    alert.title = @"这里是标题";
    alert.message =  @"这里是详细信息";
    [alert addButton:@"取消" action:nil];
    [alert addButton:@"完成" action:^(BZCustomAlert *alert) {
        NSLog(@"点击了完成");
    }];
    [alert addTextField:nil witPlaceholder:@"这里是默认文案"];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
