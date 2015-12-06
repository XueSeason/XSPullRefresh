//
//  XSActivityView.m
//  XSActivityViewDemo
//
//  Created by 薛纪杰 on 15/12/6.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "XSActivityView.h"

#define SUN_COLOR [UIColor colorWithRed:1.0 green:159 / 255.0 blue:0.0 alpha:1.0]

static const CGFloat animationDuration = 3.0f;
static const CGFloat margin = 20.0;

@interface XSActivityView ()
@property (strong, nonatomic) CALayer *sunLayer;
@property (strong, nonatomic) CALayer *moonLayer;
@end

@implementation XSActivityView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.layer addSublayer:self.sunLayer];
    [self.layer addSublayer:self.moonLayer];
    
    self.backgroundColor = [UIColor whiteColor];
    self.moonLayer.backgroundColor = [UIColor whiteColor].CGColor;
    self.clipsToBounds = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat vMargin, hMargin;
    if (width > height) {
        vMargin = margin;
        hMargin = (width - (height - 2 * margin)) / 2.0;
    } else {
        hMargin = margin;
        vMargin = (height - (width - 2 * margin)) / 2.0;
    }
    
    self.sunLayer.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(vMargin, hMargin, vMargin, hMargin));
    self.sunLayer.cornerRadius = CGRectGetWidth(self.sunLayer.frame) / 2.0;
    
    self.moonLayer.cornerRadius = self.sunLayer.cornerRadius;
    // [-90, 90]
    self.moonLayer.frame = CGRectOffset(self.sunLayer.frame, CGRectGetWidth(self.sunLayer.frame), 0);
}

- (void)startEclipse {
    CABasicAnimation *eclipseAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    eclipseAnimation.fromValue = @(CGRectGetMidX(self.moonLayer.frame));
    eclipseAnimation.byValue = @(- CGRectGetWidth(self.moonLayer.frame) * 2);
    eclipseAnimation.duration = animationDuration;
    eclipseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAKeyframeAnimation *skyColorAniamtion = [CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
    skyColorAniamtion.values = @[(id)[UIColor whiteColor].CGColor, (id)[UIColor blackColor].CGColor, (id)[UIColor whiteColor].CGColor];
    skyColorAniamtion.keyTimes = @[@0, @0.5, @1];
    skyColorAniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    skyColorAniamtion.duration = animationDuration;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[eclipseAnimation, skyColorAniamtion];
    group.duration = animationDuration;
    group.repeatCount = HUGE_VAL;
    
    [self.moonLayer addAnimation:group forKey:@"eclipse"];
    skyColorAniamtion.repeatCount = HUGE_VAL;
    [self.layer addAnimation:skyColorAniamtion forKey:@"sky"];
}

- (void)stopEclipse {
    [self.moonLayer removeAllAnimations];
    [self.layer removeAllAnimations];
}

#pragma mark - getters and setters
- (CALayer *)sunLayer {
    if (!_sunLayer) {
        _sunLayer = [CALayer layer];
        _sunLayer.backgroundColor = SUN_COLOR.CGColor;
    }
    return _sunLayer;
}

- (CALayer *)moonLayer {
    if (!_moonLayer) {
        _moonLayer = [CALayer layer];
    }
    return _moonLayer;
}

@end
