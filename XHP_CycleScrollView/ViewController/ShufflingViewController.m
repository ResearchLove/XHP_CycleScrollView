//
//  ShufflingViewController.m
//  XHP_CycleScrollView
//
//  Created by xiaohaiping on 16/8/8.
//  Copyright © 2016年 HaoHeHealth. All rights reserved.
//

#import "ShufflingViewController.h"
#import "ShufflingDetailsViewController.h"

@interface ShufflingViewController ()<CycleScrollViewDelegate>

@end

@implementation ShufflingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"轮播"];
    
    switch (_shufflingStype) {
        case ShufflingStypeLocal:
            [self.view addSubview:self.localScrollView];
            break;
        case ShufflingStypeNetworkNotTitle:
            [self.view addSubview:self.networkNotTitleScrollView];
            break;
        case ShufflingStypeNetworkTitle:
            [self.view addSubview:self.networkTitleScrollView];
            break;
        case ShufflingStypeNetworkCustom:
            [self.view addSubview:self.networkCustomScrollView];
            break;
        case ShufflingStypeNetworkText:
            [self.view addSubview:self.networkTextScrollView];
            break;
        default:
            break;
    }
    
    // Do any additional setup after loading the view.
}



/**
 * Getter and Setter
 *
 */
-(NSArray *)localImageNameAry
{
    if (_localImageNameAry == nil) {
        _localImageNameAry = @[@"shuffling_01",@"shuffling_02",@"shuffling_03",@"shuffling_04"];
    }
    return _localImageNameAry;
}

-(NSArray *)networkImageNameAry
{
    if (_networkImageNameAry == nil) {
        _networkImageNameAry = @[@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",@"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
    }
    return _networkImageNameAry;
}

-(NSArray *)networkTextAry
{
    if (_networkTextAry == nil) {
        _networkTextAry = @[@"何以笙箫默",@"其中有这么一个人出现",@"其她人都会变成将就",@"而我不愿意就将"];
    }
    return _networkTextAry;
}


/**
 *   本地加载-不带标题的图片轮播器
 *
 */
-(CycleScrollView *)localScrollView
{
    if (_localScrollView == nil) {
        _localScrollView = [CycleScrollView cycleScrollViewWithFrame:CGRectMake(0,HEIGHT_STATUSBAR + HEIGHT_NAVBAR, WIDTH_SCREEN, 180) shouldInfiniteLoop:YES imageNamesGroup:self.localImageNameAry];
        _localScrollView.delegate = self;
        _localScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
        _localScrollView.pageControlStyle = CycleScrollViewPageContolStyleClassic;
        _localScrollView.autoScrollTimeInterval = 1.0;  //轮播间隔时间
        
    }
    return _localScrollView;
}

/**
 *   网络加载-不带标题的图片轮播器
 *
 */
-(CycleScrollView *)networkNotTitleScrollView
{
    if (_networkNotTitleScrollView == nil) {
        _networkNotTitleScrollView = [CycleScrollView cycleScrollViewWithFrame:CGRectMake(0, HEIGHT_STATUSBAR + HEIGHT_NAVBAR, WIDTH_SCREEN, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _networkNotTitleScrollView.imageURLStringsGroup = self.networkImageNameAry;
        _networkNotTitleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    }
    return _networkNotTitleScrollView;

}

/**
 *   网络加载-带标题的图片轮播器
 *
 */
-(CycleScrollView *)networkTitleScrollView
{
    if (_networkTitleScrollView == nil) {
        _networkTitleScrollView = [CycleScrollView cycleScrollViewWithFrame:CGRectMake(0, HEIGHT_STATUSBAR + HEIGHT_NAVBAR, WIDTH_SCREEN, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _networkTitleScrollView.imageURLStringsGroup = self.networkImageNameAry;
        _networkTitleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        _networkTitleScrollView.titlesGroup = self.networkTextAry;
        _networkTitleScrollView.imageURLStringsGroup = self.networkImageNameAry;
    }
    return _networkTitleScrollView;
}

/**
 *   网络加载-自定义点视图轮播器
 *
 */
-(CycleScrollView *)networkCustomScrollView
{
    if (_networkCustomScrollView == nil) {
        _networkCustomScrollView = [CycleScrollView cycleScrollViewWithFrame:CGRectMake(0,HEIGHT_STATUSBAR + HEIGHT_NAVBAR, WIDTH_SCREEN, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _networkCustomScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlBlueDot"];
        _networkCustomScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        _networkCustomScrollView.imageURLStringsGroup = self.networkImageNameAry;
    }
    return _networkCustomScrollView;
}

/**
 *   网络加载-展示文字轮播器
 *
 */
-(CycleScrollView *)networkTextScrollView
{
    if (_networkTextScrollView == nil) {
        _networkTextScrollView = [CycleScrollView cycleScrollViewWithFrame:CGRectMake(0,HEIGHT_STATUSBAR + HEIGHT_NAVBAR, WIDTH_SCREEN, 45) delegate:self placeholderImage:nil];
        _networkTextScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _networkTextScrollView.onlyDisplayText = YES;
        _networkTextScrollView.titlesGroup = self.networkTextAry;
    }
    return _networkTextScrollView;

}

/**
 *  CycleScrollViewDelegate
 *
 */
-(void)cycleScrollView:(CycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    ShufflingDetailsViewController *shuDetVC = [[ShufflingDetailsViewController alloc]init];
  
    switch (_shufflingStype) {
        case ShufflingStypeLocal:
            shuDetVC.localIamgeName = [_localImageNameAry objectAtIndex:index];
            break;
        case ShufflingStypeNetworkNotTitle:
            shuDetVC.imageURL = [_networkImageNameAry objectAtIndex:index];
            break;
        case ShufflingStypeNetworkTitle:
            shuDetVC.imageURL = [_networkImageNameAry objectAtIndex:index];
            break;
        case ShufflingStypeNetworkCustom:
            shuDetVC.imageURL = [_networkImageNameAry objectAtIndex:index];
            break;
        case ShufflingStypeNetworkText:
            return;
            break;
        default:
            break;
    }
    
      [self.navigationController pushViewController:shuDetVC animated:YES];
    
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
