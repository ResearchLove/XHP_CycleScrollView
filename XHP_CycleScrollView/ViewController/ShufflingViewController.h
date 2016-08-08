//
//  ShufflingViewController.h
//  XHP_CycleScrollView
//
//  Created by xiaohaiping on 16/8/8.
//  Copyright © 2016年 HaoHeHealth. All rights reserved.
//

#import "CommonViewController.h"
#import "CycleScrollView.h"

typedef NS_ENUM(NSInteger,ShufflingStype)
{
    ShufflingStypeLocal,          //本地加载-不带标题的图片轮播器
    ShufflingStypeNetworkNotTitle,//网络加载-不带标题的图片轮播器
    ShufflingStypeNetworkTitle,   //网络加载-带标题的图片轮播器
    ShufflingStypeNetworkCustom,  //网络加载-自定义点视图轮播器
    ShufflingStypeNetworkText,    //网络加载-展示文字轮播器
};

@interface ShufflingViewController : CommonViewController

@property (assign,nonatomic) ShufflingStype shufflingStype;

@property (strong,nonatomic) NSArray *localImageNameAry;
@property (strong,nonatomic) NSArray *networkImageNameAry;
@property (strong,nonatomic) NSArray *networkTextAry;

@property (strong,nonatomic) CycleScrollView *localScrollView;
@property (strong,nonatomic) CycleScrollView *networkNotTitleScrollView;
@property (strong,nonatomic) CycleScrollView *networkTitleScrollView; 
@property (strong,nonatomic) CycleScrollView *networkCustomScrollView;
@property (strong,nonatomic) CycleScrollView *networkTextScrollView;  

@end
