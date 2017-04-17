//
//  TransitionScaleAnimation.h
//  转场动画Demo
//
//  Created by 樊小聪 on 2017/4/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：缩放的转场动画 🐾
 */

#import "TransitionAnimation.h"

@interface TransitionScaleAnimation : TransitionAnimation

/** 👀 要进行动画的 view 👀 */
@property (weak, nonatomic) UIView *animationView;

/** 👀 动画视图动画之前的 frame  👀 */
@property (assign, nonatomic) CGRect sourceFrame;

/** 👀 动画视图动画之后的 frame 👀 */
@property (assign, nonatomic) CGRect destFrame;

@end
