//
//  BaseViewController.h
//  Game of Thrones
//
//  Created by Miguel Santiago Rodríguez on 12/9/15.
//  Copyright (c) 2015 Miguel Santiago Rodríguez. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN  NSUInteger const padding;
UIKIT_EXTERN NSUInteger const margin;
UIKIT_EXTERN NSUInteger const heightUnit;

@interface BaseViewController : UIViewController

- (void)addControl:(UIView *)bottomControl underControl:(UIView *)upperControl withHeightUnits:(NSUInteger)heightUnits andLabelText:(NSString *)labelText;
- (void)addControl:(UIView *)bottomControl underControl:(UIView *)upperControl withHeightUnits:(NSUInteger)heightUnits;
- (void)addControl:(UIView *)bottomControl underFrame:(CGRect)frame withHeightUnits:(NSUInteger)heightUnits;
- (CGRect)frameWithNumberOfHeightsUnits:(NSUInteger)heightUnitis relativeToFrame:(CGRect)frame;

@end
