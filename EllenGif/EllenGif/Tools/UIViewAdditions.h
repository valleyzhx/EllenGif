//
//  UIViewAdditions.h
//  JDiPhone
//
//  Created by steven sun on 6/11/12.
//  Copyright 2012 360buy. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIView (JDCategory)

//屏幕截图
- (UIImage *) screenshot;

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

//@property(nonatomic,readonly) CGFloat screenX;
//@property(nonatomic,readonly) CGFloat screenY;
//@property(nonatomic,readonly) CGFloat screenViewX;
//@property(nonatomic,readonly) CGFloat screenViewY;
//@property(nonatomic,readonly) CGRect screenFrame;

@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;


/**
 * The view controller whose view contains this view.
 */
- (UIViewController*)viewController;

- (void)setOriginY:(CGFloat)originY;
- (void)setOriginX:(CGFloat)originx;

-(void)removeAllSubViews;


// DRAW GRADIENT
+ (void) drawGradientInRect:(CGRect)rect withColors:(NSArray*)colors;
+ (void) drawLinearGradientInRect:(CGRect)rect colors:(CGFloat[])colors;


// DRAW ROUNDED RECTANGLE
+ (void) drawRoundRectangleInRect:(CGRect)rect withRadius:(CGFloat)radius;

// DRAW LINE
+ (void) drawLineInRect:(CGRect)rect red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (void) drawLineInRect:(CGRect)rect colors:(CGFloat[])colors;
+ (void) drawLineInRect:(CGRect)rect colors:(CGFloat[])colors width:(CGFloat)lineWidth cap:(CGLineCap)cap;

// FILL RECT
+ (void)drawRect:(CGRect)rect fill:(const CGFloat*)fillColors radius:(CGFloat)radius;
+ (void)drawRect:(CGRect)rect fillColor:(UIColor *)fillColor radius:(CGFloat)radius;

// STROKE RECT
+ (void)strokeLines:(CGRect)rect stroke:(const CGFloat*)strokeColor ;



- (UIActivityIndicatorView *) activityWithOrigin:(CGPoint)pt;
- (UIActivityIndicatorView *) activityAtCenter;
- (UIActivityIndicatorView *) activityAtCenterWithSize:(CGSize)size;

@end


/**
 *  视图点击时的回调
 */
@protocol JDUIViewClickProtocal

-(void)clickView:(id)view;

@end
