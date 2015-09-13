//
//  BaseViewController.m
//  Game of Thrones
//
//  Created by Miguel Santiago Rodríguez on 12/9/15.
//  Copyright (c) 2015 Miguel Santiago Rodríguez. All rights reserved.
//

#import "BaseViewController.h"

NSUInteger const padding = 16;
NSUInteger const margin = 8;
NSUInteger const heightUnit = 40;

@interface BaseViewController ()

@property (assign, nonatomic) CGSize screenSize;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenSize = self.view.frame.size;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];    
    [self setUpScrollViewSize];
}

- (void)addControl:(UIView *)bottomControl underControl:(UIView *)upperControl withHeightUnits:(NSUInteger)heightUnits andLabelText:(NSString *)labelText {
    UILabel *textLabel = [UILabel new];
    textLabel.font = [UIFont systemFontOfSize:12.0];
    textLabel.text = labelText;
    if (upperControl) {
        [self addControl:textLabel underControl:upperControl withHeightUnits:1];
    } else {
        [self addControl:textLabel underFrame:CGRectMake(0, 2 * margin, 0, 0) withHeightUnits:1];
    }
    
    [self addControl:bottomControl underControl:textLabel withHeightUnits:heightUnits];
}

- (void)addControl:(UIView *)bottomControl underControl:(UIView *)upperControl withHeightUnits:(NSUInteger)heightUnits {
    [self addControl:bottomControl underFrame:upperControl.frame withHeightUnits:heightUnits];
}

- (void)addControl:(UIView *)bottomControl underFrame:(CGRect)frame withHeightUnits:(NSUInteger)heightUnits {
    bottomControl.frame = [self frameWithNumberOfHeightsUnits:heightUnits relativeToFrame:frame];
    [self.scrollView addSubview:bottomControl];
}

- (void)setHeightInUnits:(NSUInteger)heightUnits forControl:(UIView *)control {
    control.bounds = CGRectInset(control.bounds, heightUnits * heightUnit, CGRectGetWidth(control.bounds));
}

- (CGRect)frameWithNumberOfHeightsUnits:(NSUInteger)heightUnitis relativeToFrame:(CGRect)frame {
    return CGRectMake(padding, frame.size.height + frame.origin.y + margin, self.screenSize.width - 2 * padding, heightUnitis * heightUnit);
}

#pragma mark - ScrollView

- (void)setUpScrollViewSize {
    UIView *lastView = [[self.scrollView subviews] lastObject];
    CGFloat sizeContent = lastView.frame.origin.y + lastView.frame.size.height;
    self.scrollView.contentSize = CGSizeMake(self.screenSize.width, sizeContent);
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_scrollView];
    }
    
    return _scrollView;
}

@end
