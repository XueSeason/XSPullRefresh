//
//  XSPullRefreshControl.h
//  XSPullRefreshDemo
//
//  Created by 薛纪杰 on 15/12/5.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSPullRefreshControl : UIControl

- (void)attachToScrollView:(UIScrollView *)scrollView;

- (void)beginRefreshing;

- (void)endRefreshing;

@end
