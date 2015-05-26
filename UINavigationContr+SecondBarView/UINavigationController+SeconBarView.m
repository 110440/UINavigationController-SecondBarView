//
//  UINavigationController+SeconBarView.m
//  UINavigationController+SecondBarViewDemo
//
//  Created by DamonDing on 15/5/14.
//  Copyright (c) 2015年 zxm. All rights reserved.
//

#import "UINavigationController+SeconBarView.h"
#import <objc/runtime.h>

static char kSecondBarViewHeightKey;
static char kSecondBarViewKey;
static char kContainerViewKey;

@interface UINavigationController ()
@property (retain, nonatomic) UIView *container;
@end

@implementation UINavigationController (SecondBarView)

- (UIView*) container {
    UIView* c = objc_getAssociatedObject(self, &kContainerViewKey);
    
    if (c == nil) {
        c = [UIView new];
        c.clipsToBounds = true;
        c.backgroundColor = [UIColor clearColor];

        c.frame = CGRectMake(0, 64, self.view.frame.size.width, self.secondBarViewHeight);
        
        objc_setAssociatedObject(self, &kContainerViewKey, c, OBJC_ASSOCIATION_RETAIN);
    }
    
    return c;
}

- (CGFloat) secondBarViewHeight {
    NSNumber* h = objc_getAssociatedObject(self, &kSecondBarViewHeightKey);
    
    if (h == nil) {
        h = @40;
    }
    
    return h.floatValue;
}

- (void) setSecondBarViewHeight:(CGFloat)secondBarViewHeight {
    objc_setAssociatedObject(self, &kSecondBarViewHeightKey, [NSNumber numberWithFloat:secondBarViewHeight], OBJC_ASSOCIATION_RETAIN);
}


- (UIView*) secondBarView {
    return objc_getAssociatedObject(self, &kSecondBarViewKey);
}

- (void) setSecondBarView:(UIView *)secondBarView {
    UIView* v = objc_getAssociatedObject(self, &kSecondBarViewKey);
    
    if (v == secondBarView) {
        return;
    }
    
    [v removeFromSuperview];

    [self.container addSubview:secondBarView];
    secondBarView.frame = CGRectMake(0, -1 * self.secondBarViewHeight, self.view.frame.size.width, self.secondBarViewHeight);
    
    objc_setAssociatedObject(self, &kSecondBarViewKey, secondBarView, OBJC_ASSOCIATION_RETAIN);
}

- (void) showSecondBarView:(BOOL) animation {
    // haven't setted or is showing
    if (self.secondBarView == nil || self.secondBarView.frame.origin.y == 0) {
        return;
    }
    
    self.container.frame = CGRectMake(0, 64, self.view.frame.size.width, self.secondBarViewHeight);
    [self.view addSubview:self.container];

    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rt = self.secondBarView.frame;
            rt.origin.y = 0;
            self.secondBarView.frame = rt;
        } completion:^(BOOL finished) {
            if (finished) {
                
            }
        }];
    } else {
        CGRect rt = self.secondBarView.frame;
        rt.origin.y = 0;
        self.secondBarView.frame = rt;
    }

    [self.topViewController secondBarDidShow:self.secondBarViewHeight];
}

- (void) hideSecondBarView:(BOOL) animation {
    // haven't setted or is hidden now
    if (self.secondBarView == nil || (self.secondBarView.frame.origin.y < 0)) {
        return;
    }

    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rt = self.secondBarView.frame;
            rt.origin.y = -1 * rt.size.height;
            self.secondBarView.frame = rt;
        } completion:^(BOOL finished) {
            [self.container removeFromSuperview];
        }];
    } else {
        CGRect rt = self.secondBarView.frame;
        rt.origin.y = -1 * rt.size.height;
        self.secondBarView.frame = rt;
        [self.container removeFromSuperview];
    }
    
    [self.topViewController secondBarDidHide:self.secondBarViewHeight];
}

//- (void) removeSecondBarView {
//    [self.secondBarView removeFromSuperview];
//}
//
//- (void) resetSecondBarView {
//    UIView* v = self.secondBarView;
//    
//    [self setSecondBarView:v];
//}

- (BOOL) isSecondBarViewShowing {
    if (self.secondBarView == nil) {
        return false;
    }
    
    return self.secondBarView.frame.origin.y == 0;
}
@end

/**
 *
 */
@implementation UIViewController(SecondBarView)
//- (void) secondBarWillShow:(CGFloat) height; {
//    
//}

- (void) secondBarDidShow:(CGFloat) height; {
    
}

//- (void) secondBarWillHide:(CGFloat) height; {
//    
//}

- (void) secondBarDidHide:(CGFloat) height; {
    
}

@end

