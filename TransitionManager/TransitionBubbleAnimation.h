//
//  TransitionBubbleAnimation.h
//  转场动画Demo
//
//  Created by 樊小聪 on 2017/4/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：气泡缩放动画 🐾
 */

#import "TransitionAnimation.h"

@interface TransitionBubbleAnimation : TransitionAnimation

@property (assign, nonatomic) CGRect anchorRect;

/** 👀 填充颜色 👀 */
@property (weak, nonatomic) UIColor *strokeColor;

@end
