//
//  UIView+Extension.h
//  XHP_CycleScrollView
//
//  Created by xiaohaiping on 16/8/8.
//  Copyright © 2016年 HaoHeHealth. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ColorCreater(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

@interface UIView (Extension)


@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;


@end
