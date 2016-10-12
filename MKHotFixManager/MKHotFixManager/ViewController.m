//
//  ViewController.m
//  MKHotFixManager
//
//  Created by gkoudai_xsm on 16/10/10.
//  Copyright © 2016年 gkoudai_xsm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UIView *fuckView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.fuckView];
}

- (UIView *)fuckView {
    if (!_fuckView) {
        _fuckView = [[UIView alloc] init];
        _fuckView.backgroundColor = [UIColor redColor];
        _fuckView.frame = CGRectMake(0, 0, 100, 100);
    }
    return _fuckView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
