//
//  TransitionAnimation.h
//  转场动画Demo
//
//  Created by 樊小聪 on 2017/4/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, TransitionAnimationStyle)
{
    /// 动画显示：push、present
    TransitionAnimationStyleShow = 0,
    
    /// 动画隐藏：pop、dismiss
    TransitionAnimationStyleHide
};

/** 动画执行所需的时间（宏） */
#define TRANSITION_DURATION 0.3

@interface TransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

/** 动画执行的时间（默认为 0.3s） */
@property (assign, nonatomic) NSTimeInterval transitionDuration;

/** 👀 转场的上下文 👀 */
@property (weak, nonatomic, readonly) id<UIViewControllerContextTransitioning> transitionContext;

/** 👀 动画的样式：入栈、出栈 👀 */
@property (assign, nonatomic) TransitionAnimationStyle style;

/** 源控制器 */
@property (weak, nonatomic, readonly) UIViewController *sourceVC;

/** 目标控制器 */
@property (weak, nonatomic, readonly) UIViewController *destVC;

/** 👀 源控制器的 view 👀 */
@property (weak, nonatomic, readonly) UIView *sourceView;

/** 👀 目标控制器的 view 👀 */
@property (weak, nonatomic, readonly) UIView *destView;

/** 进行动画过渡的场所 */
@property (weak, nonatomic, readonly) UIView *contaionerView;

/** 👀 动画完成后的回调 👀 */
@property (copy, nonatomic) void(^animationCompleteBlock)();


/**
 *  具体动画实现细节，由子类去实现
 */
- (void)animateTransitionEvent;

/**
 *  动画事件结束
 */
- (void)completeTransition;

@end
