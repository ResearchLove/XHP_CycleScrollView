//
//  CommonViewController.m
//  HaoHeHealth
//
//  Created by xiaohaiping on 16/6/17.
//  Copyright © 2016年 HaoHe. All rights reserved.
//

#import "CommonViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    [self setHidesBottomBarWhenPushed:YES];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

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
