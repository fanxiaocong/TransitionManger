//
//  ViewController.m
//  TransitionManagerExample
//
//  Created by 樊小聪 on 2017/4/17.
//  Copyright © 2017年 樊小聪. All rights reserved.
//
#import "ViewController.h"

#import "TransitionManager.h"
#import "TransitionBubbleAnimation.h"

@interface ViewController ()

@property (strong, nonatomic) TransitionManager *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    button.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(self.view.frame) - 60);
    button.layer.cornerRadius = 25.0f;
    button.backgroundColor = [UIColor colorWithRed:189/255.0 green:79/255.0 blue:70/255.0 alpha:1];
    [button setImage:[UIImage imageNamed:@"Menu_icn"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(didClickCircleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClickCircleButtonAction:(UIButton *)button
{
    TransitionBubbleAnimation *anim = [[TransitionBubbleAnimation alloc] init];
    anim.anchorRect = button.frame;
    TransitionManager *mgr = [TransitionManager shareInstance];
    mgr.animation = anim;
    self.navigationController.delegate = mgr;
    [self performSegueWithIdentifier:@"ToA" sender:NULL];
}


@end
