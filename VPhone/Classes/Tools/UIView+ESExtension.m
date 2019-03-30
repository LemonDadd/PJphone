//
//  UIView+XFZExtension.m
//  Bird_LOVE_Sheep
//
//  Created by mac on 16/9/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIView+ESExtension.h"

@implementation UIView (ESExtension)

-(void)setWidth:(CGFloat)width
{ CGRect fraom=self.frame;
    fraom.size.width=width;
    
    self.frame=fraom;

}
-(void)setHeight:(CGFloat)height
{
    CGRect fraom=self.frame;
    fraom.size.height=height;
    
    self.frame=fraom;

}
-(void)setX:(CGFloat)x
{
    CGRect fraom=self.frame;
    fraom.origin.x=x;
    
    self.frame=fraom;
}

-(void)setY:(CGFloat)y
{
    CGRect fraom=self.frame;
    fraom.origin.y=y;
    
    self.frame=fraom;

}
-(void)setSize:(CGSize)size
{

    CGRect fraom=self.frame;
    fraom.size=size;
    
    self.frame=fraom;
}
-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center=self.center;
    center.x=centerX;
    self.center=center;
}
-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center=self.center;
    center.y=centerY;
    self.center=center;

}


-(CGFloat)width
{
    return self.frame.size.width;
}
-(CGFloat)height
{
    return self.frame.size.height;

}
-(CGFloat)x
{

    return self.frame.origin.x;
}
-(CGFloat)y
{

    return self.frame.origin.y;
}
-(CGSize)size
{

    return self.frame.size;
}

-(CGFloat)centerY
{
    return self.center.y;

}

-(CGFloat)centerX
{
    return self.center.x;
}


+(instancetype)viewFromXib
{

    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (BOOL)isShowingOnKeyWindow
{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //以主窗口为坐标原点，计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    //主窗口的bounds 和 self的矩形框 是否重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

@end
