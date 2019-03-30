//
//  ESCTILoginVC.m
//  VPhone
//
//  Created by 赖长宽 on 2017/10/19.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "ESCTILoginVC.h"


@interface ESCTILoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *severTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *WorkNumTF;

@end

@implementation ESCTILoginVC

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)binding:(id)sender {
    
    self.CTIBlock(YES,_severTF.text,_passwordTF.text,_WorkNumTF.text);
}
- (IBAction)blackBtn:(id)sender {
    
    [self removeFromSuperview];
    
}

@end
