//
//  MusicAnimation.h
//  PushAnimaDemo
//
//  Created by 王保霖 on 16/5/31.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,RSControllerTransitionModeType){
    
    RSControllerTransitionModeTypePresent,
    RSControllerTransitionModeTypeDismiss
};
@interface MusicAnimation : NSObject<UIViewControllerAnimatedTransitioning>

+(instancetype)initRSTransitionAnimationWithType:(RSControllerTransitionModeType)type andTransitionDuration:(NSTimeInterval)duration;

@end
