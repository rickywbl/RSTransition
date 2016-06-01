//
//  PushAnimationTest.h
//  PushAnimaDemo
//
//  Created by 王保霖 on 16/5/30.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,RSControllerTransitionType){
    
    RSControllerTransitionTypePush,
    RSControllerTransitionTypePop
};


@interface PushAnimationTest : NSObject<UIViewControllerAnimatedTransitioning>


+(instancetype)initRSTransitionAnimationWithType:(RSControllerTransitionType)type andTransitionDuration:(NSTimeInterval)duration;

@end
