//
//  PushAnimationTest.m
//  PushAnimaDemo
//
//  Created by 王保霖 on 16/5/30.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "PushAnimationTest.h"



@interface PushAnimationTest(){

    UIViewController *_fromViewController;
}
@property (nonatomic, assign) RSControllerTransitionType transitionType;
@property (nonatomic, assign) NSTimeInterval duration;
@property(nonatomic,strong)id transitionContext;
@end

@implementation PushAnimationTest

-(instancetype)init{

    if(self = [super init]){
    
        self.transitionType = RSControllerTransitionTypePush;
        self.duration = 1.0;
    }
    
    return self;
}

+(instancetype)initRSTransitionAnimationWithType:(RSControllerTransitionType)type andTransitionDuration:(NSTimeInterval)duration{

    PushAnimationTest *test = [[PushAnimationTest alloc]init];
    test.transitionType = type;
    test.duration = duration;
    
    return test;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{

    return self.duration;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{

    _transitionContext = transitionContext;
    
    
    
    UIViewController * formViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    
    UIView *contentView = transitionContext.containerView;
    _fromViewController = formViewController;
    
    [formViewController.view.layer removeAllAnimations];




    if(self.transitionType == RSControllerTransitionTypePush){
    
        [contentView addSubview:formViewController.view];
        [contentView addSubview:toViewController.view];
        
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1/2000.0;
        toViewController.view.layer.transform = transform;
        toViewController.view.layer.anchorPoint = CGPointMake(1.0, 0.5);
        toViewController.view.center = CGPointMake(CGRectGetMaxX(formViewController.view.frame), CGRectGetMidY(formViewController.view.frame));
        
    }else{
        
        [contentView addSubview:toViewController.view];
        [contentView addSubview:formViewController.view];
    
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1/2000.0;
        formViewController.view.layer.transform = transform;
        formViewController.view.layer.anchorPoint = CGPointMake(1, 0.5);
        formViewController.view.center = CGPointMake(CGRectGetMaxX(toViewController.view.frame), CGRectGetMidY(toViewController.view.frame));
    }
 
    
    CABasicAnimation * base = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    base.duration = [self transitionDuration:transitionContext];
    base.delegate = self;

    if(self.transitionType == RSControllerTransitionTypePush){
        
        base.fromValue = @(M_PI_2);
        base.toValue = @(0);
        [toViewController.view.layer addAnimation:base forKey:@"rotateAnimation"];

        
    }else{
    
        base.fromValue = @(0);
        base.toValue = @(M_PI_2);
        [formViewController.view.layer addAnimation:base forKey:@"rotateAnimation"];

    }


    
    
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

//    [_fromViewController.view removeFromSuperview];
   
    [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
}

@end
