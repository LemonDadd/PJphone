//
//  ESCTILoginVC.h
//  VPhone
//
//  Created by 赖长宽 on 2017/10/19.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESCTILoginVC : UIView

@property (nonatomic, strong) void(^CTIBlock)(BOOL,NSString *,NSString*,NSString*);

@property (weak, nonatomic) IBOutlet UIView *satView;


@end
