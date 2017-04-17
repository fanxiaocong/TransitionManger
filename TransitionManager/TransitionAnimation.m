//
//  TransitionAnimation.m
//  转场动画Demo
//
//  Created by 樊小聪 on 2017/4/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import "TransitionAnimation.h"


@implementation TransitionAnimation

#pragma mark - 👀 Init Method 👀 💤

- (instancetype)init
{
    if (self = [super init])
    {
        [self setupDefaults];
    }
    
    return self;
}

// 设置默认参数
- (void)setupDefaults
{
    self.transitionDuration = TRANSITION_DURATION;
    self.style = TransitionAnimationStyleShow;
}

#pragma mark - 👀 动画代理 👀 💤

/**
 *  转场动画时间
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.transitionDuration;
}

/**
 *  动画的具体实现
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *sourceVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *destVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *soreceView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *destView   = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *contaionerView = [transitionContext containerView];
    _transitionContext = transitionContext;
    
    _sourceVC       = sourceVC;
    _destVC         = destVC;
    _sourceView     = soreceView;
    _destView       = destView;
    _contaionerView = contaionerView;
    
    /// 动画事件
    [self animateTransitionEvent];
}

#pragma mark -- 动画事件
- (void)animateTransitionEvent
{
}

#pragma mark -- 动画结束
- (void)completeTransition
{
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
    
    if (self.animationCompleteBlock)
    {
        self.animationCompleteBlock();
    }
}

@end
