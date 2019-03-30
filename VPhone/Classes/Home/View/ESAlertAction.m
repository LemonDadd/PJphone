//
//  ESAlertAction.m
//  VPhone
//
//  Created by 赖长宽 on 2018/12/24.
//  Copyright © 2018年 changkuan.lai.com. All rights reserved.
//

#import "ESAlertAction.h"

@interface ESAlertAction()

@property (nonatomic,copy) NSString * tisName;

@property (nonatomic,copy) NSString * pNum;

@property (nonatomic,strong)   UIAlertController *alertController;

@property (nonatomic,strong)  UITextField *accountTextField;

@property (assign, nonatomic) NSInteger  call_Id;


@end

@implementation ESAlertAction

-(void)AlertViewstr:(NSString *)tis call_Id:(NSInteger)call_Id
{
    
    __weak typeof(self) weakSelf = self;
    UIViewController * vi = [self presentingVC];
    _alertController=[UIAlertController alertControllerWithTitle:tis message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [_alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder=[NSString stringWithFormat:@"输入%@号码",tis];
        weakSelf.accountTextField=textField;
        
        [ weakSelf.accountTextField addTarget:weakSelf action:@selector(getTextFile:) forControlEvents:UIControlEventEditingChanged];
        
        UIAlertAction *act1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
            if ([tis isEqualToString:@"会议"]) {
                BOOL ismakeCall= [[ESPJPhone sharedESPJPhone]ESClientMakeCall:weakSelf.pNum];
                if (ismakeCall) [ESPJPhone sharedESPJPhone].isConferenceCall=YES;
            }else{
                [[ESPJPhone sharedESPJPhone] ESClientReferCall:weakSelf.pNum connId:[NSString stringWithFormat:@"%ld",(long)call_Id]];
            }
            
        }];
        UIAlertAction *act2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [weakSelf.alertController addAction:act1];
        [weakSelf.alertController addAction:act2];
        [vi presentViewController:weakSelf.alertController animated:YES completion:^{
            
        }];
        
        
    }];
}

-(void)getTextFile:(UITextField *)tf
{
    _pNum=tf.text;
}

-(UIViewController*)presentingVC
{
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            
            
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITableViewController class]]) {
        result = [(UITabBarController *)result selectedViewController];
        
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

@end
