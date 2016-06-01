//
//  MusicAnimation.m
//  PushAnimaDemo
//
//  Created by 王保霖 on 16/5/31.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "MusicAnimation.h"
#import "SecondViewController.h"
#import "ViewController.h"

@interface MusicAnimation()
@property (nonatomic, assign) RSControllerTransitionModeType transitionType;
@property (nonatomic, assign) NSTimeInterval duration;

@end
@implementation MusicAnimation


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{

    return self.duration;
}

-(instancetype)init{
    
    if(self = [super init]){
        
        self.transitionType = RSControllerTransitionModeTypePresent;
        self.duration = 1.0;
    }
    
    return self;
}

+(instancetype)initRSTransitionAnimationWithType:(RSControllerTransitionModeType)type andTransitionDuration:(NSTimeInterval)duration{
    
    MusicAnimation *test = [[MusicAnimation alloc]init];
    test.transitionType = type;
    test.duration = duration;
    return test;
}



- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    if(self.transitionType ==  RSControllerTransitionModeTypePresent){
        
        [self PresentAnimation:transitionContext];
    }else{
    
        [self DisMissAnimation:transitionContext];
    }
    
}



-(void)PresentAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UINavigationController *nav = (UINavigationController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    ViewController *fromviewController = (ViewController *)nav.topViewController;

//    ViewController * fromviewController =[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    ViewController * fromviewController = (ViewController *)nav.topViewController;
    
    SecondViewController *toViewController = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containView = transitionContext.containerView;
    
    NSLog(@"%@",containView.subviews);
    
    
    UIView *tempView = [fromviewController.musicImageView snapshotViewAfterScreenUpdates:YES];
    
    
    //tempView.frame  = fromviewController.musicImageView.frame;
    
    
    
    tempView.frame = [containView convertRect:fromviewController.musicImageView.frame fromView:fromviewController.bottomView];
    
    NSLog(@"%@",NSStringFromCGRect([containView convertRect:fromviewController.musicImageView.frame fromView:fromviewController.bottomView]));
    
    [fromviewController.musicImageView setHidden:YES];
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    toViewController.musicImageView.hidden = YES;
    
    [containView addSubview:toViewController.view];
    [containView addSubview:tempView];
    
    
    [tempView setHidden:NO];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
       
        toViewController.view.alpha = 1.0;
        tempView.frame = [containView convertRect:toViewController.musicImageView.frame fromView:toViewController.view];
        
//        NSLog(@"%@",NSStringFromCGRect([toViewController.musicImageView convertRect:toViewController.musicImageView.frame toView:toViewController.view]));
        
    } completion:^(BOOL finished) {
        
        
        [toViewController.musicImageView setHidden:NO];
        [fromviewController.musicImageView setHidden:NO];
        
        [tempView removeFromSuperview];
        
//        [containView bringSubviewToFront:tempView];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
    }];
    
 
}

-(void)DisMissAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{

    UINavigationController *nav = (UINavigationController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ViewController *toViewController = (ViewController *)nav.topViewController;
    
    SecondViewController *fromViewController = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containView = transitionContext.containerView;
    
    
    UIView *tempView = [fromViewController.musicImageView snapshotViewAfterScreenUpdates:YES];
    
    tempView.frame = [containView convertRect:fromViewController.musicImageView.frame fromView:fromViewController.view];

    
    
    [toViewController.musicImageView setHidden:YES];
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    toViewController.musicImageView.hidden = YES;
    
    [containView addSubview:nav.view];
    [containView addSubview:tempView];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toViewController.view.alpha = 1.0;
        tempView.frame = [containView convertRect:toViewController.musicImageView.frame fromView:toViewController.bottomView];
        
    } completion:^(BOOL finished) {
        
        
        [toViewController.musicImageView setHidden:NO];
        [fromViewController.musicImageView setHidden:NO];
        [tempView removeFromSuperview];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
    }];

}

@end
