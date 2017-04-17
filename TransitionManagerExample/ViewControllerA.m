//
//  ViewControllerA.m
//  转场动画Demo
//
//  Created by 樊小聪 on 2017/4/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import "ViewControllerA.h"
#import "TransitionManager.h"
#import "TransitionBubbleAnimation.h"

@interface ViewControllerA ()

@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:189/255.0 green:79/255.0 blue:70/255.0 alpha:1];
}

- (IBAction)backButton:(id)sender {
    
    TransitionBubbleAnimation *popAnim = [[TransitionBubbleAnimation alloc] init];
    
    popAnim.anchorRect = CGRectMake(162.5, 585, 50, 50);

    popAnim.style = TransitionAnimationStyleHide;
    
    [TransitionManager shareInstance].animation = popAnim;
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
