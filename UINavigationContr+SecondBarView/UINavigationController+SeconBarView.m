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

@implementation UINavigationController (SecondBarView)

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
    
    [v removeFromSuperview];
    
    secondBarView.hidden = true;
    UIView* origBar = self.navigationBar;
    
    [secondBarView setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:secondBarView];
    
    NSArray* hCS = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[secondBarView]-0-|"
                                                           options:0
                                                           metrics:nil
                                                             views:NSDictionaryOfVariableBindings(secondBarView)];
    
    NSArray* vCS = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[origBar]-0-[secondBarView(height)]"
                                                           options:0
                                                           metrics:@{@"height": [NSNumber numberWithFloat:self.secondBarViewHeight]}
                                                             views:NSDictionaryOfVariableBindings(origBar, secondBarView)];
    
    [self.view addConstraints:hCS];
    [self.view addConstraints:vCS];
    
    [self.view updateConstraints];

    objc_setAssociatedObject(self, &kSecondBarViewKey, secondBarView, OBJC_ASSOCIATION_RETAIN);
}

- (void) showSecondBarView:(BOOL)animated {
    NSLog(@"%d", !self.secondBarView.isHidden);
    
    if (self.secondBarView == nil || !self.secondBarView.isHidden) {
        return;
    }
    
    if (animated) {
        self.secondBarView.alpha = 0;
        [self.secondBarView setHidden:NO];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.secondBarView.alpha = 1;
        }completion:^(BOOL finished) {
            if (finished) {
                [self.topViewController secondBarDidShow];
            }
        }];
    } else {
        [self.secondBarView setHidden:NO];
        [self.topViewController secondBarDidShow];
    }
}

- (void) hideSecondBarView:(BOOL)animated {
    if (self.secondBarView == nil || self.secondBarView.isHidden) {
        return;
    }

    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.secondBarView.alpha = 0;
        }completion:^(BOOL finished) {
            if (finished) {
                [self.secondBarView setHidden:YES];
                [self.topViewController secondBarDidHide];
            }
        }];
    } else {
        [self.secondBarView setHidden:YES];
        [self.topViewController secondBarDidHide];
    }
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

