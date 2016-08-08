//
//  ShufflingDetailsViewController.m
//  XHP_CycleScrollView
//
//  Created by xiaohaiping on 16/8/8.
//  Copyright © 2016年 HaoHeHealth. All rights reserved.
//

#import "ShufflingDetailsViewController.h"
#import "UIView+Frame.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>

@interface ShufflingDetailsViewController ()

@end

@implementation ShufflingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"轮播详情"];
    [self.view addSubview:self.imageView];
    
    if (_localIamgeName != nil) {
        [_imageView setImage:[UIImage imageNamed:_localIamgeName]];
    }else if(_imageURL != nil){
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    // Do any additional setup after loading the view.
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat spaceX = 0;
    CGFloat imageViewWidth = self.view.frameWidth;
    CGFloat imageViewHeight = 180.0f;
    CGFloat spaceY = self.view.frameHeight * 0.5 - imageViewHeight * 0.5;
    [_imageView setFrame:CGRectMake(spaceX, spaceY, imageViewWidth, imageViewHeight)];
}

/**
 *  Getter and Setter
 */
-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
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
