//
//  XSTableViewController.m
//  XSPullRefreshDemo
//
//  Created by 薛纪杰 on 15/12/5.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "XSTableViewController.h"

@interface XSTableViewController ()

@end

@implementation XSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%.2f", self.tableView.contentOffset.y);
}

- (void)setupRefreshControl {
    
}

- (void)controlDidStartAnimation {
    
}

- (IBAction)endAnimationHandle {
    
}

@end
