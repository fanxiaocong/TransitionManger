//
//  TransitionManager.h
//  转场动画Demo
//
//  Created by 樊小聪 on 2017/4/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：自定义转场管理中心 🐾
 */

#import <UIKit/UIKit.h>

@class TransitionAnimation;

@interface TransitionManager : NSObject <UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

/** 👀 动画：如果为空，则显示系统默认的样式 👀 */
@property (strong, nonatomic) TransitionAnimation *animation;

+ (instancetype)shareInstance;

@end
