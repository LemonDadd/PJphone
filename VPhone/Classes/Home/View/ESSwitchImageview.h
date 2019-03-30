//
//  ESSwitchImageview.h
//  VPhone
//
//  Created by 赖长宽 on 2017/10/24.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSwitchImageview : UIImageView

-(instancetype)initWithOnImageName:(NSString*)imagename offImageName:(NSString*)imageName;


-(void)isLogin:(BOOL)isLogin;


-(void)isReady:(BOOL)isReady;


@end
