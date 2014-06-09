//
//  SKSpinningCircle.h
//  Gastrosoph
//
//  Created by 张明磊 on 13-7-21.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    NSSpinningCircleSizeDefault,
    NSSpinningCircleSizeLarge,
    NSSpinningCircleSizeSmall
}NSSpinningCircleSize;


@interface SKSpinningCircle : UIView

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL hasGlow;
@property (nonatomic, assign) float speed;
@property (nonatomic, assign) NSSpinningCircleSize circleSize;

+(SKSpinningCircle*)circleWithSize:(NSSpinningCircleSize)size color:(UIColor*)color;

@end
