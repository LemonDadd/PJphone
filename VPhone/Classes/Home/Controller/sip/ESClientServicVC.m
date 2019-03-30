//
//  ESClientServicVC.m
//  VPhone
//
//  Created by 赖长宽 on 2018/1/12.
//  Copyright © 2018年 changkuan.lai.com. All rights reserved.
//

#import "ESClientServicVC.h"
//#import "PJPhone.h"
#import "ESDailingVC.h"
@interface ESClientServicVC ()
@property (nonatomic,strong)  UITextField *accountTextField;

@end

@implementation ESClientServicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [[PJPhone sharedPJPhone]ESClientMakeCall:@"7001"];
   
    
}
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//
//
//
//
//}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake( 120 , 200, 140, 40)];
    
    label.text=@"默认拨打7001";
    label.textColor=[UIColor blackColor];
    [self.view addSubview:label];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否拨打客服热线" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        _accountTextField=textField;
        textField.placeholder=@"请输入客服热线号码";
        textField.text=@"500019003";
        
    }];

    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (!_accountTextField.hasText) return ;
        ESDailingVC *dailvc= [[ESDailingVC alloc]init];
        dailvc.phoneNum=_accountTextField.text;
        
        [self presentViewController:dailvc animated:YES completion:nil];
        [[ESPJPhone sharedESPJPhone]ESClientMakeCall:_accountTextField.text];
       
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
