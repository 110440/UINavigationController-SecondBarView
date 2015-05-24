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
        
        UIView* origBar = self.navigationBar;
        
        [c setTranslatesAutoresizingMaskIntoConstraints:false];
        [self.view addSubview:c];
        
        NSArray* hCS = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[c]-0-|"
                                                               options:0
                                                               metrics:nil
                                                                 views:NSDictionaryOfVariableBindings(c)];
        
        NSArray* vCS = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[origBar]-0-[c(40)]"
                                                               options:0
                                                               metrics:@{@"height": [NSNumber numberWithFloat:self.secondBarViewHeight]}
                                                                 views:NSDictionaryOfVariableBindings(origBar, c)];
        
        [self.view addConstraints:hCS];
        [self.view addConstraints:vCS];
        
        [self.view updateConstraints];
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
    id v = objc_getAssociatedObject(self, &kSecondBarViewKey);
    
    if (v == secondBarView) {
        return;
    }
    
    if (v != nil) {
        [v removeFromSuperview];
        [self.topViewController secondBarDidHide];
    }
    
    UIView* c = self.container;
    
    [self.container addSubview:secondBarView];
    secondBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    secondBarView.frame = CGRectMake(0, -1 * self.secondBarViewHeight, c.frame.size.width, self.secondBarViewHeight);
    
    objc_setAssociatedObject(self, &kSecondBarViewKey, secondBarView, OBJC_ASSOCIATION_RETAIN);
}

- (void) showSecondBarView {
    // haven't setted or is showing
    if (self.secondBarView == nil || self.secondBarView.frame.origin.y == 0) {
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rt = self.secondBarView.frame;
        rt.origin.y = 0;
        self.secondBarView.frame = rt;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.topViewController secondBarDidShow];
        }
    }];
}

- (void) hideSecondBarView {
    // haven't setted or is hidden now
    if (self.secondBarView == nil || (self.secondBarView.frame.origin.y < 0)) {
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rt = self.secondBarView.frame;
        rt.origin.y = -1 * rt.size.height;
        self.secondBarView.frame = rt;
    } completion:^(BOOL finished) {
        [self.topViewController secondBarDidHide];
    }];
}

- (void) removeSecondBarView {
    [self.secondBarView removeFromSuperview];
}

- (void) resetSecondBarView {
    UIView* v = self.secondBarView;
    
    [self setSecondBarView:v];
}

@end

/**
 *
 */
@implementation UIViewController(SecondBarView)
- (void) secondBarDidShow {
    
}

- (void) secondBarDidHide; {
    
}

@end

