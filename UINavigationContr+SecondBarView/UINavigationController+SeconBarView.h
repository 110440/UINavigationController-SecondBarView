//
//  UINavigationController+SeconBarView.h
//  UINavigationController+SecondBarViewDemo
//
//  Created by DamonDing on 15/5/14.
//  Copyright (c) 2015年 zxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SecondBarView)

/**
 * Defualt value is 40
 */
@property (assign, nonatomic) CGFloat secondBarViewHeight;

/**
 *
 */
@property (retain, nonatomic) UIView* secondBarView;

/**
 *
 */
- (void) showSecondBarView;

/**
 *
 */
- (void) hideSecondBarView;

/**
 *  pair function of resetSecondBarView
 */
- (void) removeSecondBarView;

/**
 *
 */
- (void) resetSecondBarView;
@end


@interface UIViewController (SecondBarView) {
    
}

- (void) secondBarDidShow;
- (void) secondBarDidHide;

@end
