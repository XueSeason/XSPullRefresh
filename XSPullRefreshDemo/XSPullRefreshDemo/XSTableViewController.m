//
//  XSTableViewController.m
//  XSPullRefreshDemo
//
//  Created by 薛纪杰 on 15/12/5.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "XSTableViewController.h"

#import "XSPullRefreshControl.h"

@interface XSTableViewController ()
@property (strong, nonatomic) XSPullRefreshControl *pullRefreshControl;
@end

@implementation XSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pullRefreshControl = [[XSPullRefreshControl alloc] init];
    [self.pullRefreshControl attachToScrollView:self.tableView];
}

- (void)controlDidStartAnimation {

}

- (IBAction)endAnimationHandle {
    [self.pullRefreshControl endRefreshing];
}

@end
