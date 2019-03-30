//
//  XFZVerticalButton.m
//  Bird_LOVE_Sheep
//
//  Created by mac on 16/10/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ESVerticalButton.h"

@implementation ESVerticalButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setup
{

    self.titleLabel.textAlignment=NSTextAlignmentCenter;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self=[super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib
{ [super awakeFromNib];
    [self setup];
}
-(void)layoutSubviews
{
    
    [super layoutSubviews];
//     调整按钮图片
    self.imageView.x=0;
    self.imageView.y=0;
    self.imageView.width=self.width;
    self.imageView.height=self.imageView.width;
//    调整按钮文字
    self.titleLabel.x=0;
    self.titleLabel.y=self.imageView.height+15;
    self.titleLabel.width=self.width;
    self.titleLabel.height=self.height-self.titleLabel.y+15;

}


@end
