//
//  TransitionScaleAnimation.m
//  转场动画Demo
//
//  Created by 樊小聪 on 2017/4/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：缩放的转场动画 🐾
 */


#import "TransitionScaleAnimation.h"

@implementation TransitionScaleAnimation

/**
 *  具体动画的实现
 */
- (void)animateTransitionEvent
{
    switch (self.style)
    {
        case TransitionAnimationStyleShow:
        {
            /// push、presentt 动画
            [self showAnimation];
            break;
        }
        case TransitionAnimationStyleHide:
        {
            /// pop、dismiss 动画
            [self hideAnimation];
            break;
        }
    }
}

/**
 *  push present 动画
 */
- (void)showAnimation
{
    self.contaionerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *animationImgView = (UIImageView *)self.animationView;
    
    __block UIImageView *imageView = [[UIImageView alloc] initWithImage:animationImgView.image];
    
    imageView.frame = self.sourceFrame;
    
    [self.contaionerView addSubview:self.destView];
    self.destView.alpha = 0;
    
    [self.contaionerView addSubview:imageView];
    
    [UIView animateWithDuration:self.transitionDuration animations:^{
        
        self.destView.alpha = 1.0f;
    }];
    
    [UIView animateWithDuration:self.transitionDuration animations:^{
        
        imageView.frame = self.destFrame;
        
    } completion:^(BOOL finished) {
        
        [self completeTransition];
        [imageView removeFromSuperview];
        imageView = nil;
    }];
}

/**
 *  pop dismiss 动画
 */
- (void)hideAnimation
{
    self.contaionerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *animationImgView = (UIImageView *)self.animationView;
    
    __block UIImageView *imageView = [[UIImageView alloc] initWithImage:animationImgView.image];
    
    imageView.frame = self.destFrame;
    
    [self.contaionerView addSubview:self.destView];
    self.destView.alpha = 0;
    
    [self.contaionerView addSubview:imageView];
    
    [UIView animateWithDuration:self.transitionDuration animations:^{
        
        self.destView.alpha = 1.0f;
    }];
    
    UIImage *image  = [imageView.image copy];
    animationImgView.image = nil;
    
    [UIView animateWithDuration:self.transitionDuration animations:^{
        
        imageView.frame = self.sourceFrame;
        
    } completion:^(BOOL finished) {
        
        [self completeTransition];
        [imageView removeFromSuperview];
        animationImgView.image = image;
        imageView = nil;
    }];
}

@end
