//
//  UIBarButtonItem+XFZUIBarButtonItem.m
//  Bird_LOVE_Sheep
//
//  Created by mac on 16/9/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIBarButtonItem+XFZUIBarButtonItem.h"

@implementation UIBarButtonItem (XFZUIBarButtonItem)

+(instancetype)itemWithImage:(NSString *)Image heightImage:(NSString *)seimage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:seimage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc]initWithCustomView:button];
}


@end
