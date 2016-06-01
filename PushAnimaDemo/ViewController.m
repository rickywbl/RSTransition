//
//  ViewController.m
//  PushAnimaDemo
//
//  Created by 王保霖 on 16/5/30.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "PushAnimationTest.h"
#import "SecondViewController.h"
#import "MusicAnimation.h"
@interface ViewController ()<UINavigationControllerDelegate>{

    UIScreenEdgePanGestureRecognizer *pan;
    UIPercentDrivenInteractiveTransition *interaction;
    
    int type;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationController.delegate = self;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2-50, 100, 100, 50);
    [button setTitle:@"翻页转场" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.backgroundColor  =[UIColor yellowColor];
    
    pan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    pan.edges = UIRectEdgeRight;

    [self.view addGestureRecognizer:pan];
    
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-50, CGRectGetWidth(self.view.frame), 50)];
    self.bottomView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.bottomView];
    
    self.musicImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.musicImageView.image =[UIImage imageNamed:@"back0"];
    self.musicImageView.layer.cornerRadius = 25;
    self.musicImageView.clipsToBounds = YES;
    [self.bottomView addSubview:self.musicImageView];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    
    [self.musicImageView addGestureRecognizer:tap];
    self.musicImageView.userInteractionEnabled = YES;
    

    

    
    
    
    
}

-(void)tapAction{
    
    type = 2;
    SecondViewController *music =  [[SecondViewController alloc]init];
    music.transitioningDelegate = self;
    [self.navigationController presentViewController:music animated:YES completion:nil];
}

-(void)panAction:(UIScreenEdgePanGestureRecognizer *)sender{

    type = 1;
    CGFloat progress = -([sender translationInView:self.view].x/CGRectGetWidth(self.view.frame));
    NSLog(@"%.2f",progress);
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            {
            interaction = [[UIPercentDrivenInteractiveTransition alloc]init];

            FirstViewController *first =[[FirstViewController alloc]init];
            [self.navigationController pushViewController:first animated:YES];
                
            break;
            }
        case UIGestureRecognizerStateChanged:
            [interaction updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            
            if(progress >= 0.5){
            
                [interaction finishInteractiveTransition];

            }else{
            
                [interaction cancelInteractiveTransition];
            }
            interaction = nil;
            break;
        }
        default:
            break;
    }
    
}

-(void)pushAction{

    type = 1;
    FirstViewController * first = [[FirstViewController alloc]init];
    
    [self.navigationController pushViewController:first animated:YES];
    
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
  
    if(type == 1){
    if(operation ==  UINavigationControllerOperationPush){
        
        return [PushAnimationTest initRSTransitionAnimationWithType:RSControllerTransitionTypePush andTransitionDuration:1.0];
    }
    
    if(operation == UINavigationControllerOperationPop){
    
        return [PushAnimationTest initRSTransitionAnimationWithType:RSControllerTransitionTypePop andTransitionDuration:1.0];;
    }
    }
    
    
    
    return nil;
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [MusicAnimation initRSTransitionAnimationWithType:RSControllerTransitionModeTypePresent andTransitionDuration:0.5];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{

    return [MusicAnimation initRSTransitionAnimationWithType:RSControllerTransitionModeTypeDismiss andTransitionDuration:0.5];
}


-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{

    if(type == 1){
    return interaction;
    }
    return nil;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
