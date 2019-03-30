//
//  XFZTabBar.m
//  Bird_LOVE_Sheep
//
//  Created by mac on 16/9/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ESTabBar.h"

@interface ESTabBar ()

@property (nonatomic ,strong) UIButton *publishButton;

@end

@implementation ESTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame]) {
//        self.publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
//        [self.publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
//        [self.publishButton addTarget:self action:@selector(publshClick) forControlEvents:UIControlEventTouchUpInside];
//
//        [self addSubview:self.publishButton];
      
        
    }
    return self;
}
-(void)publshClick
{
//    XFZPublishViewcontroller *publish=[[XFZPublishViewcontroller alloc]init];
//    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:NO completion:nil];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    设置发布按钮位置
//    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
////
////
//    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
//
    
//    设置其他UITabBarButtondeframe
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / 3;
    CGFloat buttonH = self.height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
//        if (![button isKindOfClass:[UIControl class]]) continue;
        
//       计算按钮的X值
        CGFloat buttonX = buttonW *  (index>1?index+1:index);
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        NSLog(@"---%@--",button);
        
        index++;
    }
}

@end
