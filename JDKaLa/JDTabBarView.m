//
//  JDTabBarVIew.m
//  JDKaLa
//
//  Created by zhangminglei on 11/13/13.
//  Copyright (c) 2013 张明磊. All rights reserved.
//

#import "JDTabBarView.h"
#import "SKUIUtils.h"

@implementation JDTabBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self installViewTabBar];
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)installViewTabBar
{
    [self setFrame:CGRectMake(0, [[UIScreen mainScreen] currentMode].size.height/2 - 66, 320, 46)];
    
    UIImageView *imageViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [SKUIUtils didLoadImageNotCached:@"bg_bottom.png" inImageView:imageViewBack];
    [self addSubview:imageViewBack];
    
    UIButton *button_one = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_one setFrame:CGRectMake(0, 0, 64, 46)];
    [SKUIUtils didLoadImageNotCached:@"button_one.png" inButton:button_one withState:UIControlStateNormal];
    [SKUIUtils didLoadImageNotCached:@"button_one_s.png" inButton:button_one withState:UIControlStateHighlighted];
    [self addSubview:button_one];
    
    UIButton *button_two = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_two setFrame:CGRectMake(button_one.frame.origin.x + button_one.frame.size.width, button_one.frame.origin.y, button_one.frame.size.width, button_one.frame.size.height)];
    [SKUIUtils didLoadImageNotCached:@"button_two.png" inButton:button_two withState:UIControlStateNormal];
    [SKUIUtils didLoadImageNotCached:@"button_two_s.png" inButton:button_two withState:UIControlStateHighlighted];
    [self addSubview:button_two];
    
    UIButton *button_three = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_three setFrame:CGRectMake(button_two.frame.origin.x + button_two.frame.size.width, button_two.frame.origin.y, button_two.frame.size.width, button_two.frame.size.height)];
    [SKUIUtils didLoadImageNotCached:@"button_three_s.png" inButton:button_three withState:UIControlStateNormal];
    [SKUIUtils didLoadImageNotCached:@"button_three.png" inButton:button_three withState:UIControlStateHighlighted];
    [self addSubview:button_three];
    
    UIButton *button_four = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_four setFrame:CGRectMake(button_three.frame.origin.x + button_three.frame.size.width, button_three.frame.origin.y, button_three.frame.size.width, button_three.frame.size.height)];
    [SKUIUtils didLoadImageNotCached:@"button_four.png" inButton:button_four withState:UIControlStateNormal];
    [SKUIUtils didLoadImageNotCached:@"button_four_s.png" inButton:button_four withState:UIControlStateHighlighted];
    [self addSubview:button_four];
    
    UIButton *button_five = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_five setFrame:CGRectMake(button_four.frame.origin.x + button_four.frame.size.width, button_four.frame.origin.y, button_four.frame.size.width, button_four.frame.size.height)];
    [SKUIUtils didLoadImageNotCached:@"button_five.png" inButton:button_five withState:UIControlStateNormal];
    [SKUIUtils didLoadImageNotCached:@"button_five_s.png" inButton:button_five withState:UIControlStateHighlighted];
    [self addSubview:button_five];
}

@end
