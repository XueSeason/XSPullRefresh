//
//  XSPullRefreshControl.m
//  XSPullRefreshDemo
//
//  Created by 薛纪杰 on 15/12/5.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "XSPullRefreshControl.h"
#import "XSActivityView.h"

static const CGFloat defaultHeight  = 100.0f;
static const CGFloat springTreshold = 120.0f;

static const CGFloat animationDuration = 1.0f;
static const CGFloat animationDamping  = 0.4f;
static const CGFloat animationVelosity = 0.8f;

@interface XSPullRefreshControl ()
@property (weak, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) XSActivityView *activityView;
@end

@implementation XSPullRefreshControl

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.activityView = [XSActivityView new];
    [self addSubview:self.activityView];
}

#pragma mark - public methods
- (void)attachToScrollView:(UIScrollView *)scrollView {
    self.scrollView = scrollView;

    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), 0);
    [self.scrollView addSubview:self];
}

- (void)beginRefreshing {
    self.scrollView.contentInset = UIEdgeInsetsMake(defaultHeight, 0, 0, 0);
    [self.scrollView setContentOffset:CGPointMake(0, -defaultHeight) animated:YES];
    [self.activityView startEclipse];
}

- (void)endRefreshing {
    [self returnDefaultState];
    [self.activityView stopEclipse];
}

#pragma mark - private methods
- (void)calculate {
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    self.activityView.frame = self.bounds;
    // 开始拖动超过默认高度
    if (self.scrollView.contentOffset.y <= -defaultHeight) {
        
        // 超过弹簧阀值
        if (self.scrollView.contentOffset.y < -springTreshold) {
            // 使偏移量在阀值位置固定
            self.scrollView.contentOffset = CGPointMake(0, -springTreshold);
        }
        
        // 执行具体下拉动画操作
    }
    
    if (!self.scrollView.dragging && self.scrollView.decelerating) {
        [self beginRefreshing];
    }
}

- (void)returnDefaultState {
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
         usingSpringWithDamping:animationDamping
          initialSpringVelocity:animationVelosity
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.scrollView.contentInset = UIEdgeInsetsZero;
                     } completion:nil];
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
}

@end
