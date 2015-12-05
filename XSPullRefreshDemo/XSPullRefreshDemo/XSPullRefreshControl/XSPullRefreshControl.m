//
//  XSPullRefreshControl.m
//  XSPullRefreshDemo
//
//  Created by 薛纪杰 on 15/12/5.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "XSPullRefreshControl.h"

static const CGFloat defaultHeight  = 100.0f;
static const CGFloat springTreshold = 120.0f;

@interface XSPullRefreshControl ()
@property (strong, nonatomic) UIScrollView *scrollView;
@end

@implementation XSPullRefreshControl

#pragma mark - public methods
- (void)attachToScrollView:(UIScrollView *)scrollView {
    self.scrollView = scrollView;
    
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), 0);
    [self.scrollView addSubview:self];
}

- (void)beginRefreshing {
    self.scrollView.contentInset = UIEdgeInsetsMake(defaultHeight, 0, 0, 0);
    self.scrollView.contentOffset = CGPointMake(0, -defaultHeight);
}

- (void)endRefreshing {    
    // 偏移量小于默认高度
    if (self.scrollView.contentOffset.y > -defaultHeight) {
        
    } else {
        
    }
}

#pragma mark - private methods
- (void)calculate {
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    [self calculate];
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];

    // 开始拖动超过默认高度
    if (self.scrollView.contentOffset.y <= -defaultHeight) {
        
        // 超过弹簧阀值
        if (self.scrollView.contentOffset.y <= -springTreshold) {
            // 使偏移量在阀值位置固定
            self.scrollView.contentOffset = CGPointMake(0, -springTreshold);
        }
        
        // 执行具体下拉动画操作
        
    }
    
    if (!self.scrollView.dragging && self.scrollView.decelerating) {
        [self beginRefreshing];
    }
}

@end
