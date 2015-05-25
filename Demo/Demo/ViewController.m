//
//  ViewController.m
//  Demo
//
//  Created by DamonDing on 15/5/14.
//  Copyright (c) 2015年 zxm. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationController+SeconBarView.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (retain, nonatomic) UIProgressView* prg;
@property (assign, nonatomic) NSInteger originTop;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.originTop = self.tableView.contentInset.top;

    _prg = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showSecondNaviBar:(id)sender {
    UINavigationBar* bar = [UINavigationBar new];
    
    UINavigationItem* item2 = [UINavigationItem new];
    
    UISegmentedControl* segment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
    
    [segment insertSegmentWithTitle:@"1" atIndex:0 animated:false];
    [segment insertSegmentWithTitle:@"2" atIndex:0 animated:false];
    segment.selectedSegmentIndex = 0;
    item2.titleView = segment;
    
    [bar pushNavigationItem:item2 animated:false];
    [self.navigationController setSecondBarViewHeight:40];

    [self.navigationController setSecondBarView:bar];
    [self.navigationController showSecondBarView:true];
}

- (IBAction)showProgressView:(id)sender {
    self.navigationController.secondBarViewHeight = 4;
    _prg.progress = 0.1;
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(update) userInfo:nil repeats:true];
    
    self.navigationController.secondBarView = _prg;
    
    [self.navigationController showSecondBarView:true];
}

- (void) update {
    _prg.progress += 0.1;
}

- (IBAction)hide:(id)sender {
    [self.navigationController hideSecondBarView:true];
}

- (void) secondBarDidShow:(CGFloat) height {
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top + height, 0, 0, 0);
}

- (void) secondBarDidHide:(CGFloat) height {
        self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top - height, 0, 0, 0);
}

@end
