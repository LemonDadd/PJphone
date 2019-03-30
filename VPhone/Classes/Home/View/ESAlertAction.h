//
//  ESAlertAction.h
//  VPhone
//
//  Created by 赖长宽 on 2018/12/24.
//  Copyright © 2018年 changkuan.lai.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ESAlertAction : NSObject


-(void)AlertViewstr:(NSString *)tis call_Id:(NSInteger)call_Id;




-(UIViewController*)presentingVC;

@end

NS_ASSUME_NONNULL_END
