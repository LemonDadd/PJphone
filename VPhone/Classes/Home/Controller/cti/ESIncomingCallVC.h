//
//  ESIncomingCallVC.h
//  VPhone
//
//  Created by 赖长宽 on 2017/10/23.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESManagerDelegate<NSObject>

@optional

-(void)diss;


@end

@interface ESIncomingCallVC : UIViewController
@property (assign, nonatomic) NSInteger  call_Id;
@property (nonatomic,copy) NSString * phoneNumber;
@property (nonatomic,assign) id <ESManagerDelegate>ESManagerDelegate;




@end
