//
//  SKSpinningCircle.m
//  Gastrosoph
//
//  Created by 张明磊 on 13-7-21.
//
//

#import "SKSpinningCircle.h"
#import <QuartzCore/QuartzCore.h>

@implementation SKSpinningCircle
{
    float progress;
}

+(SKSpinningCircle*)circleWithSize:(NSSpinningCircleSize)size color:(UIColor*)color
{
    float width;
    switch (size)
    {
        case NSSpinningCircleSizeDefault:
            width = 40;
            break;
        case NSSpinningCircleSizeLarge:
            width = 50;
            break;
        case  NSSpinningCircleSizeSmall:
            width = 10;
            break;
    }
    
    SKSpinningCircle *circle = [[SKSpinningCircle alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    circle.color = color;
    return circle;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.opaque = NO;
        self.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin;
    }
    return self;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *view in self.subviews)
    {
        if ([view pointInside:[self convertPoint:point toView:view] withEvent:event])
            return YES;
    }
    return NO;
}

-(void)setIsAnimating:(BOOL)animating
{
    _isAnimating = animating;
    if(animating)
    {
        [UIView animateWithDuration:0.9 animations:^{ self.alpha = 1.0; }];
        [self addRotationAnimation];
    }
    else
    {
        [self hide];
    }
}

-(void)hide
{
    [UIView animateWithDuration:0.45 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL fin) {
        [self.layer removeAllAnimations];
    }];
}

-(CGGradientRef)gradient
{
    
    UIColor *sideColor = [UIColor redColor];
    UIColor *midColor = [UIColor lightGrayColor];
    NSArray* gradientColors = @[(id)sideColor.CGColor,
                                (id)midColor.CGColor,
                                (id)sideColor.CGColor];
    CGFloat gradientLocations[] = {0, 0.5, 1};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    return CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
}

-(void)drawAnnular
{
    progress += 0.05;
    if(progress > M_PI) progress = 0;
    CGFloat lineWidth = 3.25f;
    if(_circleSize == NSSpinningCircleSizeDefault)
        lineWidth = 2.0f;
    UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
    processBackgroundPath.lineWidth = lineWidth;
    processBackgroundPath.lineCapStyle = kCGLineCapRound;
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = (self.bounds.size.width - 16 - lineWidth)/2;
    CGFloat startAngle = - ((float)M_PI / 2 - progress*2);
    
    [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1] set];
    
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    processPath.lineCapStyle = kCGLineCapSquare;
    processPath.lineWidth = lineWidth;
    CGFloat endAngle = ((float)M_PI + startAngle);
    [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    if(_hasGlow)
        CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(), CGSizeMake(0, 0), 6, _color.CGColor);
    [_color set];
    [processPath stroke];
    CGContextRestoreGState(context);
    
    if(_isAnimating)
        [self addRotationAnimation];
}

-(void)addRotationAnimation
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI];
    rotationAnimation.duration = _speed;
    //rotationAnimation.duration = 0.3;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.cumulative = YES;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation1"];
}

-(void)drawRect:(CGRect)rect
{
    [self drawAnnular];
}

@end
