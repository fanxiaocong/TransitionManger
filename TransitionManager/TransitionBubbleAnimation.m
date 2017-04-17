//
//  TransitionBubbleAnimation.m
//  转场动画Demo
//
//  Created by 樊小聪 on 2017/4/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：气泡缩放动画 🐾
 */


#import "TransitionBubbleAnimation.h"

@interface TransitionBubbleAnimation ()<CAAnimationDelegate>

@property (weak, nonatomic) CAShapeLayer *maskLayer;

@end


@implementation TransitionBubbleAnimation

/**
 *  具体动画的实现
 */
- (void)animateTransitionEvent
{
    switch (self.style)
    {
        case TransitionAnimationStyleShow:
        {
            /// push present 动画
            [self showAnimation];
            break;
        }
        case TransitionAnimationStyleHide:
        {
            /// pop dismiss 动画
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
    [self.contaionerView addSubview:self.sourceView];
    [self.contaionerView addSubview:self.destView];
    
    /*⏰ ----- sourceView 隐藏的动画 ----- ⏰*/
    
    /// 创建一个 CAShapeLayer 来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.bounds    = self.sourceView.layer.bounds;
    maskLayer.position  = self.sourceView.layer.position;
    maskLayer.fillColor = self.strokeColor.CGColor ?: self.destView.backgroundColor.CGColor;
    [self.sourceView.layer addSublayer:maskLayer];
    self.maskLayer = maskLayer;
    
    /// 开始的圆环
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:self.anchorRect];
    /// 半径
    CGFloat radius = [self radiusOfBubbleInView:self.destView startPoint:CGPointMake(CGRectGetMidX(self.anchorRect), CGRectGetMidY(self.anchorRect))];
    /// 结束的圆环
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.anchorRect, -radius, -radius)];
    
    maskLayer.path = endPath.CGPath;
    
    /// 圆形放大动画
    CABasicAnimation *sourceAnima = [CABasicAnimation animationWithKeyPath:@"path"];
    sourceAnima.fromValue = (__bridge id)(startPath.CGPath);
    sourceAnima.toValue   = (__bridge id)(endPath.CGPath);
    sourceAnima.duration  = self.transitionDuration;
    sourceAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    sourceAnima.delegate  = self;
    [maskLayer addAnimation:sourceAnima forKey:@"path"];
    
    
    /*⏰ ----- destView 显示的动画 ----- ⏰*/
    /// 目标视图最终显示的位置
    self.destView.layer.position = CGPointMake(CGRectGetMidX(self.destView.bounds), CGRectGetMidY(self.destView.bounds));
    /// 位移与缩放的动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = self.transitionDuration;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    /// 位移
    CABasicAnimation *positionAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.anchorRect), CGRectGetMidY(self.anchorRect))];
    positionAnim.toValue   = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.destView.bounds), CGRectGetMidY(self.destView.bounds))];
    /// 缩放
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnima.fromValue = @0;
    scaleAnima.toValue   = @1;
    
    group.animations = @[positionAnim, scaleAnima];
    [self.destView.layer addAnimation:group forKey:@"group"];
}

/**
 *  pop dismiss 动画
 */
- (void)hideAnimation
{
    [self.contaionerView addSubview:self.destView];
    [self.contaionerView addSubview:self.sourceView];
    
    /*⏰ ----- destView 显示的动画 ----- ⏰*/
    
    /// 创建一个 CAShapeLayer 来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.bounds    = self.destView.layer.bounds;
    maskLayer.position  = self.destView.layer.position;
    maskLayer.fillColor = self.strokeColor.CGColor ?: self.sourceView.backgroundColor.CGColor;
    [self.destView.layer addSublayer:maskLayer];
    self.maskLayer = maskLayer;
    
    /// 半径
    CGFloat radius = [self radiusOfBubbleInView:self.destView startPoint:CGPointMake(CGRectGetMidX(self.anchorRect), CGRectGetMidY(self.anchorRect))];
    /// 开始的圆环
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.anchorRect, -radius, -radius)];

    /// 结束的圆环
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:self.anchorRect];
    
    maskLayer.path = endPath.CGPath;
    
    /// 圆形放大动画
    CABasicAnimation *destAnima = [CABasicAnimation animationWithKeyPath:@"path"];
    destAnima.fromValue = (__bridge id)(startPath.CGPath);
    destAnima.toValue   = (__bridge id)(endPath.CGPath);
    destAnima.duration  = self.transitionDuration;
    destAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    destAnima.delegate  = self;
    [maskLayer addAnimation:destAnima forKey:@"path"];
    
    
    /*⏰ ----- sourceView 隐藏的动画 ----- ⏰*/
    /// sourceView 最终的位置
    self.sourceView.layer.position = CGPointMake(CGRectGetMidX(self.anchorRect), CGRectGetMidY(self.anchorRect));
    self.sourceView.transform = CGAffineTransformMakeScale(0, 0);
    /// 位移与缩放的动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = self.transitionDuration;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    /// 位移
    CABasicAnimation *positionAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.sourceView.bounds), CGRectGetMidY(self.sourceView.bounds))];
    positionAnim.toValue   = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.anchorRect), CGRectGetMidY(self.anchorRect))];
    positionAnim.duration = self.transitionDuration;
    /// 缩放
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnima.fromValue = @1;
    scaleAnima.toValue   = @0;
    
    group.animations = @[positionAnim, scaleAnima];
    [self.sourceView.layer addAnimation:group forKey:@"group"];
}

/**
 *  获取 view 的四个顶点 与 startPoint 点之前手最大距离
 *
 *  @param view         视图
 *  @param startPoint   顶点
 */
- (CGFloat)radiusOfBubbleInView:(UIView *)view startPoint:(CGPoint)startPoint
{
    /// 获取 view 上面四个顶点的坐标
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(CGRectGetWidth(view.bounds), 0);
    CGPoint point3 = CGPointMake(0, CGRectGetHeight(view.bounds));
    CGPoint point4 = CGPointMake(CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    
    NSArray *pointsArr = @[[NSValue valueWithCGPoint:point1],
                           [NSValue valueWithCGPoint:point2],
                           [NSValue valueWithCGPoint:point3],
                           [NSValue valueWithCGPoint:point4]];
    
    CGFloat maxRadius = 0;
    
    for (NSValue *value in pointsArr)
    {
        CGPoint point = value.CGPointValue;
        
        CGFloat deltaX = point.x - startPoint.x;
        CGFloat deltaY = point.y - startPoint.y;
        
        CGFloat radius = sqrt(deltaX * deltaX + deltaY * deltaY);
        
        if (maxRadius < radius)
        {
            maxRadius = radius;
        }
    }
    
    return maxRadius;
}

#pragma mark - 💉 👀 CAAnimationDelegate 👀

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // 通知上下文 动画结束
    [self completeTransition];
    
    // 移除遮罩layer
    [_maskLayer removeFromSuperlayer];
    _maskLayer = nil;
}

@end









