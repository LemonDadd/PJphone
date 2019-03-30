//
//  ESMoreVC.m
//  VPhone
//
//  Created by 赖长宽 on 2018/1/12.
//  Copyright © 2018年 changkuan.lai.com. All rights reserved.
//

#import "ESMoreVC.h"
//#import "PJPhone.h"
#import "ESLoginVC.h"
#import "AppDelegate.h"
@interface ESMoreVC ()

@end

@implementation ESMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否退出当前账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
  
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        exit(0);
//
//        if ([[PJPhone sharedPJPhone]deleteAcc]) {
//
//            ESLoginVC * lvc =[[ESLoginVC alloc]init];
//
//
//            UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//            if (window.windowLevel != UIWindowLevelNormal){
//
//
//                NSArray *windows = [[UIApplication sharedApplication] windows];
//                for(UIWindow * tmpWin in windows){
//
//
//                    if (tmpWin.windowLevel == UIWindowLevelNormal){
//                        window.rootViewController=lvc;
//                        break;
//                    }
//                }
//
//            }
//        }
        
      
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
