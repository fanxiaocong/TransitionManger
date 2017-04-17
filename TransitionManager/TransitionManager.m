//
//  TransitionManager.m
//  转场动画Demo
//
//  Created by 樊小聪 on 2017/4/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：自定义转场管理中心 🐾
 */


#import "TransitionManager.h"

#import "TransitionAnimation.h"


@implementation TransitionManager

#pragma mark - ⏳ 👀 LifeCycle Method 👀

static TransitionManager *_instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (!_instance)
        {
            _instance = [[self alloc] init];
        }
    });
    
    return _instance;
}

#pragma mark - 💉 👀 UINavigationControllerDelegate 👀

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    __weak typeof (self)weakSelf = self;
    
    self.animation.animationCompleteBlock = ^{
        
        weakSelf.animation = nil;
    };
    
    return self.animation;
}

#pragma mark - 💉 👀 Present和Dismiss转场动画 👀

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    __weak typeof (self)weakSelf = self;
    
    self.animation.animationCompleteBlock = ^{
        
        weakSelf.animation = nil;
    };
    
    return self.animation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    __weak typeof (self)weakSelf = self;
    
    self.animation.animationCompleteBlock = ^{
        
        weakSelf.animation = nil;
    };
    
    return self.animation;
}

@end





















